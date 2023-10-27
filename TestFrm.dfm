object Form54: TForm54
  Left = 0
  Top = 0
  Caption = 'Comparison of TCriticalSection and TMonitor'
  ClientHeight = 433
  ClientWidth = 622
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    622
    433)
  TextHeight = 15
  object Button1: TButton
    Left = 8
    Top = 16
    Width = 150
    Height = 25
    Caption = 'Run Test NoSync'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 47
    Width = 606
    Height = 378
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
  end
  object Button2: TButton
    Tag = 1
    Left = 164
    Top = 16
    Width = 150
    Height = 25
    Caption = 'Run Test TCriticalSection'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button3: TButton
    Tag = 2
    Left = 320
    Top = 16
    Width = 150
    Height = 25
    Caption = 'Run Test TMonitor'
    TabOrder = 3
    OnClick = Button1Click
  end
end
