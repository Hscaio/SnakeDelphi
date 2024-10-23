unit fMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, System.Generics.Collections,
  Snake.Canvas, Snake.Enums, Snake.Game, Vcl.StdCtrls, Vcl.Samples.Spin;

type
  TfrmMain = class(TForm)
    DrawGrid1: TDrawGrid;
    Panel1: TPanel;
    btnStart: TButton;
    Label1: TLabel;
    Label2: TLabel;
    lbScore: TLabel;
    spSize: TSpinEdit;
    spSpeed: TSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnStartClick(Sender: TObject);
  private
    { Private declarations }
    FCanvas : TSnakeCanvas;
    FGame : TSnakeGame;
    FDirection : TSnakeDirection;

    procedure OnInputDirection(var aDirection : TSnakeDirection);
    procedure OnMoveSnake(const aSnake : TObjectList<TSnakeCell>; const aCellScore : TSnakeCell; const aGameOver : Boolean);

    procedure GameOver(aValue: Boolean);
    procedure StartGame;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnStartClick(Sender: TObject);
begin
   StartGame;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
   FCanvas := TSnakeCanvas.Create;
   FGame   := TSnakeGame.Create;
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   case Key of
      VK_UP    : FDirection := sdUp;
      VK_DOWN  : FDirection := sdDown;
      VK_LEFT  : FDirection := sdLeft;
      VK_RIGHT : FDirection := sdRight;
      VK_RETURN : ShowMessage(DrawGrid1.Height.ToString + ' ' + DrawGrid1.Width.ToString);
   end;
end;

procedure TfrmMain.GameOver(aValue: Boolean);
begin
   btnStart.Enabled := aValue;
   spSpeed.Enabled  := aValue;
   spSize.Enabled   := aValue;
end;

procedure TfrmMain.OnInputDirection(var aDirection: TSnakeDirection);
begin
   aDirection := FDirection;
end;

procedure TfrmMain.OnMoveSnake(const aSnake: TObjectList<TSnakeCell>;
  const aCellScore: TSnakeCell; const aGameOver: Boolean);
begin
   TThread.Synchronize(
      TThread.CurrentThread,
      procedure
      begin
         FCanvas.Matrix := FGame.GameMatrix;
         DrawGrid1.Repaint;

         lbScore.Caption := 'Pontos: ' + FGame.Score.ToString;

         GameOver(aGameOver);
         if aGameOver then
            ShowMessage('Game Over');
      end);
end;

procedure TfrmMain.StartGame;
begin
   FDirection := sdRight;

   FGame.Size := spSize.Value;
   FGame.Speed := spSpeed.Value;
   FCanvas.DrawGrid := DrawGrid1;
   FCanvas.Matrix   := FGame.GameMatrix;

   FGame.OnInputDirection := OnInputDirection;
   FGame.OnMoveSnake      := OnMoveSnake;
   FGame.Run;

   FCanvas.Start;
   DrawGrid1.Repaint;
end;

end.
