object _visor: T_visor
  Left = 469
  Top = 219
  BorderStyle = bsDialog
  Caption = 'Visor de taules'
  ClientHeight = 639
  ClientWidth = 1083
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    1083
    639)
  PixelsPerInch = 120
  TextHeight = 16
  object v: TUDBView
    Left = 0
    Top = 0
    Width = 1083
    Height = 596
    LoseFocus = False
    ShowHBar = True
    Rounded = False
    Kind = uvNormal
    Align = alClient
    Data.SFilterKind = fkProgressive
    EscClose = False
    TabOrder = 2
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
    DblClickAsEnter = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 596
    Width = 1083
    Height = 43
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      1083
      43)
    object LUText1: TLUText
      Left = 10
      Top = 10
      Width = 441
      Height = 20
      Cursor = crHandPoint
      Caption = '(no hi ha cap base de dades carregada)'
      ActLikeLabel = False
      Rounded = False
      DefaultReact = False
      ReactAndActive = False
      TextStyleDefault.Color = clWindow
      TextStyleDefault.Font.Charset = DEFAULT_CHARSET
      TextStyleDefault.Font.Color = clWindowText
      TextStyleDefault.Font.Height = -13
      TextStyleDefault.Font.Name = 'Tahoma'
      TextStyleDefault.Font.Style = []
      TextStyleSelected.Color = clSilver
      TextStyleSelected.Font.Charset = DEFAULT_CHARSET
      TextStyleSelected.Font.Color = clBlack
      TextStyleSelected.Font.Height = -13
      TextStyleSelected.Font.Name = 'Tahoma'
      TextStyleSelected.Font.Style = []
      TextStyleMouseOver.Color = clWhite
      TextStyleMouseOver.Font.Charset = DEFAULT_CHARSET
      TextStyleMouseOver.Font.Color = clBlack
      TextStyleMouseOver.Font.Height = -13
      TextStyleMouseOver.Font.Name = 'Tahoma'
      TextStyleMouseOver.Font.Style = []
      Transparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      TabOrder = 0
      TabStop = True
      ParentColor = False
      ParentFont = False
      SelectAndNext = True
      AcceptMouseWheel = True
      PassColor = False
      OnLoad = LUText1Load
      Dialog.DefaultExt = '*.mdb'
      Dialog.FileName = '*.mdb'
      Dialog.Filter = 'All files (*.*)|*.*|mdb files (*.mdb)|*.mdb'
      Dialog.InitialDir = 'C:\Archivos de programa\Delphi7SE\Bin\'
      Dialog.Options = []
    end
    object Edit1: TEdit
      Left = 460
      Top = 10
      Width = 611
      Height = 22
      Anchors = [akLeft, akTop, akRight]
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 1
      OnKeyDown = Edit1KeyDown
    end
  end
  object Panel2: TPanel
    Left = 770
    Top = 374
    Width = 281
    Height = 192
    Anchors = [akRight, akBottom]
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object BDInfo2: TBDInfo
      Left = 140
      Top = 10
      Width = 131
      Height = 171
      InfoType = biFields
      Connection = cg
      Items.Strings = (
        '(no table name)')
    end
    object BDInfo1: TBDInfo
      Left = 10
      Top = 10
      Width = 131
      Height = 171
      InfoType = biTables
      Connection = cg
      OnClick = BDInfo1Click
    end
  end
  object cg: TADOConnection
    LoginPrompt = False
    Left = 70
    Top = 420
  end
end
