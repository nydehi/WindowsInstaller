unit CustomAction.LaunchDOS;

interface
uses
  SysUtils,
  Classes,Windows,
  routines_msi,
  Msi,
  MsiDefs,
  MsiQuery;

  
function LaunchDOS(hInstall: MSIHANDLE): UINT; stdcall;

implementation
uses
   Youseful.exceptions,CustomAction.Logging,
   Youseful.System.Shell.Process.Component;
   
function LaunchDOS(hInstall: MSIHANDLE): UINT; stdcall;
var
  hRec :  MSIHANDLE;
  cchPath : DWORD;
  szPath : AnsiString;
  PL :  TProgramLauncher;
begin
  msiLog(hInstall, 'LaunchDOS Entered');
  cchPath := 0;
  szPath := '';
  MsiSetProperty(hInstall,'DosOutput','From the custom action');
  if (ERROR_MORE_DATA = MsiGetProperty(hInstall,'ysflLaunchDOS',PAnsiChar(szPath), cchPath)) then
  begin
    inc(cchPath);
    msiLog(hInstall, 'MsiGetProperty');
    msiLog(hInstall, Format('cchPath %d',[cchPath]));
    SetLength(szPath,cchPath);
    if (MsiGetProperty(hInstall,'ysflLaunchDOS',PAnsiChar(szPath), cchPath)=ERROR_SUCCESS ) then
    begin
      msiLog(hInstall,'szPath '+ szPath);
      PL :=  TProgramLauncher.Create(nil);
      try
        PL.FileName := szPath;
        PL.CaptureDosOutput;
      finally
        PL.free();
      end;
    end;
  end;
  msiLog(hInstall,'DosOutput '+ PL.ConsoleOutput.text);
  MsiSetProperty(hInstall,'DosOutput',PAnsiChar(PL.ConsoleOutput.text));
end;





end.
