object _etorns: T_etorns
  Left = 679
  Top = 429
  Width = 214
  Height = 277
  AutoSize = True
  Caption = 'Torns de caixa'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object dOBERTURA: TMCEdit
    Left = 0
    Top = 0
    Width = 206
    Height = 237
    Mask = '!99/99/\2\000;1;_'
    AutoSize = False
    Date = 40554.065824108790000000
    object TButton
      Left = 1
      Top = 206
      Width = 204
      Height = 30
      Caption = '&Ok'
      Default = True
      ModalResult = 1
      TabOrder = 5
    end
    object TButton
      Left = 1
      Top = 206
      Width = 204
      Height = 30
      Caption = '&Ok'
      Default = True
      ModalResult = 1
      TabOrder = 4
    end
    object TButton
      Left = 1
      Top = 206
      Width = 204
      Height = 30
      Caption = '&Ok'
      Default = True
      ModalResult = 1
      TabOrder = 3
    end
    object btOk: TButton
      Left = 1
      Top = 206
      Width = 204
      Height = 30
      Caption = '&Obrir torn'
      Default = True
      ModalResult = 1
      TabOrder = 2
    end
  end
end
