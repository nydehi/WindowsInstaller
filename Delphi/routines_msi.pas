unit routines_msi;
 (*----------------------------------------------------------------------------
 *  this program is confidential and proprietary to Mele Systems, LLC and
 *  MAY NOT BE REPRODUCED, PUBLISHED OR DISCLOSED TO OTHERS
 *  WITHOUT COMPANY AUTHORIZATION.
 *  Copyright: (c)2000 by  MELE Systems, LLC
 *      ALL RIGHTS RESERVED
 *----------------------------------------------------------------------------*)
interface     
   uses msiquery,Msi,MsiDefs,sysutils,classes;///,Types;

//Database functionality
procedure MsiDBOpen(path: string; mode: PCHAR; var handle: MSIHANDLE);
procedure MsiDBCommit(dbhandle: MSIHANDLE);
procedure MsiDBMerge(dbhandle1: MSIHANDLE; dbhandle2: MSIHANDLE);
//individual property manipulation
procedure MsiGetProperty(dbhandle: MSIHANDLE; Tablename:String;PropertyName :array of string; var value: string);
procedure MsiSetProperty(dbhandle: MSIHANDLE; value: string);
//table functions
procedure MsiNewTable(dbhandle: MSIHANDLE; sql: string);
procedure MsiDeleteTable(dbhandle: MSIHANDLE; tablename: string);
procedure MsiCopyTable(dbhandle1: MSIHANDLE; dbhandle2: MSIHANDLE; tablename: string);

{rocedure MsiAddDialog(dbhandle: MSIHANDLE; Dialog: string; HCentering, VCentering,
                      Width, Height: Integer; Attributes: DWORD; Title ,Control_First,
                      Control_Default, Control_Cancel: string);      }


procedure MsiDialogList(dbhandle : MSIHANDLE; var DialogList : TStrings);
procedure MsiTableList(dbhandle : MSIHANDLE; var TableList : TStrings);

function GetParentDirectory(path : string) : string;
implementation
 uses exceptions_msi,Windows;

procedure MsiTableList(dbhandle : MSIHANDLE; var TableList : TStrings);
var
  err : integer;
  hView : MSIHANDLE;
  hRecord: MSIHANDLE;
  colcnt : integer;
  eColumnInfo : TMsiColInfo;
  pc : PChar;
  s,sret: String;
  pc2,retpc : PChar;
  s2: String;
  FieldCount,i : integer;
  f : DWORD;
begin
   S :=  'SELECT * From `Dialog`';//ParamStr(2);
  // pc := @S;
 //  S2 :=  'c:\\Devtools\\Sample.msi';//ParamStr(2);
   //pc2 := @S2;
   //handle := 0;
   hview :=0;
   hRecord := 0;
   //Setlength(sret,255);
   //MsiDBOpen('c:\Devtools\Sample.msi', MSIDBOPEN_DIRECT, handle);
//   msiCheckAll(MsiOpenDatabase(PChar(s2), MSIDBOPEN_DIRECT, handle));
   MsiCheckAll(MsiDatabaseOpenView(dbhandle,pchar(s),hView));
   MsiCheckAll(MsiViewExecute(hView,hRecord));
   MsiCheckAll(MsiViewFetch(hView,hRecord));
   FieldCount := MsiRecordGetFieldCount(hRecord);
  // ShowMessage('Field count is ' + IntToStr(FieldCount));
   //MsiCheckAll(MsiViewGetColumnInfo(hView,MSICOLINFO_NAMES,hRecord));
   for i := 1 to FieldCount do
   begin
      f:=255;                                       //  PChar(sret)
     MsiCheckAll(MsiRecordGetString(hRecord, i, retpc , f));
      TableList.Add(retpC);
   end;

 //MsiCheckAll(MsiCloseHandle(handle));
   //MsiDeleteTable( handle, 'Class');

end;


procedure MsiDialogList(dbhandle : MSIHANDLE; var DialogList : TStrings);
var
  err : integer;
  hView : MSIHANDLE;
  hRecord,handle: MSIHANDLE;
  colcnt : integer;
  eColumnInfo : TMsiColInfo;
  pc : PChar;
  s,sret: String;
  pc2,retpc : PChar;
  s2: String;
  FieldCount,i : integer;
  f : DWORD;
