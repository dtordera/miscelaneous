object _magatzem: T_magatzem
  Left = 700
  Top = 306
  Width = 608
  Height = 540
  BorderStyle = bsSizeToolWin
  Caption = 'magatzem'
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
      Width = 51
      Height = 12
      Caption = 'magatzem'
    end
  end
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
    Data.Table = 'magatzem'
    Data.PrimaryKey = 'id'
    Data.SFilterKind = fkProgressive
    DateTimeFormat = 'ddddd'
    FloatFormat = '0.00'
    OnDrawRow = vDrawRow
    EscClose = True
    PopupMenu = PopupMenu1
    OnGetFocus = vGetFocus
    TabOrder = 1
    Caption.Fixed = 'magatzem'
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
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 120
    Top = 80
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
    object N3: TMenuItem
      Caption = '-'
    end
    object Seguimentdarticle1: TMenuItem
      Caption = 'Seguiment d'#39'article'
      OnClick = Seguimentdarticle1Click
    end
    object Entradadirectauts1: TMenuItem
      Caption = 'Entrada directa d'#39'unitats'
      OnClick = Entradadirectauts1Click
    end
    object Eliminarregistredemagatzem1: TMenuItem
      Caption = 'Eliminar registre de magatzem'
      OnClick = Eliminarregistredemagatzem1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Anara1: TMenuItem
      Caption = 'Anar a ...'
      object Articlerelacionats1: TMenuItem
        Caption = 'Article relacionat'
        OnClick = Articlerelacionats1Click
      end
      object Ventesrelacionades1: TMenuItem
        Caption = 'Conceptes de ventes relacionats'
        OnClick = Ventesrelacionades1Click
      end
      object Entradesrelacionades1: TMenuItem
        Caption = 'Conceptes d'#39'entrades relacionats'
        OnClick = Entradesrelacionades1Click
      end
    end
    object Tornarllistaprvia1: TMenuItem
      Caption = 'Tornar (llista pr'#232'via)'
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Filtrespredefinits1: TMenuItem
      Caption = 'Filtres predefinits'
      object Articlesaceroonegatiu1: TMenuItem
        Caption = 'Articles a cero o negatiu'
        OnClick = Articlesaceroonegatiu1Click
      end
      object Notrobatsaarticles1: TMenuItem
        Caption = 'No trobats a '#39'articles'#39
        OnClick = Notrobatsaarticles1Click
      end
    end
  end
end
