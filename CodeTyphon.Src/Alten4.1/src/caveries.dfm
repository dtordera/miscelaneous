object _caveries: T_caveries
  Left = 776
  Top = 326
  Width = 608
  Height = 540
  Caption = 'conceptes averies'
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
  object Splitter2: TSplitter
    Left = 0
    Top = 247
    Width = 600
    Height = 3
    Cursor = crVSplit
    Align = alBottom
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
    TabOrder = 0
    object lbCaption: TLabel
      Left = 0
      Top = 0
      Width = 89
      Height = 12
      Caption = 'conceptes averies'
    end
  end
  object vCArt: TUDBView
    Left = 0
    Top = 14
    Width = 600
    Height = 233
    Cursor = crHandPoint
    LoseFocus = False
    ShowHBar = True
    Rounded = False
    Kind = uvNormal
    Align = alClient
    Data.Connection = dm.CG
    Data.Table = 'c_aveart'
    Data.PrimaryKey = 'id'
    Data.SFilterKind = fkProgressive
    OnDblClick = vCArtDblClick
    EscClose = True
    PopupMenu = PopupMenu
    OnGetFocus = vGetFocus
    TabOrder = 1
    Caption.Fixed = 'conceptes averies'
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
  object vCInt: TUDBView
    Left = 0
    Top = 250
    Width = 600
    Height = 250
    Cursor = crHandPoint
    LoseFocus = False
    ShowHBar = True
    Rounded = False
    Kind = uvNormal
    Align = alBottom
    Data.Connection = dm.CG
    Data.Table = 'c_aveint'
    Data.PrimaryKey = 'id'
    Data.SFilterKind = fkProgressive
    OnDblClick = vCArtDblClick
    EscClose = True
    PopupMenu = PopupMenu
    OnGetFocus = vGetFocus
    TabOrder = 2
    Caption.Fixed = 'conceptes averies'
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
  object PopupMenu: TPopupMenu
    OnPopup = PopupMenuPopup
    Left = 100
    Top = 90
    object AplicarfiltreacolumnaF81: TMenuItem
      Caption = 'Aplicar filtre a columna (F8)'
      OnClick = AplicarfiltreacolumnaF81Click
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
    object Anara1: TMenuItem
      Caption = 'Anar a ...'
      object Articlerelacionat1: TMenuItem
        Caption = 'Article relacionat'
        OnClick = Articlerelacionat1Click
      end
      object Magatzemrelacionat1: TMenuItem
        Caption = 'Magatzem relacionat'
        OnClick = Magatzemrelacionat1Click
      end
    end
    object Tornarllistaprvia1: TMenuItem
      Caption = 'Tornar (llista pr'#232'via) '
      OnClick = Tornarllistaprvia1Click
    end
  end
end