begin
   S :=  'SELECT * From `Dialog`';//ParamStr(2);
   pc := @S;
   S2 :=  'c:\\Devtools\\Sample.msi';//ParamStr(2);
   pc2 := @S2;
   handle := 0;
   hview :=0;
   hRecord := 0;
   //Setlength(sret,255);
   //MsiDBOpen('c:\Devtools\Sample.msi', MSIDBOPEN_DIRECT, handle);
   msiCheckAll(MsiOpenDatabase(PChar(s2), MSIDBOPEN_DIRECT, handle));
   MsiCheckAll(MsiDatabaseOpenView(handle,pchar(s),hView));
   MsiCheckAll(MsiViewExecute(hView,hRecord));
   MsiCheckAll(MsiViewFetch(hView,hRecord));
   FieldCount := MsiRecordGetFieldCount(hRecord);
  // ShowMessage('Field count is ' + IntToStr(FieldCount));
   //MsiCheckAll(MsiViewGetColumnInfo(hView,MSICOLINFO_NAMES,hRecord));
   for i := 1 to FieldCount do
   begin
      f:=255;                                       //  PChar(sret)
     MsiCheckAll(MsiRecordGetString(hRecord, i, retpc , f));
     DialogList.Add(retpC);
   end;

 MsiCheckAll(MsiCloseHandle(handle));
   //MsiDeleteTable( handle, 'Class');

end;

procedure MsiDBMerge(dbhandle1: MSIHANDLE; dbhandle2: MSIHANDLE);
begin
   MsiDBCheck(MsiDatabaseMerge(dbhandle1,dbhandle2 , '_MergeErrors'));
   MsiDBCheck(MsiDatabaseCommit(dbhandle1));
end;

//Copies one table from one database to other
procedure MsiCopyTable(dbhandle1: MSIHANDLE; dbhandle2: MSIHANDLE; tablename: string);
var
 ColRecordhandle,
 recordhandle1,
 recordhandle2,
 viewhandle1,
 viewhandle2: MSIHANDLE;
 column,
 value: string;
 ColumnCount,
 i,size: integer;
begin
  msiCheckAll(MsiDatabaseOpenView(dbhandle1, PCHAR('SELECT * FROM ' + tablename), viewhandle1));
  msiCheckAll(MsiDatabaseOpenView(dbhandle2,
              PCHAR('UPDATE ' + tablename + 'SET ' + column + ' = ' + value), viewhandle2));
  msiCheckAll(MsiViewExecute(viewhandle1, 0));
  msiCheckAll(MsiViewGetColumnInfo(viewhandle1, MSICOLINFO_NAMES, ColRecordhandle));
  ColumnCount := MsiRecordGetFieldCount(ColRecordhandle);
  for  i := 1 to ColumnCount do
  begin
    //msiCheckAll( MsiRecordGetString(ColRecordhandle, ColumnCount, '', size));
    inc(size);
    setlength(column, size);
  //  msiCheckAll(MsiRecordGetString(ColRecordhandle, FIELDNO, PChar(column), size ));
  end;
  msiCheckAll(MsiViewFetch(viewhandle1, recordhandle1));
  //MsiRecordGetString(recordhandle1, 1, '', size));
  inc(size);
  setlength(value, size);
  //msiCheckAll(MsiRecordGetString(recordhandle1, FIELDNO, PChar(value), size ));
  MsiViewExecute(viewhandle2, 0);
