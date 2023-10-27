unit TestFrm;

interface

{ The purpose of this test code is to demonstrate the comparison between using
  TMonitor and TCriticalSection for multi-thread synchronization to a resource.
  Author - Sean Solberg
  Freely available code with no restrictions.
}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, SyncObjs;

type
  TMyResource = class
  public
    fCriticalSection: TCriticalSection;
    fValue: int64;

    constructor Create;
    destructor Destroy; override;
  end;

  TMyThread = class(TThread)
  private
    fResource: TMyResource;
    fTest: integer;
    fIterationCount: integer;
    procedure Test0;
    procedure Test1;
    procedure Test2;
    procedure DoMath;
  public
    constructor Create(aResource: TMyResource; aTest: integer; aIterationCount: integer);
    procedure Execute; override;
  end;

  TForm54 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    fResource: TMyResource;
  public
    { Public declarations }
  end;

var
  Form54: TForm54;

implementation

{$R *.dfm}

procedure TForm54.Button1Click(Sender: TObject);
var
  lTestType: integer;
  lT1, lT2, lT3: TMyThread;
  lStart: TDateTime;
begin
  // note:  not using try..finally here just for brevity
  lStart := now;
  fResource.fValue := 0;
  lTestType := TButton(Sender).Tag;

  lT1 := TMythread.Create(fResource, lTestType, 100000);
  lT2 := TMythread.Create(fResource, lTestType, 100000);
  lT3 := TMythread.Create(fResource, lTestType, 100000);

  lT1.WaitFor;
  lT2.WaitFor;
  lT3.WaitFor;

  Memo1.Lines.Add('Value: '+IntToStr(fResource.fValue) + ', Time: '+FloatToStr((now-lStart)*24*60*60));

  lT1.Free;
  lT2.Free;
  lT3.Free;
end;

procedure TForm54.FormCreate(Sender: TObject);
begin
  fResource := TMyResource.Create;
end;

procedure TForm54.FormDestroy(Sender: TObject);
begin
  fResource.Free;
end;


{ TMyResource }

constructor TMyResource.Create;
begin
  inherited;
  fCriticalSection := TCriticalSection.create;
end;

destructor TMyResource.Destroy;
begin
  fCriticalSection.Free;
  inherited;
end;

{ TMyThread }

constructor TMyThread.Create(aResource: TMyResource; aTest, aIterationCount: integer);
begin
  inherited Create(true);
  fResource := aResource;
  fTest := aTest;
  fIterationCount := aIterationCount;
  resume;
end;

procedure TMyThread.DoMath;
begin
  fResource.fValue := fResource.fValue+3;
  fResource.fValue := fResource.fValue-3;
  fResource.fValue := fResource.fValue+1;
end;

procedure TMyThread.Execute;
begin
  case fTest of
    0: Test0;
    1: Test1;
    2: Test2;
  end;
end;

procedure TMyThread.Test0;
var
  i: integer;
begin
  // This test will execute the math problem without any thread synching
  // Note that this test will NOT correctly calculate the final resource value because it is not thread synchronized.
  for i := 1 to fIterationcount do
  begin
    DoMath;
  end;
end;

procedure TMyThread.Test1;
var
  i: integer;
begin
  // this test will execute the math problem using the CriticalSection
  for i := 1 to fIterationcount do
  begin
    fResource.fCriticalSection.Enter;
    try
      DoMath;
    finally
      fResource.fCriticalSection.Leave;
    end;
  end;
end;

procedure TMyThread.Test2;
var
  i: integer;
begin
  // this test will execute the math problem using TMonitor
  for i := 1 to fIterationcount do
  begin
    System.TMonitor.Enter(fResource);
    try
      DoMath;
    finally
      System.TMonitor.Exit(fResource);
    end;
  end;
end;

end.
