unit Snake.Canvas;

interface

uses
   System.SysUtils,
   System.UITypes,
   Vcl.Grids,
   Vcl.Graphics,
   Winapi.Windows,
   Snake.Enums,
   Snake.Classes;

type
   TSnakeCanvas = class
   private
      FDrawGrid: TDrawGrid;
      FMatrix : Matrix;

      procedure DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
   public
      constructor Create;

      property Matrix : Matrix read FMatrix write FMatrix;
      property DrawGrid : TDrawGrid read FDrawGrid write FDrawGrid;

      procedure Start;
   end;

implementation

{ TSnakeCanvas }

constructor TSnakeCanvas.Create;
begin
   FDrawGrid := nil;
end;

procedure TSnakeCanvas.DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
   case FMatrix[ACol][ARow] of
      cvNull  : TDrawGrid(Sender).Canvas.Brush.Color := clWhite;
      cvSnake : TDrawGrid(Sender).Canvas.Brush.Color := clGreen;
      cvScore : TDrawGrid(Sender).Canvas.Brush.Color := clRed;
   end;

   TDrawGrid(Sender).Canvas.FillRect(Rect);
end;

procedure TSnakeCanvas.Start;
var LSize       : Integer;
    LSquareSize : Integer;
begin
   if not Assigned(FDrawGrid) then
      raise Exception.Create('not Assigned DrawGrid');

   LSize := Length(FMatrix);

   if FDrawGrid.Width < FDrawGrid.Height then
      LSquareSize := FDrawGrid.Width div LSize
   else
      LSquareSize := FDrawGrid.Height div LSize;

   LSquareSize := LSquareSize - 1;

   FDrawGrid.ScrollBars       := System.UITypes.TScrollStyle.ssNone;
   FDrawGrid.Enabled          := False;
   FDrawGrid.DefaultColWidth  := LSquareSize;
   FDrawGrid.DefaultRowHeight := LSquareSize;
   FDrawGrid.ColCount         := LSize;
   FDrawGrid.RowCount         := LSize;
   FDrawGrid.OnDrawCell       := DrawCell;
end;

end.
