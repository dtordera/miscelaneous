object _ticket: T_ticket
  Left = 700
  Top = 192
  BorderStyle = bsDialog
  Caption = 'Model de ticket'
  ClientHeight = 490
  ClientWidth = 675
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Consolas'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 18
  object fOpcions: TFPanel
    Left = 0
    Top = 0
    Width = 171
    Height = 490
    Align = alLeft
    Borders = [E]
    BorderColor = clBlack
    TabOrder = 0
    DesignSize = (
      171
      490)
    object btCancel: TButton
      Left = 30
      Top = 370
      Width = 0
      Height = 25
      Cancel = True
      Caption = 'btCancel'
      ModalResult = 2
      TabOrder = 6
    end
    object UText2: TUText
      Left = 10
      Top = 70
      Width = 150
      Height = 19
      Cursor = crHandPoint
      Caption = '    &T'#237'tol'
      Color = 14150124
      ActLikeLabel = False
      Rounded = False
      DefaultReact = False
      ReactAndActive = True
      OnReact = UText2React
      TextStyleDefault.Color = 14150124
      TextStyleDefault.Font.Charset = DEFAULT_CHARSET
      TextStyleDefault.Font.Color = clBlack
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
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TabOrder = 2
      TabStop = True
      TabStopper = tsUp
      ParentColor = False
      ParentFont = False
      SelectAndNext = False
      AcceptMouseWheel = True
      PassColor = False
    end
    object UText3: TUText
      Left = 10
      Top = 455
      Width = 150
      Height = 21
      Cursor = crHandPoint
      Alignment = taCenter
      Anchors = [akLeft, akBottom]
      Caption = 'Guardar i sortir'
      Color = 14150124
      ActLikeLabel = False
      Rounded = False
      DefaultReact = False
      ReactAndActive = True
      OnReact = UText3React
      TextStyleDefault.Color = 14150124
      TextStyleDefault.Font.Charset = DEFAULT_CHARSET
      TextStyleDefault.Font.Color = clBlack
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
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TabOrder = 5
      TabStop = True
      ParentColor = False
      ParentFont = False
      SelectAndNext = False
      AcceptMouseWheel = True
      PassColor = False
    end
    object UText4: TUText
      Left = 10
      Top = 90
      Width = 150
      Height = 19
      Cursor = crHandPoint
      Caption = '    &Establiment'
      Color = 14150124
      ActLikeLabel = False
      Rounded = False
      DefaultReact = False
      ReactAndActive = True
      OnReact = UText4React
      TextStyleDefault.Color = 14150124
      TextStyleDefault.Font.Charset = DEFAULT_CHARSET
      TextStyleDefault.Font.Color = clBlack
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
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TabOrder = 3
      TabStop = True
      TabStopper = tsUp
      ParentColor = False
      ParentFont = False
      SelectAndNext = False
      AcceptMouseWheel = True
      PassColor = False
    end
    object UText5: TUText
      Left = 10
      Top = 110
      Width = 150
      Height = 19
      Cursor = crHandPoint
      Caption = '    &Peu '
      Color = 14150124
      ActLikeLabel = False
      Rounded = False
      DefaultReact = False
      ReactAndActive = True
      OnReact = UText5React
      TextStyleDefault.Color = 14150124
      TextStyleDefault.Font.Charset = DEFAULT_CHARSET
      TextStyleDefault.Font.Color = clBlack
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
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TabOrder = 4
      TabStop = True
      TabStopper = tsUp
      ParentColor = False
      ParentFont = False
      SelectAndNext = False
      AcceptMouseWheel = True
      PassColor = False
    end
    object tAmple: TUText
      Left = 10
      Top = 30
      Width = 150
      Height = 19
      Cursor = crHandPoint
      Caption = '    &Ample : 40 car'#224'cters'
      Color = 14150124
      ActLikeLabel = False
      Rounded = False
      DefaultReact = False
      ReactAndActive = True
      OnReact = tAmpleReact
      TextStyleDefault.Color = 14150124
      TextStyleDefault.Font.Charset = DEFAULT_CHARSET
      TextStyleDefault.Font.Color = clBlack
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
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TabOrder = 0
      TabStop = True
      TabStopper = tsUp
      ParentColor = False
      ParentFont = False
      SelectAndNext = False
      AcceptMouseWheel = True
      PassColor = False
    end
    object tEscPos: TMUText
      Left = 10
      Top = 50
      Width = 151
      Height = 19
      Cursor = crHandPoint
      Caption = '    &Utilitzant ESC/POS'
      Color = 14150124
      ActLikeLabel = False
      Rounded = False
      DefaultReact = False
      ReactAndActive = False
      OnReact = tEscPosReact
      TextStyleDefault.Color = 14150124
      TextStyleDefault.Font.Charset = DEFAULT_CHARSET
      TextStyleDefault.Font.Color = clBlack
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
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TabOrder = 1
      TabStop = True
      ParentColor = False
      ParentFont = False
      SelectAndNext = False
      AcceptMouseWheel = True
      PassColor = False
      Items.Strings = (
        '    &Utilitzant ESC/POS'
        '    No &utilitzant ESC/POS')
      ItemIndex = 0
      NotAllowChange = False
    end
  end
  object FPanel2: TFPanel
    Left = 171
    Top = 0
    Width = 504
    Height = 490
    Align = alClient
    Borders = []
    BorderColor = clBlack
    TabOrder = 1
    object Button1: TButton
      Left = 30
      Top = 370
      Width = 0
      Height = 25
      Cancel = True
      Caption = 'btCancel'
      ModalResult = 2
      TabOrder = 0
    end
    object mFons: TPanel
      Left = 11
      Top = 0
      Width = 479
      Height = 490
      Align = alClient
      BevelOuter = bvNone
      Caption = 'mFons'
      Color = 15396850
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Consolas'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object mPeu: TMemo
        Left = 0
        Top = 295
        Width = 479
        Height = 75
        Align = alTop
        Alignment = taCenter
        BorderStyle = bsNone
        Color = 15528692
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = []
        Lines.Strings = (
          'Garant'#237'a m'#237'nima de tenda de 15 d'#237'es'
          ''
          'Gr'#224'cies per la seva confian'#231'a'
          'MILAR BLANES S.L.-EL'#200'CTRICA BLANDENSE-B12345678')
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object mLinia2: TMemo
        Left = 0
        Top = 275
        Width = 479
        Height = 20
        Align = alTop
        BorderStyle = bsNone
        Color = 15528692
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = [fsUnderline]
        Lines.Strings = (
          '                                              ')
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      object mIVADesc: TMemo
        Left = 0
        Top = 239
        Width = 479
        Height = 36
        Align = alTop
        BorderStyle = bsNone
        Color = 15528692
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Consolas'
        Font.Style = []
        Lines.Strings = (
          'I.V.A.(%18)                     +0000.00'
          'Descompte(%0.00)                +0000.00')
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
      end
      object mTotal: TMemo
        Left = 0
        Top = 211
        Width = 479
        Height = 28
        Align = alTop
        BorderStyle = bsNone
        Color = 15528692
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -23
        Font.Name = 'Consolas'
        Font.Style = []
        Lines.Strings = (
          'TOTAL           +00000.00')
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
      end
      object mLinia1: TMemo
        Left = 0
        Top = 191
        Width = 479
        Height = 20
        Align = alTop
        BorderStyle = bsNone
        Color = 15528692
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = [fsUnderline]
        Lines.Strings = (
          '                                              ')
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
      end
      object mConceptes: TMemo
        Left = 0
        Top = 161
        Width = 479
        Height = 30
        Align = alTop
        BorderStyle = bsNone
        Color = 15528692
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = []
        Lines.Strings = (
          '00000 DESCRIPCI'#211' DE CONCEPTE DE PROVA (...)'
          '                      +0.0 +00000.00 +00000.00 '
          '   ')
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
        WantReturns = False
      end
      object mCapcelera: TMemo
        Left = 0
        Top = 141
        Width = 479
        Height = 20
        Align = alTop
        BorderStyle = bsNone
        Color = 15528692
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = [fsUnderline]
        Lines.Strings = (
          'ref.#  concepte      uts/h      preu    import'
          '    ')
        ParentFont = False
        ReadOnly = True
        TabOrder = 6
      end
      object mInfo: TMemo
        Left = 0
        Top = 101
        Width = 479
        Height = 40
        Align = alTop
        BorderStyle = bsNone
        Color = 15528692
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Consolas'
        Font.Style = []
        Lines.Strings = (
          'Ref.#000000             Data. 01/01/2010'
          'VENTA AL COMPTAT')
        ParentFont = False
        ReadOnly = True
        TabOrder = 7
      end
      object mEstab: TMemo
        Left = 0
        Top = 60
        Width = 479
        Height = 31
        Align = alTop
        Alignment = taCenter
        BorderStyle = bsNone
        Color = 15528692
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = []
        Lines.Strings = (
          'EL'#200'CTRICA BLANDENSE'
          'Jaume I, 3 - Blanes - Girona')
        ParentFont = False
        ReadOnly = True
        TabOrder = 8
      end
      object mTitol: TMemo
        Left = 0
        Top = 21
        Width = 479
        Height = 39
        Align = alTop
        Alignment = taCenter
        BorderStyle = bsNone
        Color = 15528692
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -30
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        Lines.Strings = (
          'MILAR BLANES')
        ParentFont = False
        ReadOnly = True
        TabOrder = 9
      end
      object Memo3: TMemo
        Left = 0
        Top = 91
        Width = 479
        Height = 10
        Align = alTop
        BorderStyle = bsNone
        Color = 15528692
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = []
        Lines.Strings = (
          '  '
          '  '
          '  '
          '  '
          '  '
          '  '
          '  '
          '  '
          '  '
          '  '
          '  '
          '  '
          '  '
          '  '
          '  '
          '  '
          '  '
          '  '
          '  '
          '  '
          '  '
          '  '
          '  ')
        ParentFont = False
        ReadOnly = True
        TabOrder = 10
      end
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 479
        Height = 21
        Align = alTop
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = 
          '1234567890123456789012345678901234567890123456789012345678901234' +
          '5678901234567890123456789012345678901234567890123456789012345678' +
          '9012345678901234567890123456789012345678901234567890123456789012' +
          '345678901234567890123456789012345678901234567890'
        Color = 15528692
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clSilver
        Font.Height = -15
        Font.Name = 'Consolas'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
      end
      object Panel5: TPanel
        Left = 0
        Top = 370
        Width = 479
        Height = 120
        Align = alClient
        BevelOuter = bvNone
        Color = 15528692
        TabOrder = 12
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 11
      Height = 490
      Align = alLeft
      BevelOuter = bvNone
      Color = 15528692
      TabOrder = 2
    end
    object Panel3: TPanel
      Left = 490
      Top = 0
      Width = 14
      Height = 490
      Align = alRight
      BevelOuter = bvNone
      Color = 15528692
      TabOrder = 3
    end
  end
end
