unit CustomAction.FileMaker.FM9Path;
interface
uses
  SysUtils,
  Classes,
  routines_msi,
  Msi,
  MsiDefs, CustomAction.FileMaker ,
  MsiQuery;


function FM9Path(hInstall: MSIHANDLE): UINT; stdcall;
function FM9BinPath(hInstall: MSIHANDLE): UINT; stdcall;
implementation
uses
   Youseful.exceptions,CustomAction.Logging;

function FM9BinPath(hInstall: MSIHANDLE): UINT; stdcall;
var
  Rtn :integer;
begin
   msiLog(hInstall, 'FM9BinPath Entered');
   result := GetFMBinPath(hInstall,'FMPRO90','FM90BIN');
   msiLog(hInstall, 'FM9BinPath Entered');
end;

function FM9Path(hInstall: MSIHANDLE): UINT; stdcall;
var
  Rtn :integer;
begin
   msiLog(hInstall, 'FM9Path Entered');
   result := GetFMPath(hInstall,'FMPRO90','FM90EXT');
   msiLog(hInstall, 'FM9Path Entered');
end;

end.
