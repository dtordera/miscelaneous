object _marques: T_marques
  Left = 776
  Top = 326
  Width = 608
  Height = 540
  Caption = 'marques'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefaultPosOnly
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object v: TUDBView
    Left = 0
    Top = 14
    Width = 600
    Height = 486
    LoseFocus = False
    ShowHBar = True
    Rounded = False
    Kind = uvNormal
    Align = alClient
    Data.Connection = dm.CG
    Data.Table = 'marques'
    Data.PrimaryKey = 'id'
    Data.SFilterKind = fkProgressive
    OnReturn = vReturn
    OnDelete = vDelete
    OnInsert = vInsert
    EscClose = True
    PopupMenu = PopupMenu1
    OnGetFocus = vGetFocus
    TabOrder = 0
    Caption.Fixed = 'marques'
    Caption.Separator = ' * '
    Caption.Control = lbCaption
    Look.FixedRowVAlign = vaTop
    Look.FixedRow = clNavy
    Look.FixedRowHeight = 23
    Look.FixedRowFont.Charset = DEFAULT_CHARSET
    Look.FixedRowFont.Color = clWhite
    Look.FixedRowFont.Height = -12
    Look.FixedRowFont.Name = 'Arial'
    Look.FixedRowFont.Style = []
    Look.Odd = 13164518
    Look.Even = 13558760
    Look.DataRowHeight = 18
    Look.DataFont.Charset = DEFAULT_CHARSET
    Look.DataFont.Color = 10526880
    Look.DataFont.Height = -13
    Look.DataFont.Name = 'Arial'
    Look.DataFont.Style = []
    Look.Border = False
    Look.BorderColor = clBlack
    Look.Focused = 33023
    Look.Selected = clNavy
    Look.BackColor = clBtnFace
    DblClickAsEnter = True
  end
  object pCaption: TFPanel
    Left = 0
    Top = 0
    Width = 600
    Height = 14
    Align = alTop
    Borders = []
    BorderColor = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    TabOrder = 1
    object lbCaption: TLabel
      Left = 0
      Top = 0
      Width = 43
      Height = 12
      Caption = 'marques'
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 130
    Top = 70
    object AplicarfilteracolumnaF81: TMenuItem
      Caption = 'Aplicar filter a columna (F8)'
      OnClick = AplicarfilteracolumnaF81Click
    end
    object Aplicarfiltre1: TMenuItem
      Caption = 'Aplicar filtre a taula (F9)'
      OnClick = Aplicarfiltre1Click
    end
    object Eliminarfiltre1: TMenuItem
      Caption = 'Eliminar filtre / Actualitzar (F11)'
      OnClick = Eliminarfiltre1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Novamarca: TMenuItem
      Caption = 'Nova marca (Insert)'
      OnClick = Novamarca1Click
    end
    object Modificar1: TMenuItem
      Caption = 'Modificar (Return)'
      OnClick = Modificar1Click
    end
    object EliminarRegistre1: TMenuItem
      Caption = 'Eliminar registre (Supr)'
      OnClick = Eliminarregistre1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Tornarllistaprvia1: TMenuItem
      Caption = 'Tornar (llista pr'#232'via)'
      OnClick = Tornarllistaprvia1Click
    end
  end
end
