object frmMain: TfrmMain
  Left = 0
  Top = 0
  Margins.Left = 0
  Margins.Right = 0
  Margins.Bottom = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Snake Game'
  ClientHeight = 748
  ClientWidth = 702
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
  object DrawGrid1: TDrawGrid
    Left = 0
    Top = 0
    Width = 700
    Height = 700
    ColCount = 1
    DefaultRowHeight = 10
    Enabled = False
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 707
    Width = 702
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 8
    ExplicitTop = 816
    ExplicitWidth = 185
    object Label1: TLabel
      Left = 499
      Top = 16
      Width = 34
      Height = 13
      Caption = 'Speed:'
    end
    object Label2: TLabel
      Left = 413
      Top = 16
      Width = 25
      Height = 13
      Caption = 'Size:'
    end
    object lbScore: TLabel
      Left = 0
      Top = 0
      Width = 99
      Height = 41
      Align = alLeft
      Caption = 'Score: 0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitTop = 8
      ExplicitHeight = 30
    end
    object btnStart: TButton
      Left = 600
      Top = 11
      Width = 83
      Height = 25
      Caption = 'Start'
      TabOrder = 0
      OnClick = btnStartClick
    end
    object spSize: TSpinEdit
      Left = 444
      Top = 11
      Width = 49
      Height = 22
      MaxValue = 99999
      MinValue = 1
      TabOrder = 1
      Value = 50
    end
    object spSpeed: TSpinEdit
      Left = 536
      Top = 11
      Width = 49
      Height = 22
      MaxValue = 99999
      MinValue = 1
      TabOrder = 2
      Value = 10
    end
  end
end
