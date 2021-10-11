unit UFrmMouvement;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TFloat = Extended;
  TPositionFloat = record
    X, Y: TFloat;
  end;

  TProjectile = class(TObject)
  private
    FMass: TFloat;
    FCoeff: TFloat; // coefficicent de frottement dans l'air
  public
    property Mass: TFloat read FMass write FMass;
    property Coeff: TFloat read FCoeff write FCoeff;
  end;

  TUnivers = class(TObject)
  private
    FGravity: TFloat;
    FWindSpeed: TFloat;
    FWindAngle: TFloat; // en radian (0 rad = vers la droite)
    function GetWindSpeedX: TFloat;
    function GetWindSpeedY: TFloat;
  public
    property Gravity: TFloat read FGravity write FGravity;
    property WindSpeed: TFloat read FWindSpeed write FWindSpeed;
    property WindAngle: TFloat read FWindAngle write FWindAngle;
    property WindSpeedX: TFloat read GetWindSpeedX;
    property WindSpeedY: TFloat read GetWindSpeedY;
  end;

  TLancerProjectile = class(TObject)
  private
    FUnivers: TUnivers;
    FProjectile: TProjectile;
    FInitPosX: TFloat;
    FInitPosY: TFloat;
    FInitSpeedX: TFloat;
    FInitSpeedY: TFloat;

    FBeta: TFloat;
    FLambda: TFloat;
    FDeltaX: TFloat;
    FDeltaY: TFloat;

    FPosX: TFloat;
    FPosY: TFloat;
  public
    constructor Create(AUnivers: TUnivers; AProjectile: TProjectile);
    procedure SetInitialConditions(const InitX, InitY,
      InitSpeed, InitAngle: TFloat);
    procedure ComputePositionAtTime(ATime: TFloat);
    property PosX: TFloat read FPosX;
    property PosY: TFloat read FPosY;
  end;

  TFrmPrinc = class(TForm)
    gbParams: TGroupBox;
    PB: TPaintBox;
    BtnLancer: TButton;
    Label1: TLabel;
    EdtGravity: TLabeledEdit;
    EdtWindSpeed: TLabeledEdit;
    EdtWindAngle: TLabeledEdit;
    Label2: TLabel;
    EdtMass: TLabeledEdit;
    EdtCoeff: TLabeledEdit;
    Label3: TLabel;
    EdtInitX: TLabeledEdit;
    EdtInitY: TLabeledEdit;
    EdtInitSpeed: TLabeledEdit;
    EdtInitAngle: TLabeledEdit;
    Label4: TLabel;
    EdtBeginTime: TLabeledEdit;
    EdtEndTime: TLabeledEdit;
    EdtDeltaTime: TLabeledEdit;
    procedure BtnLancerClick(Sender: TObject);
    procedure PBPaint(Sender: TObject);
  private
    FTrajectoire: array of TPositionFloat;
    FMinX: TFloat;
    FMinY: TFloat;
    FMaxX: TFloat;
    FMaxY: TFloat;
    procedure ComputeTrajectoire(ALancer: TLancerProjectile;
      AMinTime, AMaxTime, ADeltaTime: TFloat);
  end;

var
  FrmPrinc: TFrmPrinc;

implementation

{$R *.dfm}

{
  ********************************* TUnivers ***********************************
}
function TUnivers.GetWindSpeedX: TFloat;
begin
  Result := FWindSpeed * Cos(FWindAngle);
end;

function TUnivers.GetWindSpeedY: TFloat;
begin
  Result := FWindSpeed * Sin(FWindAngle);
end;

constructor TLancerProjectile.Create(AUnivers: TUnivers;
  AProjectile: TProjectile);
begin
  inherited Create;
  FUnivers := AUnivers;
  FProjectile := AProjectile;
end;

{
  **************************** TLancerProjectile *******************************
}
procedure TLancerProjectile.SetInitialConditions(const InitX, InitY,
  InitSpeed, InitAngle: TFloat);
begin
  FInitPosX := InitX;
  FInitPosY := InitY;
  FInitSpeedX := InitSpeed * Cos(InitAngle);
  FInitSpeedY := InitSpeed * Sin(InitAngle);

  { Calcul des constantes (voir pdf) }
  with FUnivers, FProjectile do
  begin
    FBeta := - Mass * Gravity / Coeff;
    FLambda := - Coeff / Mass;
    FDeltaX := Mass * (FInitSpeedX - WindSpeedX) / Coeff;
    FDeltaY := Mass * (FInitSpeedY - WindSpeedY + FBeta) / Coeff;
  end;
end;

procedure TLancerProjectile.ComputePositionAtTime(ATime: TFloat);
var
  E: TFloat;
begin
  { voir pdf }
  E := Exp(FLambda * ATime);
  FPosX := - FDeltaX * E + FUnivers.WindSpeedX * ATime + FDeltaX + FInitPosX;
  FPosY := - FDeltaY * E + (FUnivers.WindSpeedY + FBeta) * ATime + FDeltaY + FInitPosY;
end;

{
  ********************************* TFrmPrinc **********************************
}
function StrToFloat(const S: string): Extended;
begin
  case DecimalSeparator of
    '.': Result := SysUtils.StrToFloat(StringReplace(S, ',', '.', []));
    ',': Result := SysUtils.StrToFloat(StringReplace(S, '.', ',', []));
  else
    Result := SysUtils.StrToFloat(S);
  end;
