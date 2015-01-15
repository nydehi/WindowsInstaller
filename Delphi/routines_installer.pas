unit routines_installer;
(*----------------------------------------------------------------------------
 *  this program is confidential and proprietary to Mele Systems, LLC and
 *  MAY NOT BE REPRODUCED, PUBLISHED OR DISCLOSED TO OTHERS
 *  WITHOUT COMPANY AUTHORIZATION.
 *  Copyright: (c)1999 by  MELE Systems, LLC
 *      ALL RIGHTS RESERVED
 *----------------------------------------------------------------------------*)

interface
  uses Classes;
  
type

   TMsiFieldType = (mftChar,mftLongChar,mftShort,mftInteger,mftLong,mftBinary);

   TMsiField = Class(TObject)
   private

   public
      ColumnName   : String;
      Localizeable : boolean;
      Nullable     : boolean;
      FieldType    : TMsiFieldType;
      Size         : integer;

   end;

  TmsiTable = class(TComponent)
  private
    FMsiFields : array of TMsiField;
    FTableName: string;
    function GetMsiField(Index: Integer): TMsiField;
    procedure SetMsiField(Index: Integer; const Value: TMsiField);
    function GetCreateSQL: String;


  public
    property Fields[Index: Integer]: TMsiField read GetMsiField write SetMsiField;
    property CreateSQL : String read GetCreateSQL;
    property TableName : string read FTableName;

    constructor Create (AOwner: TComponent);override;


  end;

  TmsiDataBase = class(TComponent)
  private
    FDatabasePath: string;
    FMsiTables : array of TMsiTable;
    procedure SetDatabasePath(const Value: string);
    function GetMsiTable(Index: Integer): TMsiTable;
    procedure SetMsiTable(Index: Integer; const Value: TMsiTable);




  public
    property DatabasePath : string read FDatabasePath write SetDatabasePath;
    property Tables[Index: Integer]: TMsiTable read GetMsiTable write SetMsiTable;

    constructor Create (AOwner: TComponent);override;
  end;

function GetMsiField(RawFieldType : string;ColumnName  : String):TMsiField;
function GetCreateSQL(FieldArray : array of TMsiField) : string;

implementation
uses   Msi,MsiDefs,msiquery,
          WindowsInstaller_TLB,
          ActiveX,comobj,
          {Custom Delphi Code}
          routines_windowsinstaller,
          routines_msi, exceptions_msi,
          sysutils;


function GetCreateSQL(FieldArray : array of TMsiField) : string;
var
  SQL : string;
begin
  //SQL := 'CREATE TABLE ' + '`'+ FieldArray[0].ColumnName + '`';
  

end;

function GetMsiField(RawFieldType : string;ColumnName  : String):TMsiField;
var
  Field : TMsiField;
  x : integer;
  i : string;
begin
  Field := TMsiField.Create;
  Field.ColumnName := ColumnName;
  i := '';
  if ('v0' = RawFieldType) then
  begin
     Field.FieldType := mftBinary;
     Field.Localizeable  := False;
     Field.Nullable := True;
  end
  else if (RawFieldType[1] = 's') then
  begin
       Field.FieldType := mftChar;
       Field.Localizeable  := False;
       Field.Nullable := True;
       for X:= 2 to Length(RawFieldType) do
       begin
          i := i + RawFieldType[x];
       end;
       Field.Size := StrToInt(i);
       if (Field.Size = 0) then
          Field.FieldType := mftLongChar;
  end
  else if (RawFieldType[1] = 'l') then
  begin
       Field.FieldType := mftChar;
       Field.Localizeable  := True;
       Field.Nullable := True;
       for X:= 2 to Length(RawFieldType) do
       begin
          i := i + RawFieldType[x];
       end;
       Field.Size := StrToInt(i);
       if (Field.Size = 0) then
          Field.FieldType := mftLongChar;
  end
  else if (RawFieldType[1] = 'i') then
  begin
       Field.Localizeable  := False;
       Field.Nullable := True;
       for X:= 2 to Length(RawFieldType) do
       begin
          i := i + RawFieldType[x];
       end;
       Field.Size := StrToInt(i);
       if (Field.Size = 2) then
          Field.FieldType := mftInteger;
       if (Field.Size = 4) then
          Field.FieldType := mftLong;
  end;
  Result := Field;
end;


{ TmsiTable }

constructor TmsiTable.Create(AOwner: TComponent);
begin
  inherited;

end;

function TmsiTable.GetCreateSQL: String;
begin

end;

function TmsiTable.GetMsiField(Index: Integer): TMsiField;
begin
   result :=  FMsiFields[Index];
end;

