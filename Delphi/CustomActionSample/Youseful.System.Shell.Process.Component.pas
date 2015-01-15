unit Youseful.System.Shell.Process.Component;
{This unit should never directly link to Forms, Graphics, etc because that will
cause the YousefulLauncher to be bloated}

interface
uses Classes, Windows, ShellAPI;

type
  TplShowMode = (smNormal,smMaximized,smMinimized,smHide);

const
  ShowWindowModes: array[TplShowMode] of Integer = (sw_Normal,sw_ShowMaximized,sw_ShowMinimized,sw_Hide);
  SProgramLaunchTimeOut = 'The program launcher timed out';

type
  TConsoleDataEvent = procedure(Sender: TObject; ConsoleData : string)of object;
  TProgramLauncher = class(TComponent)
  private
    FConsoleDataEvent :TConsoleDataEvent;
    FHInstance: THandle;
    FAction: String;
    FExitCode: DWord;
    FFileName: String;
    FHProcess: THandle;
    FParameters: String;
    FShowMode: TplShowMode;
    FStartDir: String;
    FTimeout: Integer;
    FWait: Boolean;
    FConsoleOutput : TStrings;
  public
    { Methods }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
    procedure ExecuteDOS;
    procedure Launch;
    procedure Spawn(Handle :HWND);
    property ExitCode: DWord read FExitCode;
    property HInstance: THandle read FHInstance;
    property HProcess: THandle read FHProcess;
    procedure CaptureDosOutput;
  published
    property Action: String read FAction write FAction;
    property FileName: String read FFileName write FFileName;
    property Parameters: String read FParameters write FParameters;
    property ShowMode: TplShowMode read FShowMode write FShowMode default smNormal;
    property StartDir: String read FStartDir write FStartDir;
    property Timeout: Integer read FTimeout write FTimeout;
    property Wait: Boolean read FWait write FWait default True;
    property ConsoleOutput : TStrings read FConsoleOutput;
    property OnConsoleData: TConsoleDataEvent read FConsoleDataEvent write FConsoleDataEvent;
  end;

implementation
uses Youseful.Exceptions, SysUtils;

{ ------------------------------ TProgramLauncher -----------------------------}

procedure CreateLaunchError(ErrorCode: Integer);
var
  ErrorMsg: String;
  TheException: EProgramLauncherFailed;
begin
  case ErrorCode of
    0,8: ErrorMsg := 'Out of memory';
    2: ErrorMsg := 'File not found';
    3: ErrorMsg := 'Path not found';
    5: ErrorMsg := 'Sharing violation';
    6: ErrorMsg := 'Library/Segment error';
    10: ErrorMsg := 'Incorrect version of windows';
    11: ErrorMsg := 'Invalid file';
    12,13: ErrorMsg := 'Invalid DOS version';
    14,31: ErrorMsg := 'File type has no association';
    15: ErrorMsg := 'Cannot load a Real-mode application';
    16: ErrorMsg := 'Invalid attempt to launch second instance';
    19: ErrorMsg := 'Cannot load a compressed executable file';
    20: ErrorMsg := 'Invalid dynamic link library';
    21: ErrorMsg := 'Application requires Win32';
  else
    ErrorMsg := 'Unknown error';
  end;
  TheException := EProgramLauncherFailed.Create(ErrorMsg);
  TheException.ErrorCode := ErrorCode;
  raise TheException;
end;

constructor TProgramLauncher.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAction := 'Open';
  FExitCode := 0;
  FHProcess := 0;
  FHInstance := 0;
  FShowMode := smNormal;
  FTimeout := 9999;
  FWait := True;
  FConsoleOutput := TStringList.Create;
end;

procedure TProgramLauncher.Launch;
var
  ShellInfo: TShellExecuteInfo;
begin
  FHInstance := 0;
  FHProcess := 0;
  FExitCode := 0;

  if Length(Trim(FStartDir)) > 0 then
  begin
    if not SetCurrentDirectory(PChar(FStartDir)) then
      raise EProgramLauncherFailed.CreateFmt('The directory %s, as specified in the StartDir property, does not exist',[FStartDir]);
  end;
  FillChar(ShellInfo,SizeOf(TShellExecuteInfo),0);
  ShellInfo.cbSize := SizeOf(TShellExecuteInfo);
  ShellInfo.fMask := SEE_MASK_NOCLOSEPROCESS;
  ShellInfo.Wnd := HWnd_Desktop;
  ShellInfo.lpVerb := PChar(FAction);
  ShellInfo.lpFile := PChar(FFileName);
  ShellInfo.lpParameters := PChar(FParameters);
  ShellInfo.lpDirectory := PChar(FStartDir);
  ShellInfo.nShow := ShowWindowModes[FShowMode];

  if ShellExecuteEx(@ShellInfo) then
    begin
      FHInstance := ShellInfo.hInstApp;
      FHProcess := ShellInfo.hProcess;
      if Wait then begin
        case WaitForSingleObject(FHProcess,FTimeout) of
          wait_Failed: CreateLaunchError(GetLastError);
          wait_Object_0: GetExitCodeProcess(FHProcess,FExitCode);
          wait_Timeout: raise EProgramLauncherTimeout.Create(SProgramLaunchTimeOut);
        end;
      end;
    end
  else
    CreateLaunchError(ShellInfo.hInstApp);
