unit CustomAction.FileMaker.FM85AdvPath;
interface
uses
  SysUtils,Windows,
  Classes,
  routines_msi,
  Msi, CustomAction.FileMaker,
  MsiDefs ,
  MsiQuery;

function FM85AdvPath(hInstall: MSIHANDLE): UINT; stdcall;
function FM85AdvBinPath(hInstall: MSIHANDLE): UINT; stdcall;

implementation
uses
   Youseful.exceptions,CustomAction.Logging;
function FM85AdvBinPath(hInstall: MSIHANDLE): UINT; stdcall;
var
  Rtn :integer;
begin
  msiLog(hInstall, 'FM85AdvBinPath Entered');
  rtn := GetFMBinPath(hInstall,'FMPRO85ADV','FM85ADVBIN');
  msiLog(hInstall, 'FM85AdvBinPath Left');
  result := Rtn;
end;

function FM85AdvPath(hInstall: MSIHANDLE): UINT; stdcall;
var
  Rtn :integer;
begin
  msiLog(hInstall, 'FM85AdvPath Entered');
  rtn := GetFMPath(hInstall,'FMPRO85ADV','FM85ADVEXT');
  msiLog(hInstall, 'FM85AdvPath Left');
  result := Rtn;
end;

end.
