unit CustomAction.FileMaker.FM7DevPath;
interface
uses
  SysUtils,
  Classes,
  routines_msi,
  Msi,
  MsiDefs, CustomAction.FileMaker ,
  MsiQuery;


function FM7DevPath(hInstall: MSIHANDLE): UINT; stdcall;
function FM7DevBinPath(hInstall: MSIHANDLE): UINT; stdcall;
implementation
uses
   Youseful.exceptions,CustomAction.Logging;

function FM7DevBinPath(hInstall: MSIHANDLE): UINT; stdcall;
var
  Rtn :integer;
begin
   msiLog(hInstall, 'FM7DevBinPath Entered');
   result := GetFMBinPath(hInstall,'FMPRO70DEV','FM70DEVBIN');
   msiLog(hInstall, 'FM7DevBinPath Entered');
end;
function FM7DevPath(hInstall: MSIHANDLE): UINT; stdcall;
var
  Rtn :integer;
begin
   msiLog(hInstall, 'FM7DevPath Entered');
   result := GetFMPath(hInstall,'FMPRO70DEV','FM70DEVEXT');
   msiLog(hInstall, 'FM7DevPath Entered');
end;

end.
