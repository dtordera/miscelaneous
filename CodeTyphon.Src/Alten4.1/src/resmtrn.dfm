object _resmtrn: T_resmtrn
  Left = 677
  Top = 407
  BorderStyle = bsDialog
  Caption = 'Resum torn'
  ClientHeight = 162
  ClientWidth = 217
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  DesignSize = (
    217
    162)
  PixelsPerInch = 120
  TextHeight = 16
  object GradientNC1: TGradientNC
    Left = 150
    Top = 0
    Width = 67
    Height = 162
    ColorInicial = 14281452
    ColorFinal = clSilver
    Direccio = E
    Align = alRight
  end
  object T: TBLabel
    Left = 170
    Top = 48
    Width = 30
    Height = 16
    Cursor = crHandPoint
    ColorMouseOver = 33023
    ColorRestore = clBlack
    Autosize = False
    Caption = ' '
    Transparent = True
    NoClick = False
    PassColors = False
    Value = True
    ColorTrue = clBlue
    ColorFalse = clRed
    BoolAlignment = taCenter
  end
  object B: TBLabel
    Left = 170
    Top = 32
    Width = 30
    Height = 16
    Cursor = crHandPoint
    ColorMouseOver = 33023
    ColorRestore = clBlack
    Autosize = False
    Caption = ' '
    Transparent = True
    NoClick = False
    PassColors = False
    Value = True
    ColorTrue = clBlue
    ColorFalse = clRed
    BoolAlignment = taCenter
  end
  object A: TBLabel
    Left = 170
    Top = 16
    Width = 30
    Height = 16
    Cursor = crHandPoint
    ColorMouseOver = 33023
    ColorRestore = clBlack
    Autosize = False
    Caption = ' '
    Transparent = True
    NoClick = False
    PassColors = False
    Value = True
    ColorTrue = clBlue
    ColorFalse = clRed
    BoolAlignment = taCenter
  end
  object dNomesTotals: TBLabel
    Left = 170
    Top = 78
    Width = 30
    Height = 16
    Cursor = crHandPoint
    ColorMouseOver = 33023
    ColorRestore = clBlack
    Autosize = False
    Caption = ' '
    Transparent = True
    NoClick = False
    PassColors = False
    Value = False
    ColorTrue = clBlue
    ColorFalse = clRed
    BoolAlignment = taCenter
  end
  object UText3: TUText
    Left = 24
    Top = 48
    Width = 117
    Height = 17
    Cursor = crHandPoint
    Caption = 'Incloure total &Torn'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    LinkedControl = T
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
    Left = 24
    Top = 32
    Width = 117
    Height = 17
    Cursor = crHandPoint
    Caption = 'Incloure l'#237'nea &B'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    LinkedControl = B
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
    Left = 24
    Top = 16
    Width = 117
    Height = 17
    Cursor = crHandPoint
    Caption = 'Incloure l'#237'nea &A'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    LinkedControl = A
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
  object btVeureAPantalla: TUText
    Left = 26
    Top = 108
    Width = 169
    Height = 20
    Cursor = crHandPoint
    Alignment = taCenter
    Anchors = [akLeft, akBottom]
    Caption = '&Veure a pantalla'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    OnReact = btVeureAPantallaReact
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
    TabOrder = 4
    TabStop = True
    ParentFont = False
    SelectAndNext = False
    AcceptMouseWheel = True
    PassColor = False
  end
  object btImprimir: TUText
    Left = 26
    Top = 132
    Width = 169
    Height = 20
    Cursor = crHandPoint
    Alignment = taCenter
    Anchors = [akLeft, akBottom]
    Caption = 'Im&primir'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    OnReact = btImprimirReact
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
    ParentFont = False
    SelectAndNext = False
    AcceptMouseWheel = True
    PassColor = False
  end
  object tNomesTotals: TUText
    Left = 24
    Top = 78
    Width = 117
    Height = 17
    Cursor = crHandPoint
    Caption = '&Nom'#233's totals'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    LinkedControl = dNomesTotals
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
end