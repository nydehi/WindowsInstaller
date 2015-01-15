unit Youseful.System.Registry.Routines;
(*----------------------------------------------------------------------------
 *  This program is confidential and proprietary to Mele Systems, LLC and
 *  MAY NOT BE REPRODUCED, PUBLISHED OR DISCLOSED TO OTHERS
 *  WITHOUT COMPANY AUTHORIZATION.
 *  Copyright: (c)1999 by  MELE Systems, LLC
 *      ALL RIGHTS RESERVED
 *----------------------------------------------------------------------------*)

interface

uses
  Windows, SysUtils, Classes, Registry;

type
  TRootKeys = (hkClassesRoot,hkCurrentConfig,hkCurrentUser,hkDynData,hkLocalMachine,hkUsers);
  EIRCannotWriteValue = class(Exception);

function HKEYToTRootKeys(Key: HKEY): TRootKeys; platform; deprecated;
{ Allows you to use the TRootkeys type rather than the HKEY_xxx constants }
procedure SetTheRoot(ARegistry: TRegistry;Root: TRootKeys);
{ Gets a boolean out of the registry }
function GetRVBoolean(Root: TRootKeys;const Key,Ident: String;Default: Boolean): Boolean;platform; deprecated;
{ Gets an integer out of the registry }
function GetRVInteger(Root: TRootKeys;const Key,Ident: String;Default: Integer): Integer;  platform; deprecated;
{ Gets a string out of the registry }
function GetRVStr(Root: TRootKeys;const Key,Ident,Default: String): String;platform; deprecated;
{ Writes a string into the registry }
procedure WriteRVStr(Root: TRootKeys;const Key,Ident,Value: String);platform; deprecated;
{ Writes an integer into the registry }
procedure WriteRVInteger(Root: TRootKeys;const Key,Ident: String;Value: Integer); platform; deprecated;
{ Writes a boolean into the registry }
procedure WriteRVBoolean(Root: TRootKeys;const Key,Ident: String;Value: Boolean); platform; deprecated;
{ Delete a key }
procedure DeleteKey(Root: TRootKeys;const Key: String);platform; deprecated;
{ Delete an identifier in a key }
procedure DeleteIdent(Root: TRootKeys;const Key,Ident: String); platform; deprecated;
{ Get all the identifiers for a key }
procedure GetIdents(Root: TRootKeys;const Key: String;Idents: TStrings);platform; deprecated;
{ Get all the subkeys for a key }
procedure GetKeys(Root: TRootKeys;const Key: String;SubKeys: TStrings);platform; deprecated;
{ Register run once }
function RegisterRunOnce(Ident: String;const Value: String;IdentUnique: Boolean): Boolean; platform; deprecated;

implementation

uses
 Youseful.System.Registry.Component,Youseful.Routines.Strings,
 Youseful.System.Routines;

const
  RegisterOnceKey = '\Software\Microsoft\Windows\CurrentVersion\RunOnce';

function HKEYToTRootKeys(Key: HKEY): TRootKeys;
begin
  case Key of
    HKEY_CLASSES_ROOT: Result := hkClassesRoot;
    HKEY_CURRENT_USER: Result := hkCurrentUser;
    HKEY_LOCAL_MACHINE: Result := hkLocalMachine;
    HKEY_USERS: Result := hkUsers;
    HKEY_CURRENT_CONFIG: Result := hkCurrentConfig;
    HKEY_DYN_DATA: Result := hkDynData;
  end;
end;

procedure SetTheRoot(ARegistry: TRegistry;Root: TRootKeys);
begin
  case Root of
    hkClassesRoot: ARegistry.RootKey := HKEY_CLASSES_ROOT;
    hkCurrentUser: ARegistry.RootKey := HKEY_CURRENT_USER;
    hkLocalMachine: ARegistry.RootKey := HKEY_LOCAL_MACHINE;
    hkUsers: ARegistry.RootKey := HKEY_USERS;
    hkCurrentConfig: ARegistry.RootKey :=  HKEY_CURRENT_CONFIG;
    hkDynData: ARegistry.RootKey := HKEY_DYN_DATA;
  end;
end;

procedure WriteRVStr(Root: TRootKeys;const Key,Ident,Value: String);
var
  Registry: TysflRegistry;
begin
  Registry := TysflRegistry.Create;
  try
    SetTheRoot(Registry,Root);
    if not Registry.OpenKey(Key,TRUE) then
      raise EIRCannotWriteValue.Create(Format('Cannot install into registry. Key: %s Ident: %s Value %s',[Key,Ident,Value]));
    try
      Registry.WriteString(Ident,Value);
    except
      raise EIRCannotWriteValue.Create(Format('Cannot install into registry. Key: %s Ident: %s Value %s',[Key,Ident,Value]));
    end;
  finally
    Registry.Free;
  end;
end;

procedure WriteRVBoolean(Root: TRootKeys;const Key,Ident: String;Value: Boolean);
var
  Registry: TysflRegistry;
begin
  Registry := TysflRegistry.Create;
  try
    SetTheRoot(Registry,Root);
    if not Registry.OpenKey(Key,TRUE) then raise EIRCannotWriteValue.Create(Key);
    try
      Registry.WriteBool(Ident,Value);
    except
      raise EIRCannotWriteValue.Create(Key);
    end;
  finally
    Registry.Free;
  end;
end;

procedure WriteRVInteger(Root: TRootKeys;const Key,Ident: String;Value: Integer);
var
  Registry: TysflRegistry;
