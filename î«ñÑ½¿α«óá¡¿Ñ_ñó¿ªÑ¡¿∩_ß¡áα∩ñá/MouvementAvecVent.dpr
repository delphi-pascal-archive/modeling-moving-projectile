program MouvementAvecVent;

uses
  Forms,
  UFrmMouvement in 'UFrmMouvement.pas' {FrmPrinc};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrinc, FrmPrinc);
  Application.Run;
end.
