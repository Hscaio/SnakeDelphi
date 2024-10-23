unit Snake.Game;

interface

uses System.Generics.Collections,
     System.SysUtils,
     System.Threading,

     Snake.Enums,
     Snake.Classes;

type
  TSnakeCell = class
  strict private
     FX : Integer;
     FY : Integer;
  public
     constructor Create(aX, aY : Integer);
     property X : Integer read FX write FX;
     property Y : Integer read FY write FY;
  end;

  TProcOnInputDirection = procedure (var aDirection : TSnakeDirection) of object;
  TProcOnMoveSnake = procedure (const aSnake : TObjectList<TSnakeCell>; const aCellScore : TSnakeCell; const aGameOver : Boolean) of object;

  ISnakeGame = interface
  ['{2F478189-9F8D-474A-AF59-1084A59B4FD9}']
     function GetSize: Integer;
    procedure SetSize(const Value: Integer);
     function GetOnInputDirection: TProcOnInputDirection;
    procedure SetOnInputDirection(const Value: TProcOnInputDirection);
     function GetOnMoveSnake: TProcOnMoveSnake;
    procedure SetOnMoveSnake(const Value: TProcOnMoveSnake);
     function GetSpeed: Integer;
    procedure SetSpeed(const Value: Integer);

     procedure Run;

     property Size : Integer read GetSize write SetSize;
     property Speed : Integer read GetSpeed write SetSpeed;
     property OnInputDirection : TProcOnInputDirection read GetOnInputDirection write SetOnInputDirection;
     property OnMoveSnake : TProcOnMoveSnake read GetOnMoveSnake write SetOnMoveSnake;
  end;

  TSnakeGame = class(TInterfacedObject,ISnakeGame)
  private
    FSize : Integer;
    FSpeed : Integer;
    FOnInputDirection : TProcOnInputDirection;
    FOnMoveSnake : TProcOnMoveSnake;

    FOldHeadSnake : TSnakeCell;
    FHeadSnake : TSnakeCell;
    FTailSnake : TSnakeCell;
    FSnake : TObjectList<TSnakeCell>;
    FSnakeDirection : TSnakeDirection;
    FScore : TSnakeCell;
    FCountScore : Integer;

    FGameOver : Boolean;

     function GetSize: Integer;
    procedure SetSize(const Value: Integer);
     function GetOnInputDirection: TProcOnInputDirection;
    procedure SetOnInputDirection(const Value: TProcOnInputDirection);
     function GetOnMoveSnake: TProcOnMoveSnake;
    procedure SetOnMoveSnake(const Value: TProcOnMoveSnake);
     function GetSpeed: Integer;
    procedure SetSpeed(const Value: Integer);

     function GerateScore : Boolean;
     function MoveSnake : Boolean;

    procedure StartGame;
    procedure ExecuteGame;

    function HasSnake(X,Y :Integer) : Boolean;
    function HasScore(X,Y :Integer) : Boolean;

  public
     constructor Create;
      destructor Destroy; override;

     procedure Run;

     function GameMatrix : Matrix;

     property Size : Integer read GetSize write SetSize;
     property Speed : Integer read GetSpeed write SetSpeed;
     property OnInputDirection : TProcOnInputDirection read GetOnInputDirection write SetOnInputDirection;
     property OnMoveSnake : TProcOnMoveSnake read GetOnMoveSnake write SetOnMoveSnake;
     property Score : Integer read FCountScore;
  end;

implementation

{ TSnakeGame }

constructor TSnakeGame.Create;
begin
   FSpeed := 100;
   FScore := TSnakeCell.Create(-1,-1);
   FSnake := TObjectList<TSnakeCell>.Create;
   FSnakeDirection := sdRight;

   FHeadSnake := nil;
   FTailSnake := nil;

   FGameOver := False;
   FCountScore := 0;
end;

destructor TSnakeGame.Destroy;
begin
   FreeAndNil(FSnake);
   FreeAndNil(FScore);
   inherited;
end;

procedure TSnakeGame.ExecuteGame;
begin
   if Assigned(FOnInputDirection) then
      FOnInputDirection(FSnakeDirection);

   if (FScore.X < 0) or (FScore.Y < 0) then
      GerateScore;

   FGameOver := MoveSnake;

   if Assigned(FOnMoveSnake) then
      FOnMoveSnake(FSnake,FScore,FGameOver);
end;

function TSnakeGame.GameMatrix: Matrix;
var I: Integer;
    J: Integer;
    FCell : TSnakeCell;