begin
  Registry := TysflRegistry.Create;
  try
    SetTheRoot(Registry,Root);
    if not Registry.OpenKey(Key,TRUE) then raise EIRCannotWriteValue.Create(Key);
    try
      Registry.WriteInteger(Ident,Value);
    except
      raise EIRCannotWriteValue.Create(Key);
    end;
  finally
    Registry.Free;
  end;
end;

function GetRVStr(Root: TRootKeys;const Key,Ident,Default: String): String;
var
  Registry: TysflRegistry;
begin
  Result := Default;
  Registry := TysflRegistry.Create;
  try
    SetTheRoot(Registry,Root);
    if not Registry.KeyExists(Key) then Exit;
    if not Registry.OpenKey(Key,FALSE) then Exit;
    if not Registry.ValueExists(Ident) then Exit;
    try
      Result := Registry.ReadString(Ident);
    except
      Result := Default;
    end;
  finally
    Registry.Free;
  end;
end;

function GetRVBoolean(Root: TRootKeys;const Key,Ident: String;Default: Boolean): Boolean;
var
  Registry: TysflRegistry;
begin
  Result := Default;
  Registry := TysflRegistry.Create;
  try
    SetTheRoot(Registry,Root);
    if not Registry.KeyExists(Key) then Exit;
    if not Registry.OpenKey(Key,FALSE) then Exit;
    if not Registry.ValueExists(Ident) then Exit;
    try
      Result := Registry.ReadBool(Ident);
    except
      Result := Default;
    end;
  finally
    Registry.Free;
  end;
end;

function GetRVInteger(Root: TRootKeys;const Key,Ident: String;Default: Integer): Integer;
var
  Registry: TysflRegistry;
begin
  Result := Default;
  Registry := TysflRegistry.Create;
  try
    SetTheRoot(Registry,Root);
    if not Registry.KeyExists(Key) then Exit;
    if not Registry.OpenKey(Key,FALSE) then Exit;
    if not Registry.ValueExists(Ident) then Exit;
    try
      Result := Registry.ReadInteger(Ident);
    except
      Result := Default;
    end;
  finally
    Registry.Free;
  end;
end;

procedure DeleteKey(Root: TRootKeys;const Key: String);
var
  Registry: TysflRegistry;
  KeyNames: TStringList;
  I: Integer;
begin
  Registry := TysflRegistry.Create;
  KeyNames := TStringList.Create;
  try
    SetTheRoot(Registry,Root);
    try
      if not Registry.OpenKey(Key,False) then Exit;
      { In WindowsNT we must delete all sub-keys before we can delete this key, so
      we will call this procedure recursively }
      Registry.GetKeyNames(KeyNames);
      Registry.CloseKey;
      for I := 0 to KeyNames.Count-1 do
        DeleteKey(Root,DirectoryWBS(Key)+KeyNames[I]);
      { Delete the "root" key }
      Registry.DeleteKey(Key);
    except
      ;
    end;
  finally
    Registry.Free;
    KeyNames.Free;
  end;
end;

procedure DeleteIdent(Root: TRootKeys;const Key,Ident: String);
var
  Registry: TysflRegistry;
begin
  Registry := TysflRegistry.Create;
  try
    SetTheRoot(Registry,Root);
    if not Registry.KeyExists(Key) then Exit;
    if not Registry.OpenKey(Key,FALSE) then Exit;
    try
      Registry.DeleteValue(Ident)
    except
      ;
    end;
  finally
    Registry.Free;
  end;
end;

procedure GetIdents(Root: TRootKeys;const Key: String;Idents: TStrings);
var
  Registry: TysflRegistry;
begin
  Idents.Clear;
  Registry := TysflRegistry.Create;
  try
    SetTheRoot(Registry,Root);
    if not Registry.KeyExists(Key) then Exit;
    if not Registry.OpenKey(Key,FALSE) then Exit;
    Registry.GetValueNames(Idents);
  finally
    Registry.Free;
  end;
end;

procedure GetKeys(Root: TRootKeys;const Key: String;SubKeys: TStrings);
var
  Registry: TysflRegistry;
begin
  SubKeys.Clear;
  Registry := TysflRegistry.Create;
  try
    SetTheRoot(Registry,Root);
    if not Registry.KeyExists(Key) then Exit;
    if not Registry.OpenKey(Key,FALSE) then Exit;
    Registry.GetKeyNames(SubKeys);
  finally
    Registry.Free;
  end;
end;

function RegisterRunOnce(Ident: String;const Value: String;IdentUnique: Boolean): Boolean;
var
  Registry: TysflRegistry;
  I: LongInt;
  Suffix: String;
begin
  Result := False;
  Registry := TysflRegistry.Create;
  try
    if GetOsVerType in WinNT then
       Registry.RootKey := HKEY_CURRENT_USER
    else
       Registry.RootKey := HKEY_LOCAL_MACHINE;
    if not Registry.OpenKey(RegisterOnceKey,True) then Exit;
    { Create a unique identifier if necessary by attaching a numeric suffix }
    Suffix := '';
    I := 0;
    while IdentUnique and Registry.ValueExists(Ident+Suffix) do begin
      Inc(I);
      Suffix := IntToStr(I);
    end;
    try
      Registry.WriteString(Ident+Suffix,Value);
    except
      Exit;
    end;
    Registry.LazyWrite := False;
    Registry.CloseKey;
    Result := True;
  finally
    Registry.Free;
  end;
end;

end. platform; deprecated;