procedure TmsiTable.SetMsiField(Index: Integer; const Value: TMsiField);
begin
   FMsiFields[Index] :=  Value;
end;

{ TmsiDataBase }

constructor TmsiDataBase.Create(AOwner: TComponent);
begin
  inherited;

end;

function TmsiDataBase.GetMsiTable(Index: Integer): TMsiTable;
begin

end;

procedure TmsiDataBase.SetDatabasePath(const Value: string);
var
  astringList : TStrings;
  colInfoList : TStrings;
  ColNameList : TStrings;
  sTableName : String;
  sQuery     : String;
  wi         : WindowsInstaller_TLB.Installer  ;
  db         : WindowsInstaller_TLB.Database;
  view       : WindowsInstaller_TLB.View;
  rc         : WindowsInstaller_TLB.Record_;
  col_rc_names     : WindowsInstaller_TLB.Record_;
  col_rc_types     : WindowsInstaller_TLB.Record_;
  colcnt,i,Current_Row   : integer;
  s:string;
  FieldArray : array of TMsiField;
  aLength    : integer;
begin
//  FDatabasePath := Value;
//   {$IFDEF  YD_USE_WI_API}
//    astringList := TSTringList.Create();
//    try
//      sTableName := 'Dialog';  //default  Value
//
//
//      wi := CreateOleObject('WindowsInstaller.Installer') as WindowsInstaller_TLB.Installer;
//      db := wi.OpenDatabase(FDatabasePath,msiOpenDatabaseModeReadOnly);
//
//      sQuery:= 'SELECT * From `'+sTableName+'`';
//      view := db.OpenView(sQuery);//) ;
//      view.Execute(rc);
//
//      rc :=  view.Fetch;
//      //Fetch column names
//      col_rc_names := view.ColumnInfo[0];
//      colcnt := col_rc_names.FieldCount;
//
//      {GRab the colmn name. 'Field Names"}
//      sgTable.ColCount := colcnt;
//      for i := 1 to colcnt do
//      begin
//        Column_Names_Length := Length(Column_Names);
//        inc(Column_Names_Length);
//        SetLength(Column_Names,Column_Names_Length);
//        s := col_rc_names.StringData[i];
//        sgTable.Cells[i-1,0]:=s;
//        Column_Names[i-1] := s;
//      end;
//
//      //Fetch column Types
//      col_rc_types := view.ColumnInfo[1];
//      colcnt := col_rc_types.FieldCount;
//
//      SetLength(Column_Types,colcnt);
//      for i := 1 to colcnt do
//      begin
//        s := col_rc_types.StringData[i];
//        Column_Types[i-1] := s;
//      end;
//
//      Current_Row :=1;
//      sgTable.RowCount := Current_Row;
//
//      { Loop tru the individual fields and if
//      it is binary write out text  '[Binary Data]'}
//      While (not (rc = nil)) do
//      begin
//        colcnt := rc.FieldCount;
//     {  aLength := Length(FieldArray);
//        inc(aLength);
//        SetLength(FieldArray,aLength);
//        FieldArray[aLength-1] := GetMsiField(Column_Types[i-1],sgTable.Cells[i,0]);
//        FieldArray[aLength-1].ColumnName := sTableName; */}
//        for i := 1 to  colcnt do
//        begin    {break this out to a GetWIType function and define an enum}
//         // aLength := Length(FieldArray);
//         // inc(aLength);
//         // SetLength(FieldArray,aLength);
//         // FieldArray[aLength-1] :=  GetMsiField(Column_Types[i-1],sgTable.Cells[i-1,0]);
//          if ('v0' = Column_Types[i-1]) then
//          begin
//            sgTable.Cells[i-1,Current_Row]:= '[Binary Data]';
//          end
//          else
//          begin
//          s := rc.StringData[i];
//            //if (i > 0) then
//           // begin
//
//              sgTable.Cells[i-1,Current_Row]:= s;
//          //  end;
//          end;
//         
//        end;
//        inc(Current_Row);
//        sgTable.RowCount := sgTable.RowCount+1;
//        rc :=  view.Fetch;
//        
//      end;
//      
//      {Create the field array here}
//
//
//      {CreateSQL is now generated for this table. It is also added to the list}
//      CreateSQL.Values[sTableName] :=  GetCreateSQL(FieldArray);
//
//      if (sgTable.RowCount > 1) then
//        sgTable.FixedRows := 1;
//
//    finally
//      db := nil;
//      wi := nil;
//      astringList.Free;
//    end;
//    {$ENDIF}
end;

procedure TmsiDataBase.SetMsiTable(Index: Integer; const Value: TMsiTable);
begin

end;

end.
