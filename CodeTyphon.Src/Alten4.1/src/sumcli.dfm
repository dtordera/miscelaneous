object _sumcli: T_sumcli
  Left = 548
  Top = 316
  Width = 425
  Height = 212
  Caption = 'Suma segons clients'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  DesignSize = (
    417
    172)
  PixelsPerInch = 120
  TextHeight = 16
  object dLINIA: TMLabel
    Left = 170
    Top = 20
    Width = 8
    Height = 16
    Cursor = crHandPoint
    ColorMouseOver = 33023
    ColorRestore = clBlack
    Caption = 'A'
    Transparent = True
    NoClick = False
    PassColors = False
    Items.Strings = (
      'A'
      'B')
    ItemIndex = 0
  end
  object dDATA_INICI: TDLabel
    Left = 170
    Top = 39
    Width = 68
    Height = 16
    Cursor = crHandPoint
    ColorMouseOver = 33023
    ColorRestore = clBlack
    Autosize = False
    Color = 14938354
    Caption = '21/11/2007'
    Transparent = True
    NoClick = False
    PassColors = False
    Date = 39407.612926967590000000
    Format = 'ddddd'
    Question = 'Desde la data'
  end
  object dDATA_FINAL: TDLabel
    Left = 170
    Top = 59
    Width = 68
    Height = 16
    Cursor = crHandPoint
    ColorMouseOver = 33023
    ColorRestore = clBlack
    Autosize = False
    Color = 14938354
    Caption = '21/11/2007'
    Transparent = True
    NoClick = False
    PassColors = False
    Date = 39407.612926967590000000
    Format = 'ddddd'
    Question = 'Fins la data'
  end
  object dSUMA_INF: TNLabel
    Left = 350
    Top = 90
    Width = 39
    Height = 16
    Cursor = crHandPoint
    ColorMouseOver = 33023
    ColorRestore = clBlack
    Caption = '100,00'
    NoClick = False
    PassColors = False
    Question = 'Sumes inferiors'
    Format = '0.00'
    Value = 100.000000000000000000
    NumType = ntInt
  end
  object dSUMA_SUP: TNLabel
    Left = 350
    Top = 110
    Width = 39
    Height = 16
    Cursor = crHandPoint
    ColorMouseOver = 33023
    ColorRestore = clBlack
    Caption = '500,00'
    NoClick = False
    PassColors = False
    Question = 'Sumes superiors'
    Format = '0.00'
    Value = 500.000000000000000000
    NumType = ntInt
  end
  object UText12: TUText
    Left = 30
    Top = 40
    Width = 130
    Height = 19
    Cursor = crHandPoint
    Caption = '&Desde la data'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    LinkedControl = dDATA_INICI
    TextStyleDefault.Color = clBtnFace
    TextStyleDefault.Font.Charset = DEFAULT_CHARSET
    TextStyleDefault.Font.Color = clWindowText
    TextStyleDefault.Font.Height = -13
    TextStyleDefault.Font.Name = 'MS Sans Serif'
    TextStyleDefault.Font.Style = []
    TextStyleSelected.Color = clSilver
    TextStyleSelected.Font.Charset = DEFAULT_CHARSET
    TextStyleSelected.Font.Color = clBlack
    TextStyleSelected.Font.Height = -13
    TextStyleSelected.Font.Name = 'MS Sans Serif'
    TextStyleSelected.Font.Style = []
    TextStyleMouseOver.Color = clWhite
    TextStyleMouseOver.Font.Charset = DEFAULT_CHARSET
    TextStyleMouseOver.Font.Color = clBlack
    TextStyleMouseOver.Font.Height = -13
    TextStyleMouseOver.Font.Name = 'MS Sans Serif'
    TextStyleMouseOver.Font.Style = []
    Transparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    TabOrder = 1
    TabStop = True
    ParentFont = False
    SelectAndNext = False
    AcceptMouseWheel = True
    PassColor = False
  end
  object UText1: TUText
    Left = 30
    Top = 60
    Width = 130
    Height = 19
    Cursor = crHandPoint
    Caption = '&Fins la data'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    LinkedControl = dDATA_FINAL
    TextStyleDefault.Color = clBtnFace
    TextStyleDefault.Font.Charset = DEFAULT_CHARSET
    TextStyleDefault.Font.Color = clWindowText
    TextStyleDefault.Font.Height = -13
    TextStyleDefault.Font.Name = 'MS Sans Serif'
    TextStyleDefault.Font.Style = []
    TextStyleSelected.Color = clSilver
    TextStyleSelected.Font.Charset = DEFAULT_CHARSET
    TextStyleSelected.Font.Color = clBlack
    TextStyleSelected.Font.Height = -13
    TextStyleSelected.Font.Name = 'MS Sans Serif'
    TextStyleSelected.Font.Style = []
    TextStyleMouseOver.Color = clWhite
    TextStyleMouseOver.Font.Charset = DEFAULT_CHARSET
    TextStyleMouseOver.Font.Color = clBlack
    TextStyleMouseOver.Font.Height = -13
    TextStyleMouseOver.Font.Name = 'MS Sans Serif'
    TextStyleMouseOver.Font.Style = []
    Transparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    TabOrder = 2
    TabStop = True
    ParentFont = False
    SelectAndNext = False
    AcceptMouseWheel = True
    PassColor = False
  end
  object UText2: TUText
    Left = 30
    Top = 90
    Width = 301
    Height = 19
    Cursor = crHandPoint
    Caption = '&No incloure clients amb suma inferior (o igual) a '
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    LinkedControl = dSUMA_INF
    TextStyleDefault.Color = clBtnFace
    TextStyleDefault.Font.Charset = DEFAULT_CHARSET
    TextStyleDefault.Font.Color = clWindowText
    TextStyleDefault.Font.Height = -13
    TextStyleDefault.Font.Name = 'MS Sans Serif'
    TextStyleDefault.Font.Style = []
    TextStyleSelected.Color = clSilver
    TextStyleSelected.Font.Charset = DEFAULT_CHARSET
    TextStyleSelected.Font.Color = clBlack
    TextStyleSelected.Font.Height = -13
    TextStyleSelected.Font.Name = 'MS Sans Serif'
    TextStyleSelected.Font.Style = []
    TextStyleMouseOver.Color = clWhite
    TextStyleMouseOver.Font.Charset = DEFAULT_CHARSET
    TextStyleMouseOver.Font.Color = clBlack
    TextStyleMouseOver.Font.Height = -13
    TextStyleMouseOver.Font.Name = 'MS Sans Serif'
    TextStyleMouseOver.Font.Style = []
    Transparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    TabOrder = 3
    TabStop = True
    ParentFont = False
    SelectAndNext = False
    AcceptMouseWheel = True
    PassColor = False
  end
  object UText3: TUText
    Left = 30
    Top = 110
    Width = 301
    Height = 19
    Cursor = crHandPoint
    Caption = '&Marcar clients amb suma superior (o igual) a'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    LinkedControl = dSUMA_SUP
    TextStyleDefault.Color = clBtnFace
    TextStyleDefault.Font.Charset = DEFAULT_CHARSET
    TextStyleDefault.Font.Color = clWindowText
    TextStyleDefault.Font.Height = -13
    TextStyleDefault.Font.Name = 'MS Sans Serif'
    TextStyleDefault.Font.Style = []
    TextStyleSelected.Color = clSilver
    TextStyleSelected.Font.Charset = DEFAULT_CHARSET
    TextStyleSelected.Font.Color = clBlack
    TextStyleSelected.Font.Height = -13
    TextStyleSelected.Font.Name = 'MS Sans Serif'
    TextStyleSelected.Font.Style = []
    TextStyleMouseOver.Color = clWhite
    TextStyleMouseOver.Font.Charset = DEFAULT_CHARSET
    TextStyleMouseOver.Font.Color = clBlack
    TextStyleMouseOver.Font.Height = -13
    TextStyleMouseOver.Font.Name = 'MS Sans Serif'
    TextStyleMouseOver.Font.Style = []
    Transparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    TabOrder = 4
    TabStop = True
    ParentFont = False
    SelectAndNext = False
    AcceptMouseWheel = True
    PassColor = False
  end
  object UText4: TUText
    Left = 30
    Top = 20
    Width = 130
    Height = 19
    Cursor = crHandPoint
    Caption = '&L'#237'nia de resum'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    LinkedControl = dLINIA
    TextStyleDefault.Color = clBtnFace
    TextStyleDefault.Font.Charset = DEFAULT_CHARSET
    TextStyleDefault.Font.Color = clWindowText
    TextStyleDefault.Font.Height = -13
    TextStyleDefault.Font.Name = 'MS Sans Serif'
    TextStyleDefault.Font.Style = []
    TextStyleSelected.Color = clSilver
    TextStyleSelected.Font.Charset = DEFAULT_CHARSET
    TextStyleSelected.Font.Color = clBlack
    TextStyleSelected.Font.Height = -13
    TextStyleSelected.Font.Name = 'MS Sans Serif'
    TextStyleSelected.Font.Style = []
    TextStyleMouseOver.Color = clWhite
    TextStyleMouseOver.Font.Charset = DEFAULT_CHARSET
    TextStyleMouseOver.Font.Color = clBlack
    TextStyleMouseOver.Font.Height = -13
    TextStyleMouseOver.Font.Name = 'MS Sans Serif'
    TextStyleMouseOver.Font.Style = []
    Transparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    TabOrder = 0
    TabStop = True
    ParentFont = False
    SelectAndNext = False
    AcceptMouseWheel = True
    PassColor = False
  end
  object btEntrar: TUText
    Left = 286
    Top = 140
    Width = 111
    Height = 22
    Cursor = crHandPoint
    Alignment = taCenter
    Anchors = [akRight, akBottom]
    Caption = '&Fer resum'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    OnReact = btEntrarReact
    TextStyleDefault.Color = clBtnFace
    TextStyleDefault.Font.Charset = DEFAULT_CHARSET
    TextStyleDefault.Font.Color = clWindowText
    TextStyleDefault.Font.Height = -13
    TextStyleDefault.Font.Name = 'MS Sans Serif'
    TextStyleDefault.Font.Style = []
    TextStyleSelected.Color = clSilver
    TextStyleSelected.Font.Charset = DEFAULT_CHARSET
    TextStyleSelected.Font.Color = clBlack
    TextStyleSelected.Font.Height = -13
    TextStyleSelected.Font.Name = 'MS Sans Serif'
    TextStyleSelected.Font.Style = []
    TextStyleMouseOver.Color = clWhite
    TextStyleMouseOver.Font.Charset = DEFAULT_CHARSET
    TextStyleMouseOver.Font.Color = clBlack
    TextStyleMouseOver.Font.Height = -13
    TextStyleMouseOver.Font.Name = 'MS Sans Serif'
    TextStyleMouseOver.Font.Style = []
    BorderStyle = sbsSingle
    Transparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    TabOrder = 5
    TabStop = True
    TabStopper = tsDown
    ParentFont = False
    SelectAndNext = False
    AcceptMouseWheel = True
    PassColor = False
  end
end
