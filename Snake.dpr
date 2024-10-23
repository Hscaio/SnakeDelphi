program Snake;

uses
  Vcl.Forms,
  fMain in 'fMain.pas' {frmMain},
  Snake.Canvas in 'source\Snake.Canvas.pas',
  Snake.Enums in 'source\Snake.Enums.pas',
  Snake.Game in 'source\Snake.Game.pas',
  Snake.Classes in 'source\Snake.Classes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
