unit CustomAction.FileMaker.FM6Path;
interface
uses
  SysUtils,
  Classes,
  routines_msi,
  Msi,
  MsiDefs, CustomAction.FileMaker,
  MsiQuery;


function FM6Path(hInstall: MSIHANDLE): UINT; stdcall;
function FM6BinPath(hInstall: MSIHANDLE): UINT; stdcall;
implementation
uses
   Youseful.exceptions,CustomAction.Logging;
function FM6BinPath(hInstall: MSIHANDLE): UINT; stdcall;
begin
   msiLog(hInstall, 'FM6BinPath Entered');
   GetFMBinPath(hInstall,'FMPRO60','FM60BIN');
   msiLog(hInstall, 'FM6BinPath Entered');
end;
function FM6Path(hInstall: MSIHANDLE): UINT; stdcall;
begin
   msiLog(hInstall, 'FM6Path Entered');
   GetFMPath(hInstall,'FMPRO60','FM60EXT');
   msiLog(hInstall, 'FM6Path Entered');
end;

end.
