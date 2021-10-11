object FrmPrinc: TFrmPrinc
  Left = 236
  Top = 127
  Width = 831
  Height = 660
  Caption = #1052#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1077' '#1076#1074#1080#1078#1077#1085#1080#1103' '#1089#1085#1072#1088#1103#1076#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 120
  TextHeight = 16
  object PB: TPaintBox
    Left = 0
    Top = 0
    Width = 823
    Height = 371
    Align = alClient
    OnPaint = PBPaint
  end
  object gbParams: TGroupBox
    Left = 0
    Top = 371
    Width = 823
    Height = 261
    Align = alBottom
    Caption = '  Parameters  '
    TabOrder = 0
    object Label1: TLabel
      Left = 20
      Top = 30
      Width = 54
      Height = 16
      Caption = 'Univers'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 207
      Top = 30
      Width = 67
      Height = 16
      Caption = 'Projectile'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 394
      Top = 30
      Width = 132
      Height = 16
      Caption = 'Conditions initiales'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 581
      Top = 30
      Width = 148
      Height = 16
      Caption = 'Temps d'#39'observation'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BtnLancer: TButton
      Left = 208
      Top = 177
      Width = 145
      Height = 24
      Caption = '&Start'
      TabOrder = 0
      OnClick = BtnLancerClick
    end
    object EdtGravity: TLabeledEdit
      Left = 20
      Top = 79
      Width = 149
      Height = 21
      EditLabel.Width = 89
      EditLabel.Height = 16
      EditLabel.Caption = 'Gravite (m/s?) :'
      TabOrder = 1
      Text = '9.81'
    end
    object EdtWindSpeed: TLabeledEdit
      Left = 20
      Top = 128
      Width = 149
      Height = 21
      EditLabel.Width = 130
      EditLabel.Height = 16
      EditLabel.Caption = 'Vitesse du vent (m/s) :'
      TabOrder = 2
      Text = '5.0'
    end
    object EdtWindAngle: TLabeledEdit
      Left = 20
      Top = 177
      Width = 149
      Height = 21
      EditLabel.Width = 102
      EditLabel.Height = 16
      EditLabel.Caption = 'Angle du vent ('#176') :'
      TabOrder = 3
      Text = '180'
    end
    object EdtMass: TLabeledEdit
      Left = 207
      Top = 79
      Width = 149
      Height = 21
      EditLabel.Width = 73
      EditLabel.Height = 16
      EditLabel.Caption = 'Masse (kg) :'
      TabOrder = 4
      Text = '1.50'
    end
    object EdtCoeff: TLabeledEdit
      Left = 207
      Top = 128
      Width = 149
      Height = 21
      EditLabel.Width = 154
      EditLabel.Height = 16
      EditLabel.Caption = 'Coeff de frottement (kg/s) :'
      TabOrder = 5
      Text = '1.0'
    end
    object EdtInitX: TLabeledEdit
      Left = 394
      Top = 79
      Width = 149
      Height = 21
      EditLabel.Width = 87
      EditLabel.Height = 16
      EditLabel.Caption = 'Position X (m) :'
      TabOrder = 6
      Text = '0.0'
    end
    object EdtInitY: TLabeledEdit
      Left = 394
      Top = 128
      Width = 149
      Height = 21
      EditLabel.Width = 88
      EditLabel.Height = 16
      EditLabel.Caption = 'Position Y (m) :'
      TabOrder = 7
      Text = '0.0'
    end
    object EdtInitSpeed: TLabeledEdit
      Left = 394
      Top = 177
      Width = 149
      Height = 21
      EditLabel.Width = 143
      EditLabel.Height = 16
      EditLabel.Caption = 'Vitesse de lancer (m/s) :'
      TabOrder = 8
      Text = '60.0'
    end
    object EdtInitAngle: TLabeledEdit
      Left = 394
      Top = 226
      Width = 149
      Height = 21
      EditLabel.Width = 115
      EditLabel.Height = 16
      EditLabel.Caption = 'Angle de lancer ('#176') :'
      TabOrder = 9
      Text = '70'
    end
    object EdtBeginTime: TLabeledEdit
      Left = 581
      Top = 79
      Width = 149
      Height = 21
      EditLabel.Width = 122
      EditLabel.Height = 16
      EditLabel.Caption = 'Temps du debut (s) :'
      TabOrder = 10
      Text = '0'
    end
    object EdtEndTime: TLabeledEdit
      Left = 581
      Top = 128
      Width = 149
      Height = 21
      EditLabel.Width = 102
      EditLabel.Height = 16
      EditLabel.Caption = 'Temps de fin (s) :'
      TabOrder = 11
      Text = '5'
    end
    object EdtDeltaTime: TLabeledEdit
      Left = 581
      Top = 177
      Width = 149
      Height = 21
      EditLabel.Width = 106
      EditLabel.Height = 16
      EditLabel.Caption = 'Pas du temps (s) :'
      TabOrder = 12
      Text = '0.05'
    end
  end
end
