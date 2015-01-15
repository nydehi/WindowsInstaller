unit CustomAction.FileMaker;
interface
uses
  SysUtils, Windows,
  Classes,
  routines_msi,
  Msi,
  MsiDefs,
  MsiQuery,CustomAction.Logging;


function ParsePath(hAny: MSIHANDLE): UINT; stdcall;
function GetFMPath(hInstall: MSIHANDLE;OrigPathProperty:string; ExtFolderPathProperty:string):integer;
function GetFMBinPath(hInstall: MSIHANDLE;OrigPathProperty:string; ExtFolderPathProperty:string):integer;
implementation
function GetFMBinPath(hInstall: MSIHANDLE;OrigPathProperty:string; ExtFolderPathProperty:string):integer;
var
  cchPath : DWORD;
  szPath : AnsiString;
begin
  msiLog(hInstall, 'GetFMBinPath Entered');
  cchPath := 0;
  szPath := '';
  if not Length(OrigPathProperty) > 1  then
  begin
    Result := 0;
  end
  else
  begin
    if (ERROR_MORE_DATA = MsiGetProperty(hInstall,PAnsiChar(OrigPathProperty),PAnsiChar(szPath), cchPath)) then
    begin
      inc(cchPath);
      msiLog(hInstall, 'MsiGetProperty');
      msiLog(hInstall, Format('cchPath %d',[cchPath]));
      SetLength(szPath,cchPath);
      if (MsiGetProperty(hInstall,PAnsiChar(OrigPathProperty),PAnsiChar(szPath), cchPath)=ERROR_SUCCESS ) then
      begin  //C:\Program Files\FileMaker\FileMaker Pro 8 Advanced\Extensions\Dictionaries\User.upr
        msiLog(hInstall,'szPath '+ szPath);
        szPath:= GetParentDirectory(szPath);
        msiLog(hInstall,'szPath '+ szPath);
        szPath:= GetParentDirectory(szPath);
        msiLog(hInstall,'szPath '+ szPath);
        szPath:= GetParentDirectory(szPath);
        msiLog(hInstall,'szPath '+ szPath);
        szPath:= GetParentDirectory(szPath);
        msiLog(hInstall,'szPath '+ szPath);
        MsiSetProperty(hInstall,PAnsiChar(ExtFolderPathProperty),PAnsiChar(szPath));
      end;
    end;
  end;
  msiLog(hInstall, 'GetFMBinPath Left');
end;
function GetFMPath(hInstall: MSIHANDLE;OrigPathProperty:string; ExtFolderPathProperty:string):integer;
var
  cchPath : DWORD;
  szPath : AnsiString;
begin
  msiLog(hInstall, 'GetFMPath Entered');
  cchPath := 0;
  szPath := '';
  if not Length(OrigPathProperty) > 1  then
  begin
    Result := 0;
  end
  else
  begin
    if (ERROR_MORE_DATA = MsiGetProperty(hInstall,PAnsiChar(OrigPathProperty),PAnsiChar(szPath), cchPath)) then
    begin
      inc(cchPath);
      msiLog(hInstall, 'MsiGetProperty');
      msiLog(hInstall, Format('cchPath %d',[cchPath]));
      SetLength(szPath,cchPath);
      if (MsiGetProperty(hInstall,PAnsiChar(OrigPathProperty),PAnsiChar(szPath), cchPath)=ERROR_SUCCESS ) then
      begin  //C:\Program Files\FileMaker\FileMaker Pro 8 Advanced\Extensions\Dictionaries\User.upr
        msiLog(hInstall,'szPath '+ szPath);
        szPath:= GetParentDirectory(szPath);
        msiLog(hInstall,'szPath '+ szPath);
        szPath:= GetParentDirectory(szPath);
        msiLog(hInstall,'szPath '+ szPath);
        szPath:= GetParentDirectory(szPath);
        msiLog(hInstall,'szPath '+ szPath);
        MsiSetProperty(hInstall,PAnsiChar(ExtFolderPathProperty),PAnsiChar(szPath));
      end;
    end;
  end;
  msiLog(hInstall, 'GetFMPath Left');
end;

function ParsePath(hAny: MSIHANDLE): UINT; stdcall;
begin


end;




end.
