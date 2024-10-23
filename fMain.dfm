object frmMain: TfrmMain
  Left = 0
  Top = 0
  Margins.Left = 0
  Margins.Right = 0
  Margins.Bottom = 0
  Caption = 'Snake Game'
  ClientHeight = 1031
  ClientWidth = 1000
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  TextHeight = 13
  object lbScore: TLabel
    Left = 0
    Top = 1000
    Width = 99
    Height = 33
    Caption = 'Score: 0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 803
    Top = 1011
    Width = 34
    Height = 13
    Caption = 'Speed:'
  end
  object Label2: TLabel
    Left = 717
    Top = 1011
    Width = 23
    Height = 13
    Caption = 'Size:'
  end
  object DrawGrid1: TDrawGrid
    Left = 0
    Top = 0
    Width = 1000
    Height = 1000
    ColCount = 1
    DefaultRowHeight = 10
    Enabled = False
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    TabOrder = 0
  end
  object btnStart: TButton
    Left = 904
    Top = 1005
    Width = 83
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = btnStartClick
  end
  object spSpeed: TSpinEdit
    Left = 840
    Top = 1006
    Width = 49
    Height = 22
    MaxValue = 99999
    MinValue = 1
    TabOrder = 2
    Value = 10
  end
  object spSize: TSpinEdit
    Left = 748
    Top = 1006
    Width = 49
    Height = 22
    MaxValue = 99999
    MinValue = 1
    TabOrder = 3
    Value = 50
  end
end
