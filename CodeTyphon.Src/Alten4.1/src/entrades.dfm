object _entrades: T_entrades
  Left = 855
  Top = 319
  Width = 608
  Height = 540
  BorderStyle = bsSizeToolWin
  Caption = 'entrades'
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
  object Splitter1: TSplitter
    Left = 0
    Top = 257
    Width = 600
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  object Splitter2: TSplitter
    Left = 0
    Top = 255
    Width = 600
    Height = 2
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
      Width = 44
      Height = 12
      Caption = 'entrades'
    end
  end
  object v: TUDBView
    Left = 0
    Top = 14
    Width = 600
    Height = 241
    LoseFocus = False
    ShowHBar = True
    Rounded = False
    Kind = uvNormal
    Align = alClient
    Data.Connection = dm.CG
    Data.Table = 'entrades'
    Data.PrimaryKey = 'id'
    Data.SFilterKind = fkProgressive
    DateTimeFormat = 'ddddd'
    FloatFormat = '0.00'
    OnDrawRow = vDrawRow
    OnReturn = vReturn
    OnDelete = vDelete
    OnInsert = vInsert
    EscClose = True
    PopupMenu = PopupMenu1
    OnGetFocus = vGetFocus
    TabOrder = 1
    Caption.Fixed = 'entrades'
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
  object vC: TUDBView
    Left = 0
    Top = 260
    Width = 600
    Height = 240
    LoseFocus = False
    ShowHBar = True
    Rounded = False
    Kind = uvNormal
    Align = alBottom
    Data.Connection = dm.CG
    Data.Table = 'c_entrades'
    Data.PrimaryKey = 'id'
    Data.SFilterKind = fkProgressive
    DateTimeFormat = 'ddddd'
    FloatFormat = '0.00'
    OnDblClick = vCDblClick
    EscClose = True
    PopupMenu = PopupMenu2
    OnGetFocus = vGetFocus
    TabOrder = 2
    Caption.Fixed = 'entrades'
    Caption.Separator = '(conceptes) * '
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
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 90
    Top = 100
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
    object Novaentrada: TMenuItem
      Caption = 'Nova entrada (Insert / N)'
      OnClick = NovaentradaClick
    end
    object Modificar1: TMenuItem
      Caption = 'Modificar (Return / M)'
      OnClick = Modificar1Click
    end
    object Eliminararticle1: TMenuItem
      Caption = 'Eliminar registre (Supr / E)'
      OnClick = Eliminararticle1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Marcarcompagada1: TMenuItem
      Caption = 'Marcar com pagada'
      OnClick = Marcarcompagada1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object Anara1: TMenuItem
      Caption = 'Anar a ...'
      object proveedorrelacionat1: TMenuItem
        Caption = 'proveedor relacionat'
        OnClick = proveedorrelacionat1Click
      end
    end
    object Tornarllistaprvia1: TMenuItem
      Caption = 'Tornar (llista pr'#232'via)'
      OnClick = Tornarllistaprvia1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Filtrespredefinits1: TMenuItem
      Caption = 'Filtres predefinits'
      object Pagades1: TMenuItem
        Caption = 'Pagades'
        OnClick = Pagades1Click
      end
      object entradesdenormalitzaci1: TMenuItem
        Caption = 'entrades de normalitzaci'#243
        OnClick = entradesdenormalitzaci1Click
      end
    end
  end
  object PopupMenu2: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 110
    Top = 300
    object AplicarfiltreacolumnaF82: TMenuItem
      Caption = 'Aplicar filtre a columna (F8)'
      OnClick = AplicarfiltreacolumnaF82Click
    end
    object MenuItem1: TMenuItem
      Caption = 'Aplicar filtre a taula (F9)'
      OnClick = MenuItem1Click
    end
    object MenuItem2: TMenuItem
      Caption = 'Eliminar filtre / Actualitzar (F11)'
      OnClick = MenuItem2Click
    end
    object MenuItem3: TMenuItem
      Caption = '-'
    end
    object MenuItem4: TMenuItem
      Caption = 'Nova entrada (Insert / N)'
      OnClick = NovaentradaClick
    end
    object MenuItem5: TMenuItem
      Caption = 'Modificar (Return / M)'
      OnClick = Modificar1Click
    end
    object MenuItem6: TMenuItem
      Caption = 'Eliminar registre (Supr / E)'
      OnClick = Eliminararticle1Click
    end
    object MenuItem7: TMenuItem
      Caption = '-'
    end
    object MenuItem8: TMenuItem
      Caption = 'Marcar com pagada'
      OnClick = Marcarcompagada1Click
    end
    object MenuItem9: TMenuItem
      Caption = '-'
    end
    object MenuItem10: TMenuItem
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
    object MenuItem12: TMenuItem
      Caption = 'Tornar (llista pr'#232'via)'
      OnClick = Tornarllistaprvia1Click
    end
    object MenuItem13: TMenuItem
      Caption = '-'
    end
    object MenuItem14: TMenuItem
      Caption = 'Filtres predefinits'
      object MenuItem15: TMenuItem
        Caption = 'entrades de normalitzaci'#243
        OnClick = entradesdenormalitzaci1Click
      end
    end
  end
end
