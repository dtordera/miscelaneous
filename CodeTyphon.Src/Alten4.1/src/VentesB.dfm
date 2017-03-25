object _ventesB: T_ventesB
  Left = 692
  Top = 217
  Width = 608
  Height = 610
  AlphaBlend = True
  AlphaBlendValue = 128
  BorderStyle = bsSizeToolWin
  Caption = 'ventes taller'
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
    Top = 328
    Width = 600
    Height = 2
    Cursor = crVSplit
    Align = alBottom
  end
  object v: TUDBView
    Left = 0
    Top = 14
    Width = 600
    Height = 314
    LoseFocus = False
    ShowHBar = True
    Rounded = False
    Kind = uvNormal
    Align = alClient
    Data.Connection = dm.CG
    Data.Table = 'ventesB'
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
    Caption.Fixed = 'ventes taller'
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
    TabOrder = 0
    object lbCaption: TLabel
      Left = 0
      Top = 0
      Width = 63
      Height = 12
      Caption = 'ventes taller'
    end
  end
  object vC: TUDBView
    Left = 0
    Top = 330
    Width = 600
    Height = 240
    LoseFocus = False
    ShowHBar = True
    Rounded = False
    Kind = uvNormal
    Align = alBottom
    Data.Connection = dm.CG
    Data.Table = 'c_ventesB'
    Data.PrimaryKey = 'id'
    Data.SFilterKind = fkProgressive
    DateTimeFormat = 'ddddd'
    FloatFormat = '0.00'
    OnDblClick = vCDblClick
    EscClose = True
    PopupMenu = PopupMenu2
    OnGetFocus = vGetFocus
    TabOrder = 2
    Caption.Fixed = 'ventes taller'
    Caption.Separator = ' (conceptes) * '
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
    Left = 120
    Top = 150
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
    object NovaVenta: TMenuItem
      Caption = 'Nova venta (Insert / N / F2)'
      OnClick = NovaVentaClick
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
    object Veurefactura1: TMenuItem
      Caption = 'Veure factura (I)'
      OnClick = Veurefactura1Click
    end
    object ImprimirTicket1: TMenuItem
      Caption = 'Imprimir ticket'
      OnClick = ImprimirTicket1Click
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object Abonar1: TMenuItem
      Caption = 'Abonar'
      OnClick = Abonar1Click
    end
    object Veureabonaments1: TMenuItem
      Caption = 'Veure abonaments'
      OnClick = Veureabonaments1Click
    end
    object Cobrar1: TMenuItem
      Caption = 'Cobrar'
      OnClick = Cobrar1Click
    end
    object Modificacipuntual1: TMenuItem
      Caption = 'Modificaci'#243' puntual'
      OnClick = Modificacipuntual1Click
    end
    object Feraveria1: TMenuItem
      Caption = 'Fer averia'
      OnClick = Feraveria1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Anara2: TMenuItem
      Caption = 'Anar a ...'
      object Clientrelacionat1: TMenuItem
        Caption = 'Client relacionat'
        OnClick = Clientrelacionat1Click
      end
      object Averiarelacionada1: TMenuItem
        Caption = 'Averia relacionada'
        OnClick = Averiarelacionada1Click
      end
      object pressupostrelacionat1: TMenuItem
        Caption = 'Pressupost relacionat'
        OnClick = pressupostrelacionat1Click
      end
      object Refernciesacaixa1: TMenuItem
        Caption = 'Refer'#232'ncies a caixa'
        OnClick = Refernciesacaixa1Click
      end
    end
    object Tornarllistaprvia1: TMenuItem
      Caption = 'Tornar (llista pr'#232'via)'
      OnClick = Tornarllistaprvia1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object Filtrespredefinits1: TMenuItem
      Caption = 'Filtres predefinits'
      object Pagades1: TMenuItem
        Caption = 'Ventes pagades'
        OnClick = Pagades1Click
      end
      object Ambpendent1: TMenuItem
        Caption = 'Amb pendent'
        OnClick = Ambpendent1Click
      end
      object Abonades1: TMenuItem
        Caption = 'Amb abonaments'
        OnClick = Abonades1Click
      end
      object Abonaments1: TMenuItem
        Caption = 'Abonaments'
        OnClick = Abonaments1Click
      end
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 190
    Top = 380
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
      Caption = 'Nova venta (Insert / N / F2)'
      OnClick = NovaVentaClick
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
      Caption = 'Veure factura (I)'
      OnClick = Veurefactura1Click
    end
    object MenuItem9: TMenuItem
      Caption = 'Imprimir ticket'
      OnClick = ImprimirTicket1Click
    end
    object MenuItem10: TMenuItem
      Caption = '-'
    end
    object MenuItem11: TMenuItem
      Caption = 'Abonar'
      OnClick = Abonar1Click
    end
    object MenuItem12: TMenuItem
      Caption = 'Cobrar'
      OnClick = Cobrar1Click
    end
    object MenuItem13: TMenuItem
      Caption = '-'
    end
    object MenuItem14: TMenuItem
      Caption = 'Anar a ...'
      object Articlerelacionats1: TMenuItem
        Caption = 'Article relacionat'
        OnClick = Articlerelacionats1Click
      end
      object Magatzemrelacionat1: TMenuItem
        Caption = 'Magatzem relacionat'
        OnClick = Magatzemrelacionat1Click
      end
    end
    object MenuItem19: TMenuItem
      Caption = 'Tornar (llista pr'#232'via)'
      OnClick = Tornarllistaprvia1Click
    end
    object MenuItem20: TMenuItem
      Caption = '-'
    end
    object MenuItem21: TMenuItem
      Caption = 'Filtres predefinits'
      object MenuItem22: TMenuItem
        Caption = 'Pagades'
        OnClick = Pagades1Click
      end
      object MenuItem23: TMenuItem
        Caption = 'Amb pendent'
        OnClick = Ambpendent1Click
      end
      object MenuItem24: TMenuItem
        Caption = 'Abonades'
        OnClick = Abonades1Click
      end
      object MenuItem25: TMenuItem
        Caption = 'Abonaments'
        OnClick = Abonaments1Click
      end
    end
  end
end