end;

procedure TFrmPrinc.BtnLancerClick(Sender: TObject);
var
  U: TUnivers;
  P: TProjectile;
  LP: TLancerProjectile;
begin
  U := TUnivers.Create;
  P := TProjectile.Create;
  LP := TLancerProjectile.Create(U, P);
  try
    U.Gravity := StrToFloat(EdtGravity.Text);
    U.WindSpeed := StrToFloat(EdtWindSpeed.Text);
    U.WindAngle := StrToFloat(EdtWindAngle.Text) * Pi / 180.0;

    P.Mass := StrToFloat(EdtMass.Text);
    P.Coeff := StrToFloat(EdtCoeff.Text);

    LP.SetInitialConditions(StrToFloat(EdtInitX.Text), StrToFloat(EdtInitY.Text),
      StrTofloat(EdtInitSpeed.Text), StrToFloat(EdtInitAngle.Text) * Pi / 180.0);

    ComputeTrajectoire(LP, StrToFloat(EdtBeginTime.Text),
      StrToFloat(EdtEndTime.Text), StrToFloat(EdtDeltaTime.Text));
    PB.Invalidate;
  finally
    LP.Free;
    P.Free;
    U.Free;
  end;
end;

procedure TFrmPrinc.ComputeTrajectoire(ALancer: TLancerProjectile;
  AMinTime, AMaxTime, ADeltaTime: TFloat);
var
  T, X, Y: TFloat;
  I, N: Integer;
begin
  { Initialisation }
  FMinX := 1e100;
  FMinY := 1e100;
  FMaxX := 0.0;
  FMaxY := 0.0;

  { Calcul du nombre d'itérations }
  N := Round((AMaxTime - AMinTime) / ADeltaTime);
  SetLength(FTrajectoire, N);

  { Boucle }
  T := AMinTime;
  for I := 0 to N - 1 do
  begin
    { Calcule la position au temps donné }
    ALancer.ComputePositionAtTime(T);
    X := ALancer.PosX;
    Y := ALancer.PosY;

    { Recherche des extrema }
    if X < FMinX then
      FMinX := X
    else if X > FMaxX then
      FMaxX := X;
    if Y < FMinY then
      FMinY := Y
    else if Y > FMaxY then
      FMaxY := Y;

    { Note la position dans le tableau }
    FTrajectoire[I].X := X;
    FTrajectoire[I].Y := Y;

    { Passe au temps suivant }
    T := T + ADeltaTime;
  end;
end;

procedure TFrmPrinc.PBPaint(Sender: TObject);

  { si Min <= Value <= Max alors NewMin <= Result <= NewMax }
  function Recadre(Value, Min, Max, NewMin, NewMax: TFloat): TFloat;
  begin
    Result := NewMin + (NewMax - NewMin) * (Value - Min) / (Max - Min);
  end;

const
  CMargin = 20;
var
  I: Integer;
  D: TFloat;
  X, Y, X0, Y0: Integer;
  MaxWndX, MaxWndY: Integer;
begin
  if Length(FTrajectoire) = 0 then
    Exit;

  MaxWndX := PB.Width - 2 * CMargin;
  MaxWndY := PB.Height - 2 * CMargin;

  { Dessin de la courbe }
  for I := 0 to High(FTrajectoire) do
  begin
    X := Round(Recadre(FTrajectoire[I].X, FMinX, FMaxX, CMargin, MaxWndX));
    Y := PB.Height - Round(Recadre(FTrajectoire[I].Y, FMinY, FMaxY, CMargin, MaxWndY));
    if I = 0 then
      PB.Canvas.MoveTo(X, Y)
    else
      PB.Canvas.LineTo(X, Y);
  end;

  { Dessin des axes }
  X0 := Round(Recadre(0, FMinX, FMaxX, CMargin, MaxWndX));
  Y0 := PB.Height - Round(Recadre(0, FMinY, FMaxY, CMargin, MaxWndY));
  with PB.Canvas do
  begin
    { Abscisses }
    MoveTo(0, Y0);
    LineTo(PB.Width, Y0);

    { Ordonnées }
    MoveTo(X0, PB.Height);
    LineTo(X0, 0);
  end;

  { Echelles }
  for I := 0 to 4 do
  begin
    D := FMinX + I * (FMaxX - FMinX) / 4;
    X := Round(Recadre(D, FMinX, FMaxX, CMargin, MaxWndX));
    PB.Canvas.MoveTo(X, Y0 - 1);
    PB.Canvas.LineTo(X, Y0 + 2);
    PB.Canvas.TextOut(X, Y0 + 3, Format('%.2f m', [D]));
  end;
  for I := 0 to 4 do
  begin
    D := FMinY + I * (FMaxY - FMinY) / 4;
    Y := PB.Height - Round(Recadre(D, FMinY, FMaxY, CMargin, MaxWndY));
    PB.Canvas.MoveTo(X0 - 1, Y);
    PB.Canvas.LineTo(X0 + 2, Y);
    PB.Canvas.TextOut(X0 + 3, Y, Format('%.2f m', [D]));
  end;
end;

end.
