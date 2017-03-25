object _vresum: T_vresum
  Left = 633
  Top = 260
  Width = 317
  Height = 650
  Caption = 'Resum'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Courier'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 120
  TextHeight = 16
  object m: TMemo
    Left = 0
    Top = 0
    Width = 309
    Height = 585
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    Ctl3D = False
    Lines.Strings = (
      'm')
    ParentCtl3D = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object MainMenu1: TMainMenu
    Left = 150
    Top = 40
    object Opcions1: TMenuItem
      Caption = 'Opcions'
      object Imprimir1: TMenuItem
        Caption = 'Imprimir (impresora de tickets)'
        OnClick = Imprimir1Click
      end
      object Imprimirimpresoradefulls1: TMenuItem
        Caption = 'Imprimir (impresora per defecte)'
        OnClick = Imprimirimpresoradefulls1Click
      end
      object Guardaraarchiu1: TMenuItem
        Caption = 'Guardar a archiu'
        OnClick = Guardaraarchiu1Click
      end
      object Copiar1: TMenuItem
        Caption = 'Copiar'
        OnClick = Copiar1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Tancar1: TMenuItem
        Caption = 'Tancar'
        OnClick = Tancar1Click
      end
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '*.txt'
    Filter = 'Fitxers de texte (*.txt)|*.txt|Tots els fitxers (*.*)|*.*'
    Left = 220
    Top = 90
  end
end