begin
   SetLength(Result,FSize);
   for I := 0 to FSize - 1 do
   begin
      SetLength(Result[I],FSize);
      for J := 0 to FSize - 1 do
            Result[I][J] := cvNull;
   end;

   for FCell in FSnake do
      Result[FCell.X][FCell.Y] := cvSnake;

   if (FScore.X <> -1) and (FScore.X <> -1) then
      Result[FScore.X][FScore.Y] := cvScore;
end;

function TSnakeGame.GerateScore: Boolean;
var LNewX, LNewY : Integer;
begin
   repeat
      Randomize;
      LNewX := Random(FSize - 1);
      LNewY := Random(FSize - 1);
   until not HasSnake(LNewX,LNewY);

   FScore.X := LNewX;
   FScore.Y := LNewY;
end;

function TSnakeGame.GetOnInputDirection: TProcOnInputDirection;
begin
  Result := FOnInputDirection;
end;

function TSnakeGame.GetOnMoveSnake: TProcOnMoveSnake;
begin
  Result := FOnMoveSnake;
end;

function TSnakeGame.GetSize: Integer;
begin
   Result := FSize;
end;

function TSnakeGame.GetSpeed: Integer;
begin
  Result := FSpeed;
end;

function TSnakeGame.HasScore(X, Y: Integer): Boolean;
begin
   Result := (FScore.X = X) and (FScore.Y = Y);
end;

function TSnakeGame.HasSnake(X, Y: Integer): Boolean;
var FCell : TSnakeCell;
begin
   Result := False;
   for FCell in FSnake do
      if (FCell.X = X) and (FCell.Y = Y) then
         Exit(True);
end;

function TSnakeGame.MoveSnake: Boolean;
var LNewX, LNewY : Integer;
    LValidDirection : Boolean;
begin
   Result := False;

   repeat
      LValidDirection := True;
      LNewX  := FHeadSnake.X;
      LNewY  := FHeadSnake.Y;

      case FSnakeDirection of
        sdUp:    Dec(LNewY);
        sdDown:  Inc(LNewY);
        sdLeft:  Dec(LNewX);
        sdRight: Inc(LNewX);
      end;

      if (FOldHeadSnake.X = LNewX) and (FOldHeadSnake.Y = LNewY) then
      begin
         LValidDirection := False;
         case FSnakeDirection of
           sdUp   : FSnakeDirection := sdDown;
           sdDown : FSnakeDirection := sdUp;
           sdLeft : FSnakeDirection := sdRight;
           sdRight: FSnakeDirection := sdLeft;
         end;
      end;
   until LValidDirection;

   if (LNewX >= FSize) or (LNewX < 0) then
      Exit(True);

   if (LNewY >= FSize) or (LNewY < 0) then
      Exit(True);

   if HasSnake(LNewX,LNewY) then
      Exit(True);

   FOldHeadSnake := FHeadSnake;
   FHeadSnake := TSnakeCell.Create(LNewX,LNewY);
   FSnake.Add(FHeadSnake);

   if HasScore(LNewX,LNewY) then
   begin
      FScore.X := -1;
      FScore.Y := -1;
      Inc(FCountScore);
   end
   else
   begin
      FSnake.Remove(FTailSnake);
      FTailSnake := FSnake.First;
   end;
end;

procedure TSnakeGame.Run;
var LTask : ITask;
begin
   StartGame;
   LTask := TTask.Run(
               procedure
               begin
                  while not FGameOver do
                  begin
                     ExecuteGame;
                     if not FGameOver then
                        Sleep(FSpeed);
                  end;
               end
            );
end;

procedure TSnakeGame.SetOnInputDirection(const Value: TProcOnInputDirection);
begin
  FOnInputDirection := Value;
end;

procedure TSnakeGame.SetOnMoveSnake(const Value: TProcOnMoveSnake);
begin
   FOnMoveSnake := Value;
end;

procedure TSnakeGame.SetSize(const Value: Integer);
begin
   if Value <= 2 then
      FSize := 2
   else
      FSize := Value;
end;

procedure TSnakeGame.SetSpeed(const Value: Integer);
begin
  FSpeed := Value;
end;

procedure TSnakeGame.StartGame;
begin
   if not Assigned(FOnInputDirection) then
      raise Exception.Create('Not Assigned OnInputDirection');

   FHeadSnake := TSnakeCell.Create(1,FSize div 2);
   FTailSnake := TSnakeCell.Create(0,FSize div 2);

   FOldHeadSnake := FTailSnake;

   FGameOver   := False;
   FCountScore := 0;

   FScore.X := -1;
   FScore.Y := -1;

   FSnake.Clear;
   FSnake.Add(FHeadSnake);
   FSnake.Add(FTailSnake);
end;

{ TSnakeCell }

constructor TSnakeCell.Create(aX, aY : Integer);
begin
   FX := aX;
   FY := aY;
end;

end.
