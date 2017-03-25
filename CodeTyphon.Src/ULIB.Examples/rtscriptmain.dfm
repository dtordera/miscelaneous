object Form1: TForm1
  Left = 306
  Top = 236
  Width = 1122
  Height = 530
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Shape1: TShape
    Left = 380
    Top = 310
    Width = 65
    Height = 65
  end
  object Shape2: TShape
    Left = 450
    Top = 310
    Width = 65
    Height = 65
  end
  object Label1: TLabel
    Left = 400
    Top = 170
    Width = 87
    Height = 36
    Alignment = taCenter
    Caption = 'Label1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 400
    Top = 220
    Width = 87
    Height = 36
    Alignment = taCenter
    Caption = 'Label2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 20
    Top = 20
    Width = 291
    Height = 24
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 580
    Top = 20
    Width = 511
    Height = 411
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Button1: TButton
    Left = 350
    Top = 50
    Width = 200
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 350
    Top = 20
    Width = 200
    Height = 25
    Caption = 'Execute Script'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Memo2: TMemo
    Left = 20
    Top = 50
    Width = 291
    Height = 411
    Lines.Strings = (
      '@Form1'
      'Color=clBlue'
      '>Form1.N1'
      '@Edit1'
      'Color=clYellow'
      'Font.Size=18'
      '@Shape1'
      'Brush.Color=clAqua'
      'Pen.Style=psDash'
      '@Shape2'
      'Cursor=crHandPoint'
      '>Form1.Button3Click'
      '@Button3'
      'OnClick=Form1.N1'
      'Label1.Caption=Applying'
      'Label2.Caption=Script'
      'Label1.Font.Style=[fsBold]'
      'Label2.Font.Style=[fsItalic]'
      '!Button4=TButton(Form1)'
      '@Button4'
      'Left=350'
      'Top=110'
      'Width=200'
      'Caption=Button4'
      'OnClick=Button3.OnClick'
      ''
      '')
    TabOrder = 4
  end
  object Button3: TButton
    Left = 350
    Top = 80
    Width = 200
    Height = 25
    Caption = 'Button3'
    TabOrder = 5
    OnClick = Button3Click
  end
  object RTScript1: TRTScript
    Active = True
    ConnectionObject = Owner
    CommandLine = Edit1
    LogEnabled = True
    Left = 340
    Top = 250
  end
  object PopupMenu1: TPopupMenu
    Left = 490
    Top = 250
    object Popup11: TMenuItem
      Caption = 'Popup 1'
    end
    object Popup21: TMenuItem
      Caption = 'Popup 2'
    end
  end
end
