object _colorscfg: T_colorscfg
  Left = 619
  Top = 351
  BorderStyle = bsDialog
  Caption = 'Colors'
  ClientHeight = 359
  ClientWidth = 450
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
    450
    359)
  PixelsPerInch = 120
  TextHeight = 16
  object GradientNC1: TGradientNC
    Left = 332
    Top = 0
    Width = 118
    Height = 359
    ColorInicial = 14281452
    ColorFinal = clSilver
    Direccio = E
    Align = alRight
  end
  object Label2: TLabel
    Left = 20
    Top = 20
    Width = 29
    Height = 16
    Caption = 'Fons'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 20
    Top = 60
    Width = 112
    Height = 16
    Caption = 'Bandes d'#39'opcions'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 20
    Top = 160
    Width = 41
    Height = 16
    Caption = 'Valors'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 20
    Top = 200
    Width = 41
    Height = 16
    Caption = 'Llistes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Shape1: TShape
    Left = 310
    Top = 20
    Width = 1
    Height = 291
    Pen.Color = clSilver
  end
  object UText6: TUText
    Left = 325
    Top = 324
    Width = 101
    Height = 22
    Cursor = crHandPoint
    Alignment = taCenter
    Anchors = [akRight, akBottom]
    Caption = 'A&cceptar'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = False
    ReactAndActive = True
    OnReact = UText6React
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
    TabOrder = 17
    TabStop = True
    ParentFont = False
    SelectAndNext = False
    AcceptMouseWheel = True
    PassColor = False
  end
  object UText1: TUText
    Left = 150
    Top = 20
    Width = 150
    Height = 19
    Cursor = crHandPoint
    Caption = 'Color inicial'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    LinkedControl = cGradientInicial
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
  object UText9: TUText
    Left = 150
    Top = 60
    Width = 150
    Height = 19
    Cursor = crHandPoint
    Caption = 'Lletra normal'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    LinkedControl = cDefaultNormalUText
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
  object UText11: TUText
    Left = 150
    Top = 80
    Width = 150
    Height = 19
    Cursor = crHandPoint
    Caption = 'Banda enfocada'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    LinkedControl = cMouseOverBand
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
  object UText12: TUText
    Left = 150
    Top = 100
    Width = 150
    Height = 19
    Cursor = crHandPoint
    Caption = 'Lletra enfocada'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    LinkedControl = cMouseOverFont
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
  object UText13: TUText
    Left = 150
    Top = 120
    Width = 150
    Height = 19
    Cursor = crHandPoint
    Caption = 'Banda seleccionada'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    LinkedControl = cSelectedBand
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
    TabOrder = 5
    TabStop = True
    ParentFont = False
    SelectAndNext = False
    AcceptMouseWheel = True
    PassColor = False
  end
  object UText14: TUText
    Left = 150
    Top = 140
    Width = 150
    Height = 19
    Cursor = crHandPoint
    Caption = 'Lletra seleccionada'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    LinkedControl = cSelectedFont
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
    TabOrder = 6
    TabStop = True
    ParentFont = False
    SelectAndNext = False
    AcceptMouseWheel = True
    PassColor = False
  end
  object UText17: TUText
    Left = 150
    Top = 160
    Width = 150
    Height = 19
    Cursor = crHandPoint
    Caption = 'Lletra normal'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    LinkedControl = cULabelFont
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
    TabOrder = 7
    TabStop = True
    ParentFont = False
    SelectAndNext = False
    AcceptMouseWheel = True
    PassColor = False
  end
  object UText18: TUText
    Left = 150
    Top = 180
    Width = 150
    Height = 19
    Cursor = crHandPoint
    Caption = 'Lletra enfocada'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    LinkedControl = cULabelMouseOver
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
    TabOrder = 8
    TabStop = True
    ParentFont = False
    SelectAndNext = False
    AcceptMouseWheel = True
    PassColor = False
  end
  object UText2: TUText
    Left = 150
    Top = 40
    Width = 150
    Height = 19
    Cursor = crHandPoint
    Caption = 'Color final'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    LinkedControl = cGradientFinal
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
  object cGradientInicial: TCColor
    Left = 350
    Top = 20
    Width = 51
    Height = 19
    Cursor = crHandPoint
    Color = 8404992
    ColorS = '8404992'
    Ctl3D = False
  end
  object cGradientFinal: TCColor
    Left = 350
    Top = 40
    Width = 51
    Height = 19
    Cursor = crHandPoint
    Color = 33023
    ColorS = '33023'
    Ctl3D = False
  end
  object cDefaultNormalUText: TCColor
    Left = 350
    Top = 60
    Width = 51
    Height = 19
    Cursor = crHandPoint
    ColorS = '-16777201'
    Ctl3D = False
  end
  object cSelectedFont: TCColor
    Left = 350
    Top = 140
    Width = 51
    Height = 19
    Cursor = crHandPoint
    Color = clSilver
    ColorS = '12632256'
    Ctl3D = False
  end
  object cSelectedBand: TCColor
    Left = 350
    Top = 120
    Width = 51
    Height = 19
    Cursor = crHandPoint
    ColorS = '-16777201'
    Ctl3D = False
  end
  object cMouseOverFont: TCColor
    Left = 350
    Top = 100
    Width = 51
    Height = 19
    Cursor = crHandPoint
    ColorS = '-16777201'
    Ctl3D = False
  end
  object cMouseOverBand: TCColor
    Left = 350
    Top = 80
    Width = 51
    Height = 19
    Cursor = crHandPoint
    ColorS = '-16777201'
    Ctl3D = False
  end
  object cULabelMouseOver: TCColor
    Left = 350
    Top = 180
    Width = 51
    Height = 19
    Cursor = crHandPoint
    ColorS = '-16777201'
    Ctl3D = False
  end
  object cULabelFont: TCColor
    Left = 350
    Top = 160
    Width = 51
    Height = 19
    Cursor = crHandPoint
    ColorS = '-16777201'
    Ctl3D = False
  end
  object cUDBGodd: TCColor
    Left = 350
    Top = 240
    Width = 51
    Height = 19
    Cursor = crHandPoint
    ColorS = '-16777201'
    Ctl3D = False
  end
  object cUDBGFont: TCColor
    Left = 350
    Top = 200
    Width = 51
    Height = 19
    Cursor = crHandPoint
    ColorS = '-16777201'
    Ctl3D = False
  end
  object UText3: TUText
    Left = 150
    Top = 200
    Width = 150
    Height = 19
    Cursor = crHandPoint
    Caption = 'Lletra'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    LinkedControl = cUDBGFont
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
    TabOrder = 9
    TabStop = True
    ParentFont = False
    SelectAndNext = False
    AcceptMouseWheel = True
    PassColor = False
  end
  object UText5: TUText
    Left = 150
    Top = 240
    Width = 150
    Height = 19
    Cursor = crHandPoint
    Caption = 'Banda parella'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    LinkedControl = cUDBGodd
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
    TabOrder = 11
    TabStop = True
    ParentFont = False
    SelectAndNext = False
    AcceptMouseWheel = True
    PassColor = False
  end
  object UText7: TUText
    Left = 150
    Top = 220
    Width = 150
    Height = 19
    Cursor = crHandPoint
    Caption = 'Banda senar'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    LinkedControl = cUDBGEven
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
    TabOrder = 10
    TabStop = True
    ParentFont = False
    SelectAndNext = False
    AcceptMouseWheel = True
    PassColor = False
  end
  object cUDBGEven: TCColor
    Left = 350
    Top = 220
    Width = 51
    Height = 19
    Cursor = crHandPoint
    ColorS = '-16777201'
    Ctl3D = False
  end
  object UText10: TUText
    Left = 150
    Top = 260
    Width = 150
    Height = 19
    Cursor = crHandPoint
    Caption = 'Lletra de capcelera'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    LinkedControl = cUDBGTitleFont
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
    TabOrder = 12
    TabStop = True
    ParentFont = False
    SelectAndNext = False
    AcceptMouseWheel = True
    PassColor = False
  end
  object cUDBGTitleFont: TCColor
    Left = 350
    Top = 260
    Width = 51
    Height = 19
    Cursor = crHandPoint
    ColorS = '-16777201'
    Ctl3D = False
  end
  object UText8: TUText
    Left = 150
    Top = 280
    Width = 150
    Height = 19
    Cursor = crHandPoint
    Caption = 'Banda capcelera'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    LinkedControl = cUDBGTitle
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
    TabOrder = 13
    TabStop = True
    ParentFont = False
    SelectAndNext = False
    AcceptMouseWheel = True
    PassColor = False
  end
  object cUDBGTitle: TCColor
    Left = 350
    Top = 280
    Width = 51
    Height = 19
    Cursor = crHandPoint
    ColorS = '-16777201'
    Ctl3D = False
  end
  object UText15: TUText
    Left = 125
    Top = 324
    Width = 101
    Height = 22
    Cursor = crHandPoint
    Alignment = taCenter
    Anchors = [akRight, akBottom]
    Caption = '&Guardar'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = False
    ReactAndActive = True
    OnReact = UText15React
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
    TabOrder = 15
    TabStop = True
    ParentFont = False
    SelectAndNext = False
    AcceptMouseWheel = True
    PassColor = False
  end
  object UText19: TUText
    Left = 25
    Top = 324
    Width = 101
    Height = 22
    Cursor = crHandPoint
    Alignment = taCenter
    Anchors = [akRight, akBottom]
    Caption = '&Carregar'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = False
    ReactAndActive = True
    OnReact = UText19React
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
    TabOrder = 14
    TabStop = True
    ParentFont = False
    SelectAndNext = False
    AcceptMouseWheel = True
    PassColor = False
  end
  object UText20: TUText
    Left = 225
    Top = 324
    Width = 101
    Height = 22
    Cursor = crHandPoint
    Alignment = taCenter
    Anchors = [akRight, akBottom]
    Caption = '&Aplicar'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = False
    ReactAndActive = True
    OnReact = UText20React
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
    TabOrder = 16
    TabStop = True
    ParentFont = False
    SelectAndNext = False
    AcceptMouseWheel = True
    PassColor = False
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.stc'
    Filter = 'Fitxer de setup colors (*.stc)|*.stc|Tots els fitxers (*.*)|*.*'
    Options = [ofHideReadOnly, ofNoChangeDir, ofEnableSizing]
    Left = 40
    Top = 90
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.stc'
    Filter = 'Fitxers de setup color (*.stc)|*.stc|Tots els fitxers (*.*)|*.*'
    Left = 90
    Top = 90
  end
end
