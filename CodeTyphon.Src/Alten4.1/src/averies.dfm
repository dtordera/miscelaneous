object _averies: T_averies
  Left = 759
  Top = 191
  Width = 765
  Height = 722
  BorderStyle = bsSizeToolWin
  Caption = 'averies'
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
    Top = 347
    Width = 757
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  object Splitter2: TSplitter
    Left = 0
    Top = 527
    Width = 757
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  object v: TUDBView
    Left = 0
    Top = 14
    Width = 757
    Height = 333
    Cursor = crHandPoint
    LoseFocus = False
    ShowHBar = True
    Rounded = False
    Kind = uvNormal
    Align = alClient
    Data.Connection = dm.CG
    Data.Table = 'averies'
    Data.PrimaryKey = 'id'
    Data.SFilterKind = fkProgressive
    DateTimeFormat = 'ddddd'
    OnDrawRow = vDrawRow
    OnReturn = vReturn
    OnDelete = vDelete
    OnInsert = vInsert
    EscClose = True
    PopupMenu = PopupMenu1
    OnGetFocus = vGetFocus
    TabOrder = 1
    Caption.Fixed = 'averies'
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
    Width = 757
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
      Width = 37
      Height = 12
      Caption = 'averies'
    end
  end
  object vCInt: TUDBView
    Left = 0
    Top = 530
    Width = 757
    Height = 152
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
    OnClick = vCIntClick
    EscClose = True
    PopupMenu = PopupMenu2
    OnGetFocus = vGetFocus
    TabOrder = 2
    Caption.Fixed = 'averies'
    Caption.Separator = '(intervencions) * '
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
  object vCArt: TUDBView
    Left = 0
    Top = 350
    Width = 757
    Height = 177
    Cursor = crHandPoint
    LoseFocus = False
    ShowHBar = True
    Rounded = False
    Kind = uvNormal
    Align = alBottom
    Data.Connection = dm.CG
    Data.Table = 'c_aveart'
    Data.PrimaryKey = 'id'
    Data.SFilterKind = fkProgressive
    OnDblClick = vCArtDblClick
    EscClose = True
    PopupMenu = PopupMenu2
    OnGetFocus = vGetFocus
    TabOrder = 3
    Caption.Fixed = 'averies'
    Caption.Separator = '(articles) * '
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
    Left = 100
    Top = 90
    object AplicarFiltreColumna: TMenuItem
      Caption = 'Aplicar filtre a columna (F8)'
      OnClick = AplicarFiltreColumnaClick
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
    object Novaaveria: TMenuItem
      Caption = 'Nova averia (Insert / N / F6)'
      OnClick = NovaaveriaClick
    end
    object Modificar1: TMenuItem
      Caption = 'Modificar (Return)'
      OnClick = Modificar1Click
    end
    object Eliminararticle1: TMenuItem
      Caption = 'Eliminar registre (Supr)'
      OnClick = Eliminararticle1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object Veureparte1: TMenuItem
      Caption = 'Veure parte (I)'
      OnClick = Veureparte1Click
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object Facturar1: TMenuItem
      Caption = 'Facturar'
      OnClick = Facturar1Click
    end
    object Visites1: TMenuItem
      Caption = 'Visites'
      OnClick = Visites1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Anara1: TMenuItem
      Caption = 'Anar a ...'
      object dpersonalsrelacionades1: TMenuItem
        Caption = 'Client relacionat'
        OnClick = dpersonalsrelacionades1Click
      end
      object dpersonalsrelacionadesreparador1: TMenuItem
        Caption = 'Reparador relacionat'
        OnClick = dpersonalsrelacionadesreparador1Click
      end
      object Facturaorigenrelacionada1: TMenuItem
        Caption = 'Factura (origen) relacionada'
        OnClick = Facturaorigenrelacionada1Click
      end
      object ventarelacionada1: TMenuItem
        Caption = 'Factura (cobrament) relacionada'
        OnClick = ventarelacionada1Click
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
      object Reparacionspendents1: TMenuItem
        Caption = 'Reparacions pendents'
        OnClick = Reparacionspendents1Click
      end
      object Reparacionsadomicili1: TMenuItem
        Caption = 'Reparacions a domicili'
        OnClick = Reparacionsadomicili1Click
      end
      object Reparacionsexternes1: TMenuItem
        Caption = 'Reparacions externes'
        OnClick = Reparacionsexternes1Click
      end
      object ReparacionsEnviades1: TMenuItem
        Caption = 'Reparacions enviades'
        OnClick = ReparacionsEnviades1Click
      end
    end
  end
  object PopupMenu2: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 210
    Top = 420
    object AplicarfiltreacolumnaF81: TMenuItem
      Caption = 'Aplicar filtre a columna (F8)'
      OnClick = AplicarfiltreacolumnaF81Click
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
      Caption = 'Nova averia (Insert / N / F6)'
      OnClick = NovaaveriaClick
    end
    object MenuItem5: TMenuItem
      Caption = 'Modificar (Return)'
      OnClick = Modificar1Click
    end
    object MenuItem6: TMenuItem
      Caption = 'Eliminar registre (Supr)'
      OnClick = Eliminararticle1Click
    end
    object MenuItem7: TMenuItem
      Caption = '-'
    end
    object MenuItem8: TMenuItem
      Caption = 'Veure parte (I)'
      OnClick = Veureparte1Click
    end
    object MenuItem9: TMenuItem
      Caption = '-'
    end
    object MenuItem10: TMenuItem
      Caption = 'Facturar'
      OnClick = Facturar1Click
    end
    object MenuItem11: TMenuItem
      Caption = '-'
    end
    object MenuItem12: TMenuItem
      Caption = 'Anar a ...'
      object Articlerelacionat1: TMenuItem
        Caption = 'Article relacionat'
        OnClick = Articlerelacionat1Click
      end
    end
    object MenuItem16: TMenuItem
      Caption = 'Tornar (llista pr'#232'via)'
      OnClick = Tornarllistaprvia1Click
    end
    object MenuItem17: TMenuItem
      Caption = '-'
    end
    object MenuItem18: TMenuItem
      Caption = 'Filtres predefinits'
      object MenuItem19: TMenuItem
        Caption = 'Reparacions pendents'
        OnClick = Reparacionspendents1Click
      end
      object MenuItem20: TMenuItem
        Caption = 'Reparacions a domicili'
        OnClick = Reparacionsadomicili1Click
      end
      object MenuItem21: TMenuItem
        Caption = 'Reparacions externes'
        OnClick = Reparacionsexternes1Click
      end
      object MenuItem22: TMenuItem
        Caption = 'Reparacions enviades'
        OnClick = ReparacionsEnviades1Click
      end
    end
  end
end
