object _fastbut: T_fastbut
  Left = 825
  Top = 406
  Anchors = [akLeft, akTop, akRight, akBottom]
  AutoSize = True
  BorderStyle = bsToolWindow
  ClientHeight = 31
  ClientWidth = 525
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 120
  TextHeight = 16
  object SpeedButton1: TSpeedButton
    Left = 0
    Top = 0
    Width = 105
    Height = 31
    Caption = 'Venta (F2)'
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 105
    Top = 0
    Width = 105
    Height = 31
    Caption = 'Caixa (F3)'
    OnClick = SpeedButton2Click
  end
  object SpeedButton3: TSpeedButton
    Left = 315
    Top = 0
    Width = 105
    Height = 31
    Caption = 'pressupost (F5)'
    OnClick = SpeedButton3Click
  end
  object SpeedButton4: TSpeedButton
    Left = 210
    Top = 0
    Width = 105
    Height = 31
    Caption = 'Obrir caixa (F4)'
    OnClick = SpeedButton4Click
  end
  object SpeedButton5: TSpeedButton
    Left = 420
    Top = 0
    Width = 105
    Height = 31
    Caption = 'Averia (F6)'
    OnClick = SpeedButton5Click
  end
end