end;
 
 //adds a dialog with the specefied properties.
{ocedure MsiAddDialog(dbhandle: MSIHANDLE; Dialog: string; HCentering, VCentering,
                      Width, Height: Integer; Attributes: DWORD; Title ,Control_First,
                      Control_Default, Control_Cancel: string);
begin
// am not sure if '''' necessary
 msiCheckAll( MsiDatabaseOpenView(dbhandle,
            'INSERT INTO Dialog VALUES (''''+Dialog+'''', HCentering, VCentering, Width, Height,Attributes, ''''+Title,''''+Control_First+'''',''''+Control_Default+'''',''''+Control_Cancel+'''')',
             viewhandle));
 msiCheckAll( MsiViewExecute(viewhandle, 0));

end;      }



//Opens Database specified by path
procedure MsiDBOpen( path: string; mode: PCHAR;var handle: MSIHANDLE );
begin
   msiCheckAll( MsiOpenDatabase(PChar(path), MSIDBOPEN_DIRECT, handle));
 //ERRORCODE := MsiOpenDatabase('D:\Msi\testdb.msi', MSIDBOPEN_DIRECT, handle);
end;


//Commits Database
procedure MsiDBCommit(dbhandle: MSIHANDLE);
begin
  msiCheckAll(MsiDatabaseCommit(dbhandle));
end;

//gets 'property'; returns property in variable 'value'
procedure MsiGetProperty(dbhandle: MSIHANDLE; Tablename:String;PropertyName :array of string; var value: string);
var
  size: DWORD;
  I   : Integer;
  sql : String;
 recordhandle,
 recordhandle2,
 viewhandle,
 viewhandle2: MSIHANDLE;
begin
 { here build the sql string}
 sql := 'SELECT ';
 for I := 0 to High(PropertyName) do
 begin
   sql := sql +','+PropertyName[I];
 end;
 sql := Sql + ' from ' + Tablename;
 msiCheckAll(MsiDatabaseOpenView(dbhandle,PChar(sql),viewhandle));
// ERRORCODE:=MsiDatabaseOpenView(dbhandle,'SELECT Property, Value from Property',viewhandle);
 msiCheckAll(MsiViewExecute(viewhandle, 0));
 msiCheckAll(MsiViewFetch(viewhandle, recordhandle));
 msiCheckAll(MsiRecordGetString(recordhandle, 1,'',size));
 inc(size);
 setlength(value,size);
 //msiCheckAll(MsiRecordGetString(recordhandle, FIELDNO, PChar(value),size));
end;



//sets property to value in variable 'value'
procedure MsiSetProperty(dbhandle: MSIHANDLE; value: string);
var size: DWORD;
recordhandle,
 recordhandle2,
 viewhandle,
 viewhandle2: MSIHANDLE;
begin
  msiCheckAll(MsiDatabaseOpenView(dbhandle,'SELECT Property, Value from Property',viewhandle));
  msiCheckAll(MsiViewExecute(viewhandle, 0));
  msiCheckAll(MsiViewFetch(viewhandle, recordhandle));
  msiCheckAll(MsiRecordSetString(recordhandle, 1, PCHAR(value)));
end;


//creates a new table by name 'name' (using sql passed to function)
procedure MsiNewTable(dbhandle: MSIHANDLE; sql: string);
var
  recordhandle,
 recordhandle2,
 viewhandle,
 viewhandle2: MSIHANDLE;
begin
{Here we can either require the SQL to be passed, or do the following. If the following is to be done,
 then we would have to make provision for a number of things like PRIMARY KEY, NOT NULL etc. Requiring
 the SQL to be passed seems easier, and gives more freedom to the person...}
 // ERRORCODE:=MsiDatabaseOpenView(dbhandle,'CREATE TABLE '+tablename +'('+ ...
 msiCheckAll(MsiDatabaseOpenView(dbhandle, PCHAR(sql), viewhandle));
 msiCheckAll(MsiViewExecute(viewhandle, 0));
end;


//deletes a table from the database
procedure MsiDeleteTable(dbhandle: MSIHANDLE; tablename: string);
var
 recordhandle,
 recordhandle2,
 viewhandle,
 viewhandle2: MSIHANDLE;
begin
  msiCheckAll(MsiDatabaseOpenView(dbhandle, PCHAR('DROP TABLE '+ '`' +tablename+ '`'), viewhandle));
  msiCheckAll(MsiViewExecute(viewhandle, recordhandle));
  MsiCheckAll(MsiCloseHandle(viewhandle));
  MsiCheckAll(MsiDatabaseCommit(dbhandle));
end;

//returns the parent directory for the
//provided "path" (file or directory)
function GetParentDirectory(path : string) : string;
begin
  result := ExpandFileName(path + '\..')
end;



end.
