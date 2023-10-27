program TestMonitorAndCriticalSection;

uses
  Vcl.Forms,
  TestFrm in 'TestFrm.pas' {Form54};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm54, Form54);
  Application.Run;
end.
