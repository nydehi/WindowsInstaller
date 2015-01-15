unit CustomAction.FileMaker.FM9AdvPath;
interface
uses
  SysUtils,Windows,
  Classes,
  routines_msi,
  Msi, CustomAction.FileMaker,
  MsiDefs ,
  MsiQuery;

function FM9AdvPath(hInstall: MSIHANDLE): UINT; stdcall;
function FM9AdvBinPath(hInstall: MSIHANDLE): UINT; stdcall;
implementation
uses
   Youseful.exceptions,CustomAction.Logging;

function FM9AdvBinPath(hInstall: MSIHANDLE): UINT; stdcall;
var
  Rtn :integer;
begin
  msiLog(hInstall, 'FM9AdvBinPath Entered');
  result := GetFMBINPath(hInstall,'FMPRO90ADV','FM90ADVBIN');
  msiLog(hInstall, 'FM9AdvBinPath Left');
end;

function FM9AdvPath(hInstall: MSIHANDLE): UINT; stdcall;
var
  Rtn :integer;
begin
  msiLog(hInstall, 'FM9AdvPath Entered');
  result := GetFMPath(hInstall,'FMPRO90ADV','FM90ADVEXT');
  msiLog(hInstall, 'FM9AdvPath Left');
end;

end.
