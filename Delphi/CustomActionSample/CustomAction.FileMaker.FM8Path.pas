unit CustomAction.FileMaker.FM8Path;
interface
uses
  SysUtils,
  Classes,
  routines_msi,
  Msi,
  MsiDefs, CustomAction.FileMaker ,
  MsiQuery;


function FM8Path(hInstall: MSIHANDLE): UINT; stdcall;
function FM8BinPath(hInstall: MSIHANDLE): UINT; stdcall;

implementation
uses
   Youseful.exceptions,CustomAction.Logging;

function FM8BinPath(hInstall: MSIHANDLE): UINT; stdcall;
var
  Rtn :integer;
begin
   msiLog(hInstall, 'FM8BinPath Entered');
   result := GetFMBinPath(hInstall,'FMPRO80','FM80BIN');
   msiLog(hInstall, 'FM8BinPath Entered');
end;

function FM8Path(hInstall: MSIHANDLE): UINT; stdcall;
var
  Rtn :integer;
begin
   msiLog(hInstall, 'FM8Path Entered');
   result := GetFMPath(hInstall,'FMPRO80','FM80EXT');
   msiLog(hInstall, 'FM8Path Entered');
end;

end.
