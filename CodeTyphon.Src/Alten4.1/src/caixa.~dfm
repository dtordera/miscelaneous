object _caixa: T_caixa
  Left = 556
  Top = 232
  Width = 608
  Height = 625
  BorderStyle = bsSizeToolWin
  Caption = 'caixa'
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
    Top = 251
    Width = 600
    Height = 3
    Cursor = crVSplit
    Align = alTop
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
      Width = 26
      Height = 12
      Caption = 'caixa'
    end
  end
  object v: TUDBView
    Left = 0
    Top = 14
    Width = 600
    Height = 237
    Cursor = crHandPoint
    LoseFocus = False
    ShowHBar = True
    Rounded = False
    Kind = uvNormal
    Align = alTop
    Data.Connection = dm.CG
    Data.Table = 'torns_caixa'
    Data.PrimaryKey = 'id'
    Data.SFilterKind = fkProgressive
    DateTimeFormat = 'ddddd (h:nn)'
    FloatFormat = '0.00'
    OnDrawRow = vDrawRow
    EscClose = True
    PopupMenu = PopupMenu
    OnGetFocus = vGetFocus
    TabOrder = 1
    Caption.Fixed = 'caixa'
    Caption.Separator = ' (torns) * '
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
    Top = 254
    Width = 600
    Height = 331
    Cursor = crHandPoint
    LoseFocus = False
    ShowHBar = True
    Rounded = False
    Kind = uvNormal
    Align = alClient
    Data.Connection = dm.CG
    Data.Table = 'c_caixa'
    Data.PrimaryKey = 'id'
    Data.SFilterKind = fkProgressive
    DateTimeFormat = 'h:nn'
    FloatFormat = '0.00'
    OnDrawRow = vCDrawRow
    EscClose = True
    PopupMenu = PopupMenu
    OnGetFocus = vGetFocus
    TabOrder = 2
    Caption.Fixed = 'caixa'
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
    object Tornobert2: TMenuItem
      Caption = 'Torn obert'
      OnClick = Tornobert2Click
    end
    object Entradaacaixa1: TMenuItem
      Caption = 'Entrada directa a caixa (F3)'
      OnClick = Entradaacaixa1Click
    end
    object Obrircaixa1: TMenuItem
      Caption = 'Obrir caixa (F4)'
      OnClick = Obrircaixa1Click
    end
    object Tancartorn1: TMenuItem
      Caption = 'Tancar torn'
      OnClick = Tancartorn1Click
    end
    object Obrirnoutorn1: TMenuItem
      Caption = 'Obrir nou torn'
      OnClick = Obrirnoutorn1Click
    end
    object Reobrirtorn1: TMenuItem
      Caption = 'Reobrir torn'
      OnClick = Reobrirtorn1Click
    end
    object Resumdetorn1: TMenuItem
      Caption = 'Resum de torn'
      OnClick = Resumdetorn1Click
    end
    object Comentari1: TMenuItem
      Caption = 'Comentari'
      OnClick = Comentari1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Anara1: TMenuItem
      Caption = 'Anar a ...'
      object VentesRelacionades1: TMenuItem
        Caption = 'venta relacionada'
        OnClick = VentesRelacionades1Click
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
      object Entradesdirectes1: TMenuItem
        Caption = 'Entrades directes (tots els torns)'
        OnClick = Entradesdirectes1Click
      end
      object Entradesdirectestornactiu1: TMenuItem
        Caption = 'Entrades directes (torn actiu)'
        OnClick = Entradesdirectestornactiu1Click
      end
      object Abonaments1: TMenuItem
        Caption = 'Abonaments (tots els torns)'
        OnClick = Abonaments1Click
      end
      object Abonamentstornactiu1: TMenuItem
        Caption = 'Abonaments (torn actiu)'
        OnClick = Abonamentstornactiu1Click
      end
    end
  end
end
