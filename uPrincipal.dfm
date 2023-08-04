object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Consulta API de Usu'#225'rio Aleat'#243'rios'
  ClientHeight = 457
  ClientWidth = 559
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblUrl: TLabel
    Left = 8
    Top = 5
    Width = 59
    Height = 13
    Caption = 'URL TOKEN:'
  end
  object Label1: TLabel
    Left = 8
    Top = 50
    Width = 33
    Height = 13
    Caption = 'Token:'
  end
  object Label2: TLabel
    Left = 8
    Top = 98
    Width = 57
    Height = 13
    Caption = 'URL LOGIN:'
  end
  object editUrlToken: TEdit
    Left = 8
    Top = 24
    Width = 401
    Height = 21
    TabOrder = 0
    Text = 'http://localhost/server-api-teste/src/auth/token.php'
  end
  object btnToken: TBitBtn
    Left = 437
    Top = 22
    Width = 114
    Height = 25
    Caption = 'GERA TOKEN'
    TabOrder = 1
    OnClick = btnTokenClick
  end
  object mmResultado: TMemo
    Left = 8
    Top = 176
    Width = 543
    Height = 273
    TabOrder = 2
  end
  object editToken: TEdit
    Left = 8
    Top = 69
    Width = 401
    Height = 21
    TabOrder = 3
  end
  object btnLogin: TBitBtn
    Left = 437
    Top = 115
    Width = 114
    Height = 25
    Caption = 'LOGIN'
    TabOrder = 4
    OnClick = btnLoginClick
  end
  object editUrlLogin: TEdit
    Left = 8
    Top = 117
    Width = 401
    Height = 21
    TabOrder = 5
    Text = 'http://localhost/server-api-teste/src/login/login.php'
  end
end
