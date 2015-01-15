unit CustomAction.FileMaker.FM85Path;
interface
uses
  SysUtils,Windows,
  Classes,
  routines_msi,
  Msi, CustomAction.FileMaker,
  MsiDefs ,
  MsiQuery;

function FM85Path(hInstall: MSIHANDLE): UINT; stdcall;
function FM85BinPath(hInstall: MSIHANDLE): UINT; stdcall;
implementation
uses
   Youseful.exceptions,CustomAction.Logging;

function FM85BinPath(hInstall: MSIHANDLE): UINT; stdcall;
var
  Rtn :integer;
begin
  msiLog(hInstall, 'FM85BinPath Entered');
  result := GetFMBinPath(hInstall,'FMPRO85','FM85BIN');
  msiLog(hInstall, 'FM85BinPath Left');
end;

function FM85Path(hInstall: MSIHANDLE): UINT; stdcall;
var
  Rtn :integer;
begin
  msiLog(hInstall, 'FM85Path Entered');
  result := GetFMPath(hInstall,'FMPRO85','FM85EXT');
  msiLog(hInstall, 'FM85Path Left');
end;

end.
