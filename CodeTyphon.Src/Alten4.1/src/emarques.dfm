object _emarques: T_emarques
  Left = 602
  Top = 344
  ActiveControl = UText1
  BorderStyle = bsDialog
  Caption = 'Marques'
  ClientHeight = 134
  ClientWidth = 483
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  DesignSize = (
    483
    134)
  PixelsPerInch = 120
  TextHeight = 16
  object GradientNC1: TGradientNC
    Left = 160
    Top = 0
    Width = 323
    Height = 134
    ColorInicial = 14281452
    ColorFinal = clSilver
    Direccio = E
    Align = alRight
  end
  object dID: TNLabel
    Left = 180
    Top = 20
    Width = 9
    Height = 16
    ColorMouseOver = 33023
    ColorRestore = clBlack
    Color = 14938354
    Caption = '0'
    Transparent = True
    NoClickMessage = 'Refer'#232'ncia de marca'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    NoClick = True
    PassColors = False
    Format = '0'
    NumType = ntInt
  end
  object dDESCR: TTLabel
    Left = 180
    Top = 40
    Width = 291
    Height = 16
    Cursor = crHandPoint
    ColorMouseOver = 33023
    ColorRestore = clBlack
    Autosize = False
    Color = 14938354
    Caption = 'DDESCR'
    Transparent = True
    NoClickMessage = 'descripci'#243' de marca'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    NoClick = False
    PassColors = False
    Question = 'Descripci'#243
    QWidth = 350
    LabelCase = ecUpperCase
  end
  object dMARGE: TNLabel
    Left = 180
    Top = 60
    Width = 71
    Height = 16
    Cursor = crHandPoint
    ColorMouseOver = 33023
    ColorRestore = clBlack
    Autosize = False
    Color = 14938354
    Caption = '0,00 %'
    Transparent = True
    NoClickMessage = 
      'marge de marca. Aplicat a c'#224'rrega d'#39'articles si '#233's diferent de c' +
      'ero'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    NoClick = False
    PassColors = False
    Question = 'Marge'
    Format = '0.00 %'
    NumType = ntFloat
  end
  object Bevel1: TBevel
    Left = 165
    Top = 20
    Width = 1
    Height = 71
  end
  object UText1: TUText
    Left = 30
    Top = 40
    Width = 130
    Height = 20
    Cursor = crHandPoint
    Caption = '&Descripci'#243
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    LinkedControl = dDESCR
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
    SelectAndNext = True
    AcceptMouseWheel = True
    PassColor = False
  end
  object UText7: TUText
    Left = 30
    Top = 60
    Width = 130
    Height = 20
    Cursor = crHandPoint
    Caption = '&Marge'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    LinkedControl = dMARGE
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
    SelectAndNext = True
    AcceptMouseWheel = True
    PassColor = False
  end
  object btAnterior: TUText
    Left = 10
    Top = 102
    Width = 111
    Height = 22
    Cursor = crHandPoint
    Alignment = taCenter
    Anchors = [akLeft, akBottom]
    Caption = '&< anterior'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = False
    ReactAndActive = True
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
    TabOrder = 3
    TabStop = True
    ParentFont = False
    SelectAndNext = False
    AcceptMouseWheel = True
    PassColor = False
  end
  object btSeguent: TUText
    Left = 120
    Top = 102
    Width = 111
    Height = 22
    Cursor = crHandPoint
    Alignment = taCenter
    Anchors = [akLeft, akBottom]
    Caption = 'seg'#252'ent &>'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = False
    ReactAndActive = True
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
  object btEntrar: TUText
    Left = 362
    Top = 102
    Width = 111
    Height = 22
    Cursor = crHandPoint
    Alignment = taCenter
    Anchors = [akRight, akBottom]
    Caption = '&Entrar'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
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
  object tRef: TUText
    Left = 30
    Top = 20
    Width = 130
    Height = 20
    Cursor = crHandPoint
    Caption = 'Ref.'
    ActLikeLabel = False
    Rounded = False
    DefaultReact = True
    ReactAndActive = False
    LinkedControl = dID
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
    SelectAndNext = True
    AcceptMouseWheel = True
    PassColor = False
  end
  object UDBAlterForm: TUDBAlterForm
    UDBView = _marques.v
    NextButton = btSeguent
    PriorButton = btAnterior
    OkButton = btEntrar
    ControlPrefix = 'd'
    NotAllowPost = False
    LoadDefValues = UDBAlterFormLoadDefValues
    Messages.ErrorMsg = 'Error actualitzant valors'
    Messages.SaveMsg = 'Guardar canvis?'
    Messages.BadValue = 'Valor '#39'%VALUE%'#39' incorrecte per el camp %FIELD%'
    Messages.DeleteMsg = 'Eliminar registre de marques #%PRIMARY%. Continuar?'
    Messages.NotAllowPost = 'Posting not allowed'
    PrimaryField = 'id'
    Left = 352
    Top = 38
  end
end
