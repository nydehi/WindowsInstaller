unit CustomAction.Logging;
interface
uses
  SysUtils,
  Classes,Windows,
  routines_msi,
  Msi,
  MsiDefs,
  MsiQuery;

procedure msiLog(hInstall: MSIHANDLE; msiMessage: string);

implementation
procedure msiLog(hInstall: MSIHANDLE;msiMessage:string);
var
  hRec :  MSIHANDLE;
begin
  hRec := MsiCreateRecord(2);
  if (hRec = 0) then
  begin
    Exception.Create('ERROR_INSTALL_FAILURE');
  end;
  msiMessage:='***Youseful msi log*** ' +msiMessage;
  MsiRecordSetString(hRec, 0,  PAnsiChar(msiMessage));
  MsiProcessMessage(hInstall, INSTALLMESSAGE_INFO, hRec);
  MsiCloseHandle(hRec); 
end;
end.
