object _personals: T_personals
  Left = 1032
  Top = 287
  Width = 608
  Height = 540
  ActiveControl = v
  BorderStyle = bsSizeToolWin
  Caption = 'dades personals '
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
      Width = 83
      Height = 12
      Caption = 'dades personals '
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
    Data.Table = 'personals'
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
    Caption.Fixed = 'dades personals '
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
    object N1: TMenuItem
      Caption = '-'
    end
    object Noupersonal: TMenuItem
      Caption = 'Nou registre (Insert)'
      OnClick = NoupersonalClick
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
    object Recalculardeute1: TMenuItem
      Caption = 'Recalcular deute'
      OnClick = Recalculardeute1Click
    end
    object Mostrarrepetits1: TMenuItem
      Caption = 'Registres semblants'
      OnClick = Mostrarrepetits1Click
    end
    object Fusionardosregistres1: TMenuItem
      Caption = 'Fusionar registres'
      OnClick = Fusionardosregistres1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Anara1: TMenuItem
      Caption = 'Anar a ...'
      object Averiesrelacionades1: TMenuItem
        Caption = 'Averies relacionades'
        OnClick = Averiesrelacionades1Click
      end
      object pressupostosrelacionats1: TMenuItem
        Caption = 'pressupostos relacionats'
        OnClick = pressupostosrelacionats1Click
      end
      object Ventesrelacionades1: TMenuItem
        Caption = 'Ventes (A) relacionades'
        OnClick = VentesArelacionades1Click
      end
      object VentesBrelacionades1: TMenuItem
        Caption = 'Ventes (B) relacionades'
        OnClick = VentesBrelacionades1Click
      end
      object Entradesrelacionades1: TMenuItem
        Caption = 'Entrades relacionades'
        OnClick = Entradesrelacionades1Click
      end
    end
    object Tornarllistaprvia1: TMenuItem
      Caption = 'Tornar (llista pr'#232'via)'
      OnClick = Tornarllistaprvia1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Filtresdefinits1: TMenuItem
      Caption = 'Filtres predefinits'
      object Msdedosanysinactiu1: TMenuItem
        Caption = 'M'#233's de dos anys inactiu'
        OnClick = Msdedosanysinactiu1Click
      end
      object Repetitsaalguncamp1: TMenuItem
        Caption = 'Repetits a algun camp'
        OnClick = Repetitsaalguncamp1Click
      end
      object Ambdeute1: TMenuItem
        Caption = 'Amb deute'
        OnClick = Ambdeute1Click
      end
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object ltimaacci1: TMenuItem
      Caption = #218'ltima acci'#243' : '
      Default = True
      OnClick = ltimaacci1Click
    end
  end
end