end;

destructor TProgramLauncher.Destroy;
begin
  FConsoleOutput.Free;
  inherited;
end;

procedure TProgramLauncher.ExecuteDOS;
var
  Result: LongBool;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  FillChar(StartupInfo,SizeOf(TStartupInfo),0);
  StartupInfo.cb := SizeOf(TStartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW or STARTF_FORCEONFEEDBACK;
  StartupInfo.wShowWindow := ShowWindowModes[FShowMode];
  Result := CreateProcess(PChar(FFileName),PChar(FParameters),Nil,Nil,False,NORMAL_PRIORITY_CLASS,Nil,Nil,StartupInfo,ProcessInfo);
  if Result then
    begin
      with ProcessInfo do begin
        WaitForInputIdle(hProcess,INFINITE);
        CloseHandle(hThread);
        CloseHandle(hProcess);
      end;
    end
  else
    CreateLaunchError(Integer(Result));
end;

procedure TProgramLauncher.Spawn(Handle :HWND);
begin
   ShellExecute(Handle, 'open', PChar(FFileName+' '+FParameters), nil, nil, SW_SHOW);
end;
 ///<summary>
/// PL := TProgramLauncher.Create(nil);
 /// try
///     PL.Timeout := 1000;
 ///    PL.FileName :='ping';
 ///    Pl.Parameters :='yahoo.com';
 ///    PL.CaptureDosOutput;
 ///    memo1.Lines.Text  := PL.ConsoleOutput.Text;
 /// finally
 ///    PL.Free;
 /// end;
  ///</summary>
procedure TProgramLauncher.CaptureDosOutput;
  const
     ReadBuffer = 30;//2400;
  var
   Security : TSecurityAttributes;
   ReadPipe,WritePipe : THandle;
   start : TStartUpInfo;
   ProcessInfo : TProcessInformation;
   Buffer : Pchar;
   BytesRead : DWord;
   Apprunning : DWord;
  begin
   With Security do begin
    nlength := SizeOf(TSecurityAttributes) ;
    binherithandle := true;
    lpsecuritydescriptor := nil;
   end;
   if Createpipe (ReadPipe, WritePipe,
                  @Security, 0) then begin
    Buffer := AllocMem(ReadBuffer + 1) ;
    FillChar(Start,Sizeof(Start),#0) ;
    start.cb := SizeOf(start) ;
    start.hStdOutput := WritePipe;
    start.hStdInput := ReadPipe;
    start.dwFlags := STARTF_USESTDHANDLES +
                         STARTF_USESHOWWINDOW;
    start.wShowWindow := SW_HIDE;
    if CreateProcess(nil,
          // PChar(DosApp),
           PChar(FFileName +' '+ FParameters),
           @Security,
           @Security,
           true,
           NORMAL_PRIORITY_CLASS,
           nil,
           nil,
           start,
           ProcessInfo)
    then
    begin
     repeat
      Apprunning := WaitForSingleObject
                   (ProcessInfo.hProcess,FTimeout) ;
      until (Apprunning <> WAIT_TIMEOUT) ;
      Repeat
        BytesRead := 0;
        ReadFile(ReadPipe,Buffer[0],
                 ReadBuffer,BytesRead,nil) ;
        Buffer[BytesRead]:= #0;
        OemToAnsi(Buffer,Buffer) ;
        if Assigned(FConsoleDataEvent) then
          FConsoleDataEvent(Self,String(Buffer));
        FConsoleOutput.Text :=  FConsoleOutput.text + String(Buffer) ;
      until (BytesRead < ReadBuffer) ;
   end;
   FreeMem(Buffer) ;
   CloseHandle(ProcessInfo.hProcess) ;
   CloseHandle(ProcessInfo.hThread) ;
   CloseHandle(ReadPipe) ;
   CloseHandle(WritePipe) ;
   end;
  end;
end.
 
