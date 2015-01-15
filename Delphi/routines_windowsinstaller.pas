unit routines_windowsinstaller;
(*----------------------------------------------------------------------------
 *  this program is confidential and proprietary to Mele Systems, LLC and
 *  MAY NOT BE REPRODUCED, PUBLISHED OR DISCLOSED TO OTHERS
 *  WITHOUT COMPANY AUTHORIZATION.
 *  Copyright: (c)1999 by  MELE Systems, LLC
 *      ALL RIGHTS RESERVED
 *----------------------------------------------------------------------------*)

interface

uses WindowsInstaller_TLB,classes;

procedure wiDialogList(db : WindowsInstaller_TLB.Database; var DialogList : TStrings);
procedure wiTableList(db : WindowsInstaller_TLB.Database; var TableList : TStrings; var TableCount : Integer);
//procedure wiExecuteSQL(db : WindowsInstaller_TLB.Database);

implementation


procedure wiDialogList( db : WindowsInstaller_TLB.Database; var DialogList : TStrings);
var
  view : WindowsInstaller_TLB.View;
  rc   : WindowsInstaller_TLB.Record_;
  colcnt,i : integer;
  s,s1 : string;
begin

    try
     // wi :=CreateOleObject('WindowsInstaller.Installer') as WindowsInstaller_TLB.Installer;
    //  db := wi.OpenDatabase('C:\Devtools\Sample.msi',msiOpenDatabaseModeReadOnly);

      s1:= 'SELECT `Dialog` From `Dialog`';//  ParamStr(2);
      view := db.OpenView(s1);//) ;
      view.Execute(rc);

      rc :=  view.Fetch;

      While (not (rc = nil)) do
      begin
        colcnt := rc.FieldCount;
        for i := 1 to colcnt do
        begin
          s := rc.StringData[i];
        end;
        DialogList.Add(s);
        rc :=  view.Fetch;
      end;


  //   db := nil;
    // wi := nil;
    except
     // showmessage('handle error here');
    end;

end;

procedure wiTableList( db : WindowsInstaller_TLB.Database; var TableList : TStrings; var TableCount : Integer);
var
  view : WindowsInstaller_TLB.View;
  rc   : WindowsInstaller_TLB.Record_;
  colcnt,i : integer;
  s,s1 : string;
begin
    TableCount := 0;
    try
     // wi :=CreateOleObject('WindowsInstaller.Installer') as WindowsInstaller_TLB.Installer;
    //  db := wi.OpenDatabase('C:\Devtools\Sample.msi',msiOpenDatabaseModeReadOnly);

      s1:= 'SELECT `Name` From `_Tables`';//  ParamStr(2);
      view := db.OpenView(s1);//) ;
      view.Execute(rc);

      rc :=  view.Fetch;

      While (not (rc = nil)) do
      begin
        colcnt := rc.FieldCount;
        for i := 1 to colcnt do
        begin
          s := rc.StringData[i];
        end;
        TableList.Add(s);
        TableCount := TableCount +1;
        rc :=  view.Fetch;
      end;


  //   db := nil;
    // wi := nil;
    except
     // showmessage('handle error here');
    end;

end;


end.
