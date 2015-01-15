unit CustomAction.FileMaker.FM8AdvPath;
interface
uses
  SysUtils,Windows,
  Classes,
  routines_msi,
  Msi, CustomAction.FileMaker,
  MsiDefs ,
  MsiQuery;

function FM8AdvPath(hInstall: MSIHANDLE): UINT; stdcall;
function FM8AdvBinPath(hInstall: MSIHANDLE): UINT; stdcall;
implementation
uses
   Youseful.exceptions,CustomAction.Logging;

function FM8AdvBinPath(hInstall: MSIHANDLE): UINT; stdcall;
var
  Rtn :integer;
begin
  msiLog(hInstall, 'FM8AdvBinPath Entered');
  result := GetFMBinPath(hInstall,'FMPRO80ADV','FM80ADVBIN');
  msiLog(hInstall, 'FM8AdvBinPath Left');
end;
function FM8AdvPath(hInstall: MSIHANDLE): UINT; stdcall;
var
  Rtn :integer;
begin
  msiLog(hInstall, 'FM8AdvPath Entered');
  result := GetFMPath(hInstall,'FMPRO80ADV','FM80ADVEXT');
  msiLog(hInstall, 'FM8AdvPath Left');
end;

end.
