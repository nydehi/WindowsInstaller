unit CustomAction.Launch;
interface
uses
  SysUtils,
  Classes,Windows,
  routines_msi,
  Msi,
  MsiDefs,
  MsiQuery;
const
  ERROR_INSTALL_FAILURE = 1603;
  ERROR_SUCCESS =0;
  ERROR_MORE_DATA =234;
  
function Launch(hInstall: MSIHANDLE): UINT; stdcall;

implementation
uses
   Youseful.exceptions,CustomAction.Logging,
   Youseful.System.Shell.Process.Component;
function Launch(hInstall: MSIHANDLE): UINT; stdcall;
var
  hRec :  MSIHANDLE;
  cchPath : DWORD;
  szPath : AnsiString;
  PL :  TProgramLauncher;
begin
  msiLog(hInstall, 'Launch Entered');

  cchPath := 0;
  szPath := '';
  if (ERROR_MORE_DATA = MsiGetProperty(hInstall,'Launch',PAnsiChar(szPath), cchPath)) then
  begin
    inc(cchPath);
    msiLog(hInstall, 'MsiGetProperty');
    msiLog(hInstall, Format('cchPath %d',[cchPath]));
    SetLength(szPath,cchPath);
    if (MsiGetProperty(hInstall,'Launch',PAnsiChar(szPath), cchPath)=ERROR_SUCCESS ) then
    begin
      msiLog(hInstall,'szPath '+ szPath);
      PL :=  TProgramLauncher.Create(nil);
      try
        PL.FileName := szPath;
        PL.Parameters := '';//' /c ipconfig.exe';
        PL.Launch;
      finally
        PL.free();
      end;
    end;
  end;
  
end;
{
function Launch(hInstall: MSIHANDLE): UINT; stdcall;
var
  hRec :  MSIHANDLE;
  cchPath : DWORD;
  szPath : AnsiString;
  PL :  TProgramLauncher;
begin
  msiLog(hInstall, 'Launch Entered');
  hRec := MsiCreateRecord(1);
  if (hRec = 0 ) then
  begin
    msiLog(hInstall, 'hRec = 0');
    msiLog(hInstall, Format('hRec %d',[hRec]));
    result := ERROR_INSTALL_FAILURE;
  end;
  if (MsiRecordSetString(hRec, 0, '[Launch]')=0) then
  begin
     msiLog(hInstall, 'MsiRecordSetString ERROR_INSTALL_FAILURE');
	  result := ERROR_INSTALL_FAILURE;
  end;
  cchPath := 0;
  if (ERROR_MORE_DATA = MsiFormatRecord(hInstall, hRec, nil, cchPath)) then
  begin
    inc(cchPath);
    SetLength(szPath,cchPath);
    if (MsiFormatRecord(hInstall, hRec, PAnsiChar(szPath), cchPath)=ERROR_SUCCESS ) then
    begin
      msiLog(hInstall,'szPath '+ szPath);
      PL :=  TProgramLauncher.Create(nil);
      try
        PL.FileName := szPath;
      finally
        PL.free();
      end;
    end;
  end;
  MsiCloseHandle(hRec); 
end;
   }
end.
