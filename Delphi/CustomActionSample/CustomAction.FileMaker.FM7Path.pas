unit CustomAction.FileMaker.FM7Path;
interface
uses
  SysUtils,
  Classes,
  routines_msi,
  Msi,
  MsiDefs, CustomAction.FileMaker ,
  MsiQuery;


function FM7Path(hInstall: MSIHANDLE): UINT; stdcall;
function FM7BinPath(hInstall: MSIHANDLE): UINT; stdcall;
implementation
uses
   Youseful.exceptions,CustomAction.Logging;

function FM7BinPath(hInstall: MSIHANDLE): UINT; stdcall;
var
  Rtn :integer;
begin
   msiLog(hInstall, 'FM7BinPath Entered');
    rtn := GetFMBinPath(hInstall,'FMPRO70','FM70BIN');
   msiLog(hInstall, 'FM7BinPath Entered');
end;

function FM7Path(hInstall: MSIHANDLE): UINT; stdcall;
var
  Rtn :integer;
begin
   msiLog(hInstall, 'FM7Path Entered');
    rtn := GetFMPath(hInstall,'FMPRO70','FM70EXT');
   msiLog(hInstall, 'FM7Path Entered');
end;

end.
