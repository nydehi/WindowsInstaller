unit MsiQuery;
 (*----------------------------------------------------------------------------
 *  this program is confidential and proprietary to Mele Systems, LLC and
 *  MAY NOT BE REPRODUCED, PUBLISHED OR DISCLOSED TO OTHERS
 *  WITHOUT COMPANY AUTHORIZATION.
 *  Copyright: (c)1999 by  MELE Systems, LLC
 *      ALL RIGHTS RESERVED
 *----------------------------------------------------------------------------*)

{$WEAKPACKAGEUNIT}

interface

{$HPPEMIT ''}
{$HPPEMIT '#include "msiquery.h"'}
{$HPPEMIT ''}

uses
  Windows, Msi;

// NOTES:  All buffers sizes are TCHAR count, null included only on input
//         Return argument pointers may be null if not interested in value
//         Returned handles of all types must be closed: MsiCloseHandle(h)
//         Functions with UINT return type return a system error code
//         Designated functions will set or clear the last error record,
//         which is then accessible with MsiGetLastErrorRecord. However,
//         the following argument errors do not register an error record:
//         ERROR_INVALID_HANDLE, ERROR_INVALID_PARAMETER, ERROR_MORE_DATA.

const
  MSI_NULL_INTEGER = $80000000;         // integer value reserved for null
  {$EXTERNALSYM MSI_NULL_INTEGER}

// MsiOpenDatabase persist predefine values, otherwise output database path is used

  MSIDBOPEN_READONLY     = LPCTSTR(0);  // database open read-only, no persistent changes
  {$EXTERNALSYM MSIDBOPEN_READONLY}
  MSIDBOPEN_TRANSACT     = LPCTSTR(1);  // database read/write in transaction mode
  {$EXTERNALSYM MSIDBOPEN_TRANSACT}
  MSIDBOPEN_DIRECT       = LPCTSTR(2);  // database direct read/write without transaction
  {$EXTERNALSYM MSIDBOPEN_DIRECT}
  MSIDBOPEN_CREATE       = LPCTSTR(3);  // create new database, transact mode read/write
  {$EXTERNALSYM MSIDBOPEN_CREATE}
  MSIDBOPEN_CREATEDIRECT = LPCTSTR(4);  // create new database, direct mode read/write
  {$EXTERNALSYM MSIDBOPEN_CREATEDIRECT}
  MSIDBOPEN_PATCHFILE    = 32 div SizeOf(MSIDBOPEN_READONLY); // add flag to indicate patch file
  {$EXTERNALSYM MSIDBOPEN_PATCHFILE}

	MSIDBSTATE_ERROR = -1;  // invalid database Handle
  {$EXTERNALSYM MSIDBSTATE_ERROR}
	MSIDBSTATE_READ  = 0;  // database open read-only, no persistent changes
  {$EXTERNALSYM MSIDBSTATE_READ}
	MSIDBSTATE_WRITE = 1;  // database readable and updatable
  {$EXTERNALSYM MSIDBSTATE_WRITE}

type
  TMsiDbState = MSIDBSTATE_ERROR..MSIDBSTATE_WRITE;

const
	MSIMODIFY_SEEK             = -1; // reposition to current record primary key
  {$EXTERNALSYM MSIMODIFY_SEEK}
	MSIMODIFY_REFRESH          = 0;  // refetch current record data
  {$EXTERNALSYM MSIMODIFY_REFRESH}
	MSIMODIFY_INSERT           = 1;  // insert new record, fails if matching key exists
  {$EXTERNALSYM MSIMODIFY_INSERT}
	MSIMODIFY_UPDATE           = 2;  // update existing non-key data of fetched record
  {$EXTERNALSYM MSIMODIFY_UPDATE}
	MSIMODIFY_ASSIGN           = 3;  // insert record, replacing any existing record
  {$EXTERNALSYM MSIMODIFY_ASSIGN}
	MSIMODIFY_REPLACE          = 4;  // update record, delete old if primary key Exit
  {$EXTERNALSYM MSIMODIFY_REPLACE}
	MSIMODIFY_MERGE            = 5;  // fails if record with duplicate key not identical
  {$EXTERNALSYM MSIMODIFY_MERGE}
	MSIMODIFY_DELETE           = 6;  // remove row referenced by this record from TTable
  {$EXTERNALSYM MSIMODIFY_DELETE}
	MSIMODIFY_INSERT_TEMPORARY = 7;  // insert a temporary record
  {$EXTERNALSYM MSIMODIFY_INSERT_TEMPORARY}
	MSIMODIFY_VALIDATE         = 8;  // validate a fetched record
  {$EXTERNALSYM MSIMODIFY_VALIDATE}
	MSIMODIFY_VALIDATE_NEW     = 9;  // validate a new record
  {$EXTERNALSYM MSIMODIFY_VALIDATE_NEW}
	MSIMODIFY_VALIDATE_FIELD   = 10; // validate field(s) of an incomplete record
  {$EXTERNALSYM MSIMODIFY_VALIDATE_FIELD}
	MSIMODIFY_VALIDATE_DELETE  = 11; // validate before deleting record
  {$EXTERNALSYM MSIMODIFY_VALIDATE_DELETE}

type
  TMsiModify = MSIMODIFY_SEEK..MSIMODIFY_VALIDATE_DELETE;

const
	MSICOLINFO_NAMES = 0;  // return column Name
  {$EXTERNALSYM MSICOLINFO_NAMES}
	MSICOLINFO_TYPES = 1;  // return column definitions, datatype code followed by Width
  {$EXTERNALSYM MSICOLINFO_TYPES}

type
  TMsiColInfo = MSICOLINFO_NAMES..MSICOLINFO_TYPES;

const
	MSICONDITION_FALSE = 0;  // expression evaluates to False
  {$EXTERNALSYM MSICONDITION_FALSE}
	MSICONDITION_TRUE  = 1;  // expression evaluates to True
  {$EXTERNALSYM MSICONDITION_TRUE}
	MSICONDITION_NONE  = 2;  // no expression present
  {$EXTERNALSYM MSICONDITION_NONE}
	MSICONDITION_ERROR = 3;  // syntax error in expression
  {$EXTERNALSYM MSICONDITION_ERROR}

type
  TMsiCondition = MSICONDITION_FALSE..MSICONDITION_ERROR;

const
	MSICOSTTREE_SELFONLY = 0;
  {$EXTERNALSYM MSICOSTTREE_SELFONLY}
	MSICOSTTREE_CHILDREN = 1;
  {$EXTERNALSYM MSICOSTTREE_CHILDREN}
	MSICOSTTREE_PARENTS  = 2;
  {$EXTERNALSYM MSICOSTTREE_PARENTS}
	MSICOSTTREE_RESERVED = 3;	// Reserved for future use
  {$EXTERNALSYM MSICOSTTREE_RESERVED}

type
  TMsiCostTree = MSICOSTTREE_SELFONLY..MSICOSTTREE_RESERVED;

const
	MSIDBERROR_INVALIDARG        = -3; //  invalid argument
  {$EXTERNALSYM MSIDBERROR_INVALIDARG}
	MSIDBERROR_MOREDATA          = -2; //  buffer too small
  {$EXTERNALSYM MSIDBERROR_MOREDATA}
	MSIDBERROR_FUNCTIONERROR     = -1; //  function error
  {$EXTERNALSYM MSIDBERROR_FUNCTIONERROR}
	MSIDBERROR_NOERROR           = 0;  //  no error
  {$EXTERNALSYM MSIDBERROR_NOERROR}
	MSIDBERROR_DUPLICATEKEY      = 1;  //  new record duplicates primary keys of existing record in TTable
  {$EXTERNALSYM MSIDBERROR_DUPLICATEKEY}
	MSIDBERROR_REQUIRED          = 2;  //  non-nullable column, no null values allowed
  {$EXTERNALSYM MSIDBERROR_REQUIRED}
	MSIDBERROR_BADLINK           = 3;  //  corresponding record in foreign table not found
  {$EXTERNALSYM MSIDBERROR_BADLINK}
	MSIDBERROR_OVERFLOW          = 4;  //  data greater than maximum value allowed
  {$EXTERNALSYM MSIDBERROR_OVERFLOW}
	MSIDBERROR_UNDERFLOW         = 5;  //  data less than minimum value allowed
  {$EXTERNALSYM MSIDBERROR_UNDERFLOW}
	MSIDBERROR_NOTINSET          = 6;  //  data not a member of the values permitted in the set
  {$EXTERNALSYM MSIDBERROR_NOTINSET}
	MSIDBERROR_BADVERSION        = 7;  //  invalid version string
  {$EXTERNALSYM MSIDBERROR_BADVERSION}
	MSIDBERROR_BADCASE           = 8;  //  invalid case, must be all upper-case or all lower-case
  {$EXTERNALSYM MSIDBERROR_BADCASE}
	MSIDBERROR_BADGUID           = 9;  //  invalid GUID
  {$EXTERNALSYM MSIDBERROR_BADGUID}
	MSIDBERROR_BADWILDCARD       = 10; //  invalid wildcardfilename or use of wildcards
  {$EXTERNALSYM MSIDBERROR_BADWILDCARD}
	MSIDBERROR_BADIDENTIFIER     = 11; //  bad identifier
  {$EXTERNALSYM MSIDBERROR_BADIDENTIFIER}
	MSIDBERROR_BADLANGUAGE       = 12; //  bad language Id(s)
  {$EXTERNALSYM MSIDBERROR_BADLANGUAGE}
	MSIDBERROR_BADFILENAME       = 13; //  bad FileName
  {$EXTERNALSYM MSIDBERROR_BADFILENAME}
	MSIDBERROR_BADPATH           = 14; //  bad path
  {$EXTERNALSYM MSIDBERROR_BADPATH}
	MSIDBERROR_BADCONDITION      = 15; //  bad conditional statement
  {$EXTERNALSYM MSIDBERROR_BADCONDITION}
	MSIDBERROR_BADFORMATTED      = 16; //  bad format string
  {$EXTERNALSYM MSIDBERROR_BADFORMATTED}
	MSIDBERROR_BADTEMPLATE       = 17; //  bad template string
  {$EXTERNALSYM MSIDBERROR_BADTEMPLATE}
	MSIDBERROR_BADDEFAULTDIR     = 18; //  bad string in DefaultDir column of Directory TTable
  {$EXTERNALSYM MSIDBERROR_BADDEFAULTDIR}
	MSIDBERROR_BADREGPATH        = 19; //  bad registry path string
  {$EXTERNALSYM MSIDBERROR_BADREGPATH}
	MSIDBERROR_BADCUSTOMSOURCE   = 20; //  bad string in CustomSource column of CustomAction TTable
  {$EXTERNALSYM MSIDBERROR_BADCUSTOMSOURCE}
	MSIDBERROR_BADPROPERTY       = 21; //  bad property string
  {$EXTERNALSYM MSIDBERROR_BADPROPERTY}
	MSIDBERROR_MISSINGDATA       = 22; //  _Validation table missing reference to column
  {$EXTERNALSYM MSIDBERROR_MISSINGDATA}
	MSIDBERROR_BADCATEGORY       = 23; //  Category column of _Validation table for column is invalid
  {$EXTERNALSYM MSIDBERROR_BADCATEGORY}
	MSIDBERROR_BADKEYTABLE       = 24; //  table in KeyTable column of _Validation table could not be found/Loaded
  {$EXTERNALSYM MSIDBERROR_BADKEYTABLE}
	MSIDBERROR_BADMAXMINVALUES   = 25; //  value in MaxValue column of _Validation table is less than value in MinValue column
  {$EXTERNALSYM MSIDBERROR_BADMAXMINVALUES}
	MSIDBERROR_BADCABINET        = 26; //  bad cabinet Name
  {$EXTERNALSYM MSIDBERROR_BADCABINET}
	MSIDBERROR_BADSHORTCUT       = 27; //  bad shortcut target
  {$EXTERNALSYM MSIDBERROR_BADSHORTCUT}
	MSIDBERROR_STRINGOVERFLOW    = 28; //  string overflow (greater than length allowed in column def)
  {$EXTERNALSYM MSIDBERROR_STRINGOVERFLOW}
	MSIDBERROR_BADLOCALIZEATTRIB = 29; //  invalid localization attribute (primary keys cannot be localized)
  {$EXTERNALSYM MSIDBERROR_BADLOCALIZEATTRIB}

type
  TMsiDbError = MSIDBERROR_INVALIDARG..MSIDBERROR_BADLOCALIZEATTRIB;

const
	MSIRUNMODE_ADMIN            =  0; // admin mode install, else product install
  {$EXTERNALSYM MSIRUNMODE_ADMIN}
	MSIRUNMODE_ADVERTISE        =  1; // installing advertisements, else installing or updating product
  {$EXTERNALSYM MSIRUNMODE_ADVERTISE}
	MSIRUNMODE_MAINTENANCE      =  2; // modifying an existing installation, else new installation
  {$EXTERNALSYM MSIRUNMODE_MAINTENANCE}
	MSIRUNMODE_ROLLBACKENABLED  =  3; // rollback is Enabled
  {$EXTERNALSYM MSIRUNMODE_ROLLBACKENABLED}
	MSIRUNMODE_LOGENABLED       =  4; // log file active, enabled prior to install session
  {$EXTERNALSYM MSIRUNMODE_LOGENABLED}
	MSIRUNMODE_OPERATIONS       =  5; // spooling execute operations, else in determination phase
  {$EXTERNALSYM MSIRUNMODE_OPERATIONS}
	MSIRUNMODE_REBOOTATEND      =  6; // reboot needed after successful installation (settable)
  {$EXTERNALSYM MSIRUNMODE_REBOOTATEND}
	MSIRUNMODE_REBOOTNOW        =  7; // reboot needed to continue installation (settable)
  {$EXTERNALSYM MSIRUNMODE_REBOOTNOW}
	MSIRUNMODE_CABINET          =  8; // installing files from cabinets and files using Media TTable
  {$EXTERNALSYM MSIRUNMODE_CABINET}
	MSIRUNMODE_SOURCESHORTNAMES =  9; // source LongFileNames suppressed via PID_MSISOURCE summary property
  {$EXTERNALSYM MSIRUNMODE_SOURCESHORTNAMES}
	MSIRUNMODE_TARGETSHORTNAMES = 10; // target LongFileNames suppressed via SHORTFILENAMES property
  {$EXTERNALSYM MSIRUNMODE_TARGETSHORTNAMES}
	MSIRUNMODE_RESERVED11       = 11; // future use
  {$EXTERNALSYM MSIRUNMODE_RESERVED11}
	MSIRUNMODE_WINDOWS9X        = 12; // operating systems is Windows9?, else Windows NT
  {$EXTERNALSYM MSIRUNMODE_WINDOWS9X}
	MSIRUNMODE_ZAWENABLED       = 13; // operating system supports demand installation
  {$EXTERNALSYM MSIRUNMODE_ZAWENABLED}
	MSIRUNMODE_RESERVED14       = 14; // future use
  {$EXTERNALSYM MSIRUNMODE_RESERVED14}
	MSIRUNMODE_RESERVED15       = 15; // future use
  {$EXTERNALSYM MSIRUNMODE_RESERVED15}
	MSIRUNMODE_SCHEDULED        = 16; // custom action call from install script execution
  {$EXTERNALSYM MSIRUNMODE_SCHEDULED}
	MSIRUNMODE_ROLLBACK         = 17; // custom action call from rollback execution script
  {$EXTERNALSYM MSIRUNMODE_ROLLBACK}
	MSIRUNMODE_COMMIT           = 18; // custom action call from commit execution script
  {$EXTERNALSYM MSIRUNMODE_COMMIT}

type
  TMsiRunMode = MSIRUNMODE_ADMIN..MSIRUNMODE_COMMIT;

const
  INSTALLMESSAGE_TYPEMASK = DWORD($FF000000);  // mask for type code
  {$EXTERNALSYM INSTALLMESSAGE_TYPEMASK}

// Note: INSTALLMESSAGE_ERROR, INSTALLMESSAGE_WARNING, INSTALLMESSAGE_USER are to or'd
// with a message box style to indicate the buttons to display and return:
// MB_OK,MB_OKCANCEL,MB_ABORTRETRYIGNORE,MB_YESNOCANCEL,MB_YESNO,MB_RETRYCANCEL
// the default button (MB_DEFBUTTON1 is normal default):
// MB_DEFBUTTON1, MB_DEFBUTTON2, MB_DEFBUTTON3
// and optionally an icon style:
// MB_ICONERROR, MB_ICONQUESTION, MB_ICONWARNING, MB_ICONINFORMATION

	MSITRANSFORM_ERROR_ADDEXISTINGROW   = $00000001;
  {$EXTERNALSYM MSITRANSFORM_ERROR_ADDEXISTINGROW}
	MSITRANSFORM_ERROR_DELMISSINGROW    = $00000002;
  {$EXTERNALSYM MSITRANSFORM_ERROR_DELMISSINGROW}
	MSITRANSFORM_ERROR_ADDEXISTINGTABLE = $00000004;
  {$EXTERNALSYM MSITRANSFORM_ERROR_ADDEXISTINGTABLE}
	MSITRANSFORM_ERROR_DELMISSINGTABLE  = $00000008;
  {$EXTERNALSYM MSITRANSFORM_ERROR_DELMISSINGTABLE}
	MSITRANSFORM_ERROR_UPDATEMISSINGROW = $00000010;
  {$EXTERNALSYM MSITRANSFORM_ERROR_UPDATEMISSINGROW}
	MSITRANSFORM_ERROR_CHANGECODEPAGE   = $00000020;
  {$EXTERNALSYM MSITRANSFORM_ERROR_CHANGECODEPAGE}
	MSITRANSFORM_ERROR_VIEWTRANSFORM    = $00000100;
  {$EXTERNALSYM MSITRANSFORM_ERROR_VIEWTRANSFORM}

type
  TMsiTransformError = MSITRANSFORM_ERROR_ADDEXISTINGROW..MSITRANSFORM_ERROR_VIEWTRANSFORM;

const
	MSITRANSFORM_VALIDATE_LANGUAGE                   = $00000001;
  {$EXTERNALSYM MSITRANSFORM_VALIDATE_LANGUAGE}
	MSITRANSFORM_VALIDATE_PRODUCT                    = $00000002;
  {$EXTERNALSYM MSITRANSFORM_VALIDATE_PRODUCT}
	MSITRANSFORM_VALIDATE_PLATFORM                   = $00000004;
  {$EXTERNALSYM MSITRANSFORM_VALIDATE_PLATFORM}
	MSITRANSFORM_VALIDATE_MAJORVERSION               = $00000008;
  {$EXTERNALSYM MSITRANSFORM_VALIDATE_MAJORVERSION}
	MSITRANSFORM_VALIDATE_MINORVERSION               = $00000010;
  {$EXTERNALSYM MSITRANSFORM_VALIDATE_MINORVERSION}
	MSITRANSFORM_VALIDATE_UPDATEVERSION              = $00000020;
  {$EXTERNALSYM MSITRANSFORM_VALIDATE_UPDATEVERSION}
	MSITRANSFORM_VALIDATE_NEWLESSBASEVERSION         = $00000040;
  {$EXTERNALSYM MSITRANSFORM_VALIDATE_NEWLESSBASEVERSION}
	MSITRANSFORM_VALIDATE_NEWLESSEQUALBASEVERSION    = $00000080;
  {$EXTERNALSYM MSITRANSFORM_VALIDATE_NEWLESSEQUALBASEVERSION}
	MSITRANSFORM_VALIDATE_NEWEQUALBASEVERSION        = $00000100;
  {$EXTERNALSYM MSITRANSFORM_VALIDATE_NEWEQUALBASEVERSION}
	MSITRANSFORM_VALIDATE_NEWGREATEREQUALBASEVERSION = $00000200;
  {$EXTERNALSYM MSITRANSFORM_VALIDATE_NEWGREATEREQUALBASEVERSION}
	MSITRANSFORM_VALIDATE_NEWGREATERBASEVERSION      = $00000400;
  {$EXTERNALSYM MSITRANSFORM_VALIDATE_NEWGREATERBASEVERSION}
	MSITRANSFORM_VALIDATE_UPGRADECODE                = $00000800;
  {$EXTERNALSYM MSITRANSFORM_VALIDATE_UPGRADECODE}

type
  TMsiTransformValidate = MSITRANSFORM_VALIDATE_LANGUAGE..MSITRANSFORM_VALIDATE_UPGRADECODE;

// --------------------------------------------------------------------------
// Installer database access functions
// --------------------------------------------------------------------------

// Prepare a database query, creating a view object
// Returns ERROR_SUCCESS if successful, and the view handle is returned,
// else ERROR_INVALID_HANDLE, ERROR_INVALID_HANDLE_STATE, ERROR_BAD_QUERY_SYNTAX, ERROR_GEN_FAILURE
// Execution of this function sets the error record, accessible via MsiGetLastErrorRecord

function MsiDatabaseOpenViewA(hDatabase: MSIHANDLE;	szQuery: PAnsiChar;
  var phView: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiDatabaseOpenViewA}
function MsiDatabaseOpenViewW(hDatabase: MSIHANDLE;	szQuery: PWideChar;
  var phView: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiDatabaseOpenViewW}
function MsiDatabaseOpenView(hDatabase: MSIHANDLE;	szQuery: PChar;
  var phView: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiDatabaseOpenView}

// Returns the MSIDBERROR enum and name of the column corresponding to the error
// Similar to a GetLastError function, but for the view. NOT the same as MsiGetLastErrorRecord
// Returns errors of MsiViewModify.

function MsiViewGetErrorA(hView: MSIHANDLE; szColumnNameBuffer: PAnsiChar;
  var pcchBuf: DWORD): TMsiDbError; stdcall;
{$EXTERNALSYM MsiViewGetErrorA}
function MsiViewGetErrorW(hView: MSIHANDLE; szColumnNameBuffer: PWideChar;
  var pcchBuf: DWORD): TMsiDbError; stdcall;
{$EXTERNALSYM MsiViewGetErrorW}
function MsiViewGetError(hView: MSIHANDLE; szColumnNameBuffer: PChar;
  var pcchBuf: DWORD): TMsiDbError; stdcall;
{$EXTERNALSYM MsiViewGetError}

// Exectute the view query, supplying parameters as required
// Returns ERROR_SUCCESS, ERROR_INVALID_HANDLE, ERROR_INVALID_HANDLE_STATE, ERROR_GEN_FAILURE
// Execution of this function sets the error record, accessible via MsiGetLastErrorRecord

function MsiViewExecute(hView, hRecord: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiViewExecute}

// Fetch the next sequential record from the view
// Result is ERROR_SUCCESS if a row is found, and its handle is returned
// else ERROR_NO_DATA if no records remain, and a null handle is returned
// else result is error: ERROR_INVALID_HANDLE_STATE, ERROR_INVALID_HANDLE, ERROR_GEN_FAILURE

function MsiViewFetch(hView: MSIHANDLE;	var phRecord: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiViewFetch}

// Modify a database record, parameters must match types in query columns
// Returns ERROR_SUCCESS, ERROR_INVALID_HANDLE, ERROR_INVALID_HANDLE_STATE, ERROR_GEN_FAILURE, ERROR_ACCESS_DENIED
// Execution of this function sets the error record, accessible via MsiGetLastErrorRecord

function MsiViewModify(hView: MSIHANDLE; eModifyMode: TMsiModify;	hRecord: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiViewModify}

// Return the column names or specifications for the current view
// Returns ERROR_SUCCESS, ERROR_INVALID_HANDLE, ERROR_INVALID_PARAMETER, or ERROR_INVALID_HANDLE_STATE

function MsiViewGetColumnInfo(hView: MSIHANDLE; eColumnInfo: TMsiColInfo;
  var phRecord: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiViewGetColumnInfo}

// Release the result set for an executed view, to allow re-execution
// Only needs to be called if not all records have been fetched
// Returns ERROR_SUCCESS, ERROR_INVALID_HANDLE, ERROR_INVALID_HANDLE_STATE

function MsiViewClose(hView: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiViewClose}

// Return a record containing the names of all primary key columns for a given table
// Returns an MSIHANDLE for a record containing the name of each column.
// The field count of the record corresponds to the number of primary key columns.
// Field [0] of the record contains the table name.
// Returns ERROR_SUCCESS, ERROR_INVALID_HANDLE, ERROR_INVALID_TABLE

function MsiDatabaseGetPrimaryKeysA(hDatabase: MSIHANDLE;	szTableName: PAnsiChar;
  var phRecord: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiDatabaseGetPrimaryKeysA}
function MsiDatabaseGetPrimaryKeysW(hDatabase: MSIHANDLE;	szTableName: PWideChar;
  var phRecord: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiDatabaseGetPrimaryKeysW}
function MsiDatabaseGetPrimaryKeys(hDatabase: MSIHANDLE;	szTableName: PChar;
  var phRecord: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiDatabaseGetPrimaryKeys}

// Return an enum defining the state of the table (temporary, unknown, or persistent).
// Returns MSICONDITION_ERROR, MSICONDITION_FALSE, MSICONDITION_TRUE, MSICONDITION_NONE

function MsiDatabaseIsTablePersistentA(hDatabase: MSIHANDLE; szTableName: PAnsiChar): UINT; stdcall;
{$EXTERNALSYM MsiDatabaseIsTablePersistentA}
function MsiDatabaseIsTablePersistentW(hDatabase: MSIHANDLE; szTableName: PWideChar): UINT; stdcall;
{$EXTERNALSYM MsiDatabaseIsTablePersistentW}
function MsiDatabaseIsTablePersistent(hDatabase: MSIHANDLE; szTableName: PChar): UINT; stdcall;
{$EXTERNALSYM MsiDatabaseIsTablePersistent}

// --------------------------------------------------------------------------
// Summary information stream management functions
// --------------------------------------------------------------------------

// Integer Property IDs:    1, 14, 15, 16, 19 
// DateTime Property IDs:   10, 11, 12, 13
// Text Property IDs:       2, 3, 4, 5, 6, 7, 8, 9, 18
// Unsupported Propery IDs: 0 (PID_DICTIONARY), 17 (PID_THUMBNAIL)

// Obtain a handle for the _SummaryInformation stream for an MSI database     
// Execution of this function sets the error record, accessible via MsiGetLastErrorRecord

function MsiGetSummaryInformationA(hDatabase: MSIHANDLE; szDatabasePath: PAnsiChar;
  uiUpdateCount: UINT; var phSummaryInfo: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiGetSummaryInformationA}
function MsiGetSummaryInformationW(hDatabase: MSIHANDLE; szDatabasePath: PWideChar;
  uiUpdateCount: UINT; var phSummaryInfo: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiGetSummaryInformationW}
function MsiGetSummaryInformation(hDatabase: MSIHANDLE; szDatabasePath: PChar;
  uiUpdateCount: UINT; var phSummaryInfo: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiGetSummaryInformation}

// Obtain the number of existing properties in the SummaryInformation stream

function MsiSummaryInfoGetPropertyCount(hSummaryInfo: MSIHANDLE;
	var puiPropertyCount: UINT): UINT; stdcall;
{$EXTERNALSYM MsiSummaryInfoGetPropertyCount}

// Set a single summary information property
// Returns ERROR_SUCCESS, ERROR_INVALID_HANDLE, ERROR_UNKNOWN_PROPERTY

function MsiSummaryInfoSetPropertyA(hSummaryInfo: MSIHANDLE; uiProperty,
  uiDataType: UINT; iValue: Integer; pftValue: PFileTime; szValue: PAnsiChar): UINT; stdcall;
{$EXTERNALSYM MsiSummaryInfoSetPropertyA}
function MsiSummaryInfoSetPropertyW(hSummaryInfo: MSIHANDLE; uiProperty,
  uiDataType: UINT; iValue: Integer; pftValue: PFileTime; szValue: PWideChar): UINT; stdcall;
{$EXTERNALSYM MsiSummaryInfoSetPropertyW}
function MsiSummaryInfoSetProperty(hSummaryInfo: MSIHANDLE; uiProperty,
  uiDataType: UINT; iValue: Integer; pftValue: PFileTime; szValue: PChar): UINT; stdcall;
{$EXTERNALSYM MsiSummaryInfoSetProperty}

// Get a single property from the summary information
// Returns ERROR_SUCCESS, ERROR_INVALID_HANDLE, ERROR_UNKNOWN_PROPERTY

function MsiSummaryInfoGetPropertyA(hSummaryInfo: MSIHANDLE; uiProperty: UINT;
  puiDataType: PUINT; piValue: PInteger; pftValue: PFileTime; szValueBuf: PAnsiChar;
  pcchValueBuf: PDWORD): UINT; stdcall;
{$EXTERNALSYM MsiSummaryInfoGetPropertyA}
function MsiSummaryInfoGetPropertyW(hSummaryInfo: MSIHANDLE; uiProperty: UINT;
  puiDataType: PUINT; piValue: PInteger; pftValue: PFileTime; szValueBuf: PWideChar;
  pcchValueBuf: PDWORD): UINT; stdcall;
{$EXTERNALSYM MsiSummaryInfoGetPropertyW}
function MsiSummaryInfoGetProperty(hSummaryInfo: MSIHANDLE; uiProperty: UINT;
  puiDataType: PUINT; piValue: PInteger; pftValue: PFileTime; szValueBuf: PChar;
  pcchValueBuf: PDWORD): UINT; stdcall;
{$EXTERNALSYM MsiSummaryInfoGetProperty}

// Write back changed information to summary information stream

function MsiSummaryInfoPersist(hSummaryInfo: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiSummaryInfoPersist}

// --------------------------------------------------------------------------
// Installer database management functions - not used by custom actions
// --------------------------------------------------------------------------

// Open an installer database, specifying the persistance mode, which is a pointer.
// Predefined persist values are reserved pointer values, requiring pointer arithmetic.
// Execution of this function sets the error record, accessible via MsiGetLastErrorRecord

function MsiOpenDatabaseA(szDatabasePath, szPersist: PAnsiChar; var phDatabase: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiOpenDatabaseA}
function MsiOpenDatabaseW(szDatabasePath, szPersist: PWideChar; var phDatabase: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiOpenDatabaseW}
function MsiOpenDatabase(szDatabasePath, szPersist: PChar; var phDatabase: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiOpenDatabase}

// Import an MSI text archive table into an open database
// Execution of this function sets the error record, accessible via MsiGetLastErrorRecord

function MsiDatabaseImportA(hDatabase: MSIHANDLE; szFolderPath,
  szFileName: PAnsiChar): UINT; stdcall;
{$EXTERNALSYM MsiDatabaseImportA}
function MsiDatabaseImportW(hDatabase: MSIHANDLE; szFolderPath,
  szFileName: PWideChar): UINT; stdcall;
{$EXTERNALSYM MsiDatabaseImportW}
function MsiDatabaseImport(hDatabase: MSIHANDLE; szFolderPath,
  szFileName: PChar): UINT; stdcall;
{$EXTERNALSYM MsiDatabaseImport}

// Export an MSI table from an open database to a text archive file
// Execution of this function sets the error record, accessible via MsiGetLastErrorRecord

function MsiDatabaseExportA(hDatabase: MSIHANDLE; szTableName, szFolderPath,
  szFileName: PAnsiChar): UINT; stdcall;
{$EXTERNALSYM MsiDatabaseExportA}
function MsiDatabaseExportW(hDatabase: MSIHANDLE; szTableName, szFolderPath,
  szFileName: PWideChar): UINT; stdcall;
{$EXTERNALSYM MsiDatabaseExportW}
function MsiDatabaseExport(hDatabase: MSIHANDLE; szTableName, szFolderPath,
  szFileName: PChar): UINT; stdcall;
{$EXTERNALSYM MsiDatabaseExport}

// Merge two database together, allowing duplicate rows
// Execution of this function sets the error record, accessible via MsiGetLastErrorRecord

function MsiDatabaseMergeA(hDatabase, hDatabaseMerge: MSIHANDLE;
  szTableName: PAnsiChar): UINT; stdcall;
{$EXTERNALSYM MsiDatabaseMergeA}
function MsiDatabaseMergeW(hDatabase, hDatabaseMerge: MSIHANDLE;
  szTableName: PWideChar): UINT; stdcall;
{$EXTERNALSYM MsiDatabaseMergeW}
function MsiDatabaseMerge(hDatabase, hDatabaseMerge: MSIHANDLE;
  szTableName: PChar): UINT; stdcall;
{$EXTERNALSYM MsiDatabaseMerge}

// Generate a transform file of differences between two databases
// Execution of this function sets the error record, accessible via MsiGetLastErrorRecord

function MsiDatabaseGenerateTransformA(hDatabase, hDatabaseReference: MSIHANDLE;
  szTransformFile: PAnsiChar; iReserved1, iReserved2: Integer): UINT; stdcall;
{$EXTERNALSYM MsiDatabaseGenerateTransformA}
function MsiDatabaseGenerateTransformW(hDatabase, hDatabaseReference: MSIHANDLE;
  szTransformFile: PWideChar; iReserved1, iReserved2: Integer): UINT; stdcall;
{$EXTERNALSYM MsiDatabaseGenerateTransformW}
function MsiDatabaseGenerateTransform(hDatabase, hDatabaseReference: MSIHANDLE;
  szTransformFile: PChar; iReserved1, iReserved2: Integer): UINT; stdcall;
{$EXTERNALSYM MsiDatabaseGenerateTransform}

// Apply a transform file containing database difference
// Execution of this function sets the error record, accessible via MsiGetLastErrorRecord

function MsiDatabaseApplyTransformA(hDatabase: MSIHANDLE; szTransformFile: PAnsiChar;
  iErrorConditions: Integer): UINT; stdcall;
{$EXTERNALSYM MsiDatabaseApplyTransformA}
function MsiDatabaseApplyTransformW(hDatabase: MSIHANDLE; szTransformFile: PWideChar;
  iErrorConditions: Integer): UINT; stdcall;
{$EXTERNALSYM MsiDatabaseApplyTransformW}
function MsiDatabaseApplyTransform(hDatabase: MSIHANDLE; szTransformFile: PChar;
  iErrorConditions: Integer): UINT; stdcall;
{$EXTERNALSYM MsiDatabaseApplyTransform}

// Create summary information of existing transform to include validation and error conditions
// Execution of this function sets the error record, accessible via MsiGetLastErrorRecord

function MsiCreateTransformSummaryInfoA(hDatabase, hDatabaseReference: MSIHANDLE;
  szTransformFile: PAnsiChar; iErrorConditions, iValidation: Integer): UINT; stdcall;
{$EXTERNALSYM MsiCreateTransformSummaryInfoA}
function MsiCreateTransformSummaryInfoW(hDatabase, hDatabaseReference: MSIHANDLE;
  szTransformFile: PWideChar; iErrorConditions, iValidation: Integer): UINT; stdcall;
{$EXTERNALSYM MsiCreateTransformSummaryInfoW}
function MsiCreateTransformSummaryInfo(hDatabase, hDatabaseReference: MSIHANDLE;
  szTransformFile: PChar; iErrorConditions, iValidation: Integer): UINT; stdcall;
{$EXTERNALSYM MsiCreateTransformSummaryInfo}

// Write out all persistent table data, ignored if database opened read-only
// Execution of this function sets the error record, accessible via MsiGetLastErrorRecord

function MsiDatabaseCommit(hDatabase: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiDatabaseCommit}

// Return the update state of a database

function MsiGetDatabaseState(hDatabase: MSIHANDLE): TMsiDbState; stdcall;
{$EXTERNALSYM MsiGetDatabaseState}

// --------------------------------------------------------------------------
// Record object functions
// --------------------------------------------------------------------------

// Create a new record object with the requested number of fields
// Field 0, not included in count, is used for format strings and op codes
// All fields are initialized to null
// Returns a handle to the created record, or 0 if memory could not be allocated

function MsiCreateRecord(cParams: UINT): MSIHANDLE; stdcall;
{$EXTERNALSYM MsiCreateRecord}

// Report whether a record field is NULL
// Returns TRUE if the field is null or does not exist
// Returns FALSE if the field contains data, or the handle is invalid

function MsiRecordIsNull(hRecord: MSIHANDLE; iField: UINT): BOOL; stdcall;
{$EXTERNALSYM MsiRecordIsNull}

// Return the length of a record field
// Returns 0 if field is NULL or non-existent
// Returns sizeof(int) if integer data
// Returns character count if string data (not counting null terminator)
// Returns bytes count if stream data

function MsiRecordDataSize(hRecord: MSIHANDLE; iField: UINT): UINT; stdcall;
{$EXTERNALSYM MsiRecordDataSize}

// Set a record field to an integer value
// Returns ERROR_SUCCESS, ERROR_INVALID_HANDLE, ERROR_INVALID_FIELD

function MsiRecordSetInteger(hRecord: MSIHANDLE; iField: UINT; iValue: Integer): UINT; stdcall;
{$EXTERNALSYM MsiRecordSetInteger}

// Copy a string into the designated field
// A null string pointer and an empty string both set the field to null
// Returns ERROR_SUCCESS, ERROR_INVALID_HANDLE, ERROR_INVALID_FIELD

function MsiRecordSetStringA(hRecord: MSIHANDLE; iField: UINT; szValue: PAnsiChar): UINT; stdcall;
{$EXTERNALSYM MsiRecordSetStringA}
function MsiRecordSetStringW(hRecord: MSIHANDLE; iField: UINT; szValue: PWideChar): UINT; stdcall;
{$EXTERNALSYM MsiRecordSetStringW}
function MsiRecordSetString(hRecord: MSIHANDLE; iField: UINT; szValue: PChar): UINT; stdcall;
{$EXTERNALSYM MsiRecordSetString}

// Return the integer value from a record field
// Returns the value MSI_NULL_INTEGER if the field is null
// or if the field is a string that cannot be converted to an integer

function MsiRecordGetInteger(hRecord: MSIHANDLE; iField: UINT): Integer; stdcall;
{$EXTERNALSYM MsiRecordGetInteger}

// Return the string value of a record field
// Integer fields will be converted to a string
// Null and non-existent fields will report a value of 0
// Fields containing stream data will return ERROR_INVALID_DATATYPE
// Returns ERROR_SUCCESS, ERROR_MORE_DATA, 
//         ERROR_INVALID_HANDLE, ERROR_INVALID_FIELD, ERROR_BAD_ARGUMENTS

function MsiRecordGetStringA(hRecord: MSIHANDLE; iField: UINT; szValueBuf: PAnsiChar;
  var pcchValueBuf: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiRecordGetStringA}
function MsiRecordGetStringW(hRecord: MSIHANDLE; iField: UINT; szValueBuf: PWideChar;
  var pcchValueBuf: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiRecordGetStringW}
function MsiRecordGetString(hRecord: MSIHANDLE; iField: UINT; szValueBuf: PChar;
  var pcchValueBuf: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiRecordGetString}

// Returns the number of fields allocated in the record
// Does not count field 0, used for formatting and op codes

function MsiRecordGetFieldCount(hRecord: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiRecordGetFieldCount}

// Set a record stream field from a file
// The contents of the specified file will be read into a stream object
// The stream will be persisted if the record is inserted into the database
// Execution of this function sets the error record, accessible via MsiGetLastErrorRecord

function MsiRecordSetStreamA(hRecord: MSIHANDLE; iField: UINT; szFilePath: PAnsiChar): UINT; stdcall;
{$EXTERNALSYM MsiRecordSetStreamA}
function MsiRecordSetStreamW(hRecord: MSIHANDLE; iField: UINT; szFilePath: PWideChar): UINT; stdcall;
{$EXTERNALSYM MsiRecordSetStreamW}
function MsiRecordSetStream(hRecord: MSIHANDLE; iField: UINT; szFilePath: PChar): UINT; stdcall;
{$EXTERNALSYM MsiRecordSetStream}

// Read bytes from a record stream field into a buffer
// Must set the in/out argument to the requested byte count to read
// The number of bytes transferred is returned through the argument
// If no more bytes are available, ERROR_SUCCESS is still returned

function MsiRecordReadStream(hRecord: MSIHANDLE; iField: UINT; szDataBuf: PChar;
  var pcbDataBuf: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiRecordReadStream}

// Clears all data fields in a record to NULL

function MsiRecordClearData(hRecord: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiRecordClearData}

// --------------------------------------------------------------------------
// Functions to access a running installation, called from custom actions
// The install handle is the single argument passed to custom actions
// --------------------------------------------------------------------------

// Return a handle to the database currently in use by this installer instance

function MsiGetActiveDatabase(hInstall: MSIHANDLE): MSIHANDLE;
{$EXTERNALSYM MsiGetActiveDatabase}

// Set the value for an installer property
// If the property is not defined, it will be created
// If the value is null or an empty string, the property will be removed
// Returns ERROR_SUCCESS, ERROR_INVALID_HANDLE, ERROR_BAD_ARGUMENTS

function MsiSetPropertyA(hInstall: MSIHANDLE;	szName, szValue: PAnsiChar): UINT; stdcall;
{$EXTERNALSYM MsiSetPropertyA}
function MsiSetPropertyW(hInstall: MSIHANDLE;	szName, szValue: PWideChar): UINT; stdcall;
{$EXTERNALSYM MsiSetPropertyW}
function MsiSetProperty(hInstall: MSIHANDLE;	szName, szValue: PChar): UINT; stdcall;
{$EXTERNALSYM MsiSetProperty}

// Get the value for an installer property
// If the property is not defined, it is equivalent to a 0-length value, not error
// Returns ERROR_SUCCESS, ERROR_MORE_DATA, ERROR_INVALID_HANDLE, ERROR_BAD_ARGUMENTS

function MsiGetPropertyA(hInstall: MSIHANDLE; szName: PAnsiChar; szValueBuf: PAnsiChar;
  var pcchValueBuf: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiGetPropertyA}
function MsiGetPropertyW(hInstall: MSIHANDLE; szName: PWideChar; szValueBuf: PWideChar;
  var pcchValueBuf: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiGetPropertyW}
function MsiGetProperty(hInstall: MSIHANDLE; szName: PChar; szValueBuf: PChar;
  var pcchValueBuf: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiGetProperty}

// Return the numeric language for the currently running install
// Returns 0 if an install not running

function MsiGetLanguage(hInstall: MSIHANDLE): LANGID; stdcall;
{$EXTERNALSYM MsiGetLanguage}

// Return one of the boolean internal installer states
// Returns FALSE if the handle is not active or if the mode is not implemented

function MsiGetMode(hInstall: MSIHANDLE; eRunMode: TMsiRunMode): BOOL; stdcall;
{$EXTERNALSYM MsiGetMode}

// Set an internal install session boolean mode - Note: most modes are read-only
// Returns ERROR_SUCCESS if the mode can be set to the desired state
// Returns ERROR_ACCESS_DENIED if the mode is not settable
// Returns ERROR_INVALID_HANDLE if the handle is not an active install session

function MsiSetMode(hInstall: MSIHANDLE; eRunMode: TMsiRunMode; fState: BOOL): UINT; stdcall;
{$EXTERNALSYM MsiSetMode}

// Format record data using a format string containing field markers and/or properties
// Record field 0 must contain the format string
// Other fields must contain data that may be referenced by the format string.

function MsiFormatRecordA(hInstall,	hRecord: MSIHANDLE; szResultBuf: PAnsiChar;
  var pcchResultBuf: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiFormatRecordA}
function MsiFormatRecordW(hInstall,	hRecord: MSIHANDLE; szResultBuf: PWideChar;
  var pcchResultBuf: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiFormatRecordW}
function MsiFormatRecord(hInstall,	hRecord: MSIHANDLE; szResultBuf: PChar;
  var pcchResultBuf: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiFormatRecord}

// Execute another action, either built-in, custom, or UI wizard
// Returns ERROR_FUNCTION_NOT_CALLED if action not found
// Returns ERROR_SUCCESS if action completed succesfully
// Returns ERROR_INSTALL_USEREXIT if user cancelled during action
// Returns ERROR_INSTALL_FAILURE if action failed
// Returns ERROR_INSTALL_SUSPEND if user suspended installation
// Returns ERROR_MORE_DATA if action wishes to skip remaining actions
// Returns ERROR_INVALID_HANDLE_STATE if install session not active
// Returns ERROR_INVALID_DATA if failure calling custom action
// Returns ERROR_INVALID_HANDLE or ERROR_INVALID_PARAMETER if arguments invalid

function MsiDoActionA(hInstall: MSIHANDLE; szAction: PAnsiChar): UINT; stdcall;
{$EXTERNALSYM MsiDoActionA}
function MsiDoActionW(hInstall: MSIHANDLE; szAction: PWideChar): UINT; stdcall;
{$EXTERNALSYM MsiDoActionW}
function MsiDoAction(hInstall: MSIHANDLE; szAction: PChar): UINT; stdcall;
{$EXTERNALSYM MsiDoAction}

// Execute another action sequence, as descibed in the specified table
// Returns the same error codes as MsiDoAction

function MsiSequenceA(hInstall: MSIHANDLE; szTable: PAnsiChar; iSequenceMode: Integer): UINT; stdcall;
{$EXTERNALSYM MsiSequenceA}
function MsiSequenceW(hInstall: MSIHANDLE; szTable: PWideChar; iSequenceMode: Integer): UINT; stdcall;
{$EXTERNALSYM MsiSequenceW}
function MsiSequence(hInstall: MSIHANDLE; szTable: PChar; iSequenceMode: Integer): UINT; stdcall;
{$EXTERNALSYM MsiSequence}

// Send an error record to the installer for processing.
// If field 0 (template) is not set, field 1 must be set to the error code,
//   corresponding the the error message in the Error database table,
//   and the message will be formatted using the template from the Error table
//   before passing it to the UI handler for display.
// Returns Win32 button codes: IDOK IDCANCEL IDABORT IDRETRY IDIGNORE IDYES IDNO
//   or 0 if no action taken, or -1 if invalid argument or handle

function MsiProcessMessage(hInstall: MSIHANDLE; eMessageType: TInstallMessage;
  hRecord: MSIHANDLE): Integer; stdcall;
{$EXTERNALSYM MsiProcessMessage}

// Evaluate a conditional expression containing property names and values

function MsiEvaluateConditionA(hInstall: MSIHANDLE; szCondition: PAnsiChar): TMsiCondition; stdcall;
{$EXTERNALSYM MsiEvaluateConditionA}
function MsiEvaluateConditionW(hInstall: MSIHANDLE; szCondition: PWideChar): TMsiCondition; stdcall;
{$EXTERNALSYM MsiEvaluateConditionW}
function MsiEvaluateCondition(hInstall: MSIHANDLE; szCondition: PChar): TMsiCondition; stdcall;
{$EXTERNALSYM MsiEvaluateCondition}

// Get the installed state and requested action state of a feature
// Execution of this function sets the error record, accessible via MsiGetLastErrorRecord

function MsiGetFeatureStateA(hInstall: MSIHANDLE; szFeature: PAnsiChar;
  var piInstalled, piAction: TInstallState): UINT; stdcall;
{$EXTERNALSYM MsiGetFeatureStateA}
function MsiGetFeatureStateW(hInstall: MSIHANDLE; szFeature: PWideChar;
  var piInstalled, piAction: TInstallState): UINT; stdcall;
{$EXTERNALSYM MsiGetFeatureStateW}
function MsiGetFeatureState(hInstall: MSIHANDLE; szFeature: PChar;
  var piInstalled, piAction: TInstallState): UINT; stdcall;
{$EXTERNALSYM MsiGetFeatureState}

// Request a feature to be set to a specified state
// Execution of this function sets the error record, accessible via MsiGetLastErrorRecord

function MsiSetFeatureStateA(hInstall: MSIHANDLE; szFeature: PAnsiChar;
  iState: TInstallState): UINT; stdcall;
{$EXTERNALSYM MsiSetFeatureStateA}
function MsiSetFeatureStateW(hInstall: MSIHANDLE; szFeature: PWideChar;
  iState: TInstallState): UINT; stdcall;
{$EXTERNALSYM MsiSetFeatureStateW}
function MsiSetFeatureState(hInstall: MSIHANDLE; szFeature: PChar;
  iState: TInstallState): UINT; stdcall;
{$EXTERNALSYM MsiSetFeatureState}

// Get the installed state and requested action state of a component
// Execution of this function sets the error record, accessible via MsiGetLastErrorRecord

function MsiGetComponentStateA(hInstall: MSIHANDLE; szComponent: PAnsiChar;
  var piInstalled, piAction: TInstallState): UINT; stdcall;
{$EXTERNALSYM MsiGetComponentStateA}
function MsiGetComponentStateW(hInstall: MSIHANDLE; szComponent: PWideChar;
  var piInstalled, piAction: TInstallState): UINT; stdcall;
{$EXTERNALSYM MsiGetComponentStateW}
function MsiGetComponentState(hInstall: MSIHANDLE; szComponent: PChar;
  var piInstalled, piAction: TInstallState): UINT; stdcall;
{$EXTERNALSYM MsiGetComponentState}

// Request a component to be set to a specified state
// Execution of this function sets the error record, accessible via MsiGetLastErrorRecord

function MsiSetComponentStateA(hInstall: MSIHANDLE; szComponent: PAnsiChar;
  iState: TInstallState): UINT; stdcall;
{$EXTERNALSYM MsiSetComponentStateA}
function MsiSetComponentStateW(hInstall: MSIHANDLE; szComponent: PWideChar;
  iState: TInstallState): UINT; stdcall;
{$EXTERNALSYM MsiSetComponentStateW}
function MsiSetComponentState(hInstall: MSIHANDLE; szComponent: PChar;
  iState: TInstallState): UINT; stdcall;
{$EXTERNALSYM MsiSetComponentState}

// Return the disk cost for a feature and related features
// Can specify either current feature state or proposed state
// Can specify extent of related features to cost
// Note that adding costs for several features may produce an
// excessively large cost due to shared components and parents.
// Execution of this function sets the error record, accessible via MsiGetLastErrorRecord

function MsiGetFeatureCostA(hInstall: MSIHANDLE; szFeature: PAnsiChar;
	iCostTree: TMsiCostTree; iState: TInstallState; var piCost: Integer): UINT; stdcall;
{$EXTERNALSYM MsiGetFeatureCostA}
function MsiGetFeatureCostW(hInstall: MSIHANDLE; szFeature: PWideChar;
	iCostTree: TMsiCostTree; iState: TInstallState; var piCost: Integer): UINT; stdcall;
{$EXTERNALSYM MsiGetFeatureCostW}
function MsiGetFeatureCost(hInstall: MSIHANDLE; szFeature: PChar;
	iCostTree: TMsiCostTree; iState: TInstallState; var piCost: Integer): UINT; stdcall;
{$EXTERNALSYM MsiGetFeatureCost}

// Set the install level for a full product installation (not a feature request)
// Setting the value to 0 initialized components and features to the default level
// Execution of this function sets the error record, accessible via MsiGetLastErrorRecord

function MsiSetInstallLevel(hInstall: MSIHANDLE; iInstallLevel: Integer): UINT; stdcall;
{$EXTERNALSYM MsiSetInstallLevel}

// Get the valid install states for a feature, represented by bit flags
// For each valid install state, a bit is set of value: (1 << INSTALLSTATE)
// Execution of this function sets the error record, accessible via MsiGetLastErrorRecord

function MsiGetFeatureValidStatesA(hInstall: MSIHANDLE; szFeature: PAnsiChar;
  var dwInstallStates: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiGetFeatureValidStatesA}
function MsiGetFeatureValidStatesW(hInstall: MSIHANDLE; szFeature: PWideChar;
  var dwInstallStates: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiGetFeatureValidStatesW}
function MsiGetFeatureValidStates(hInstall: MSIHANDLE; szFeature: PChar;
  var dwInstallStates: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiGetFeatureValidStates}

// Return the full source path for a folder in the Directory table
// Execution of this function sets the error record, accessible via MsiGetLastErrorRecord

function MsiGetSourcePathA(hInstall: MSIHANDLE; szFolder: PAnsiChar;
  szPathBuf: PAnsiChar; var pcchPathBuf: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiGetSourcePathA}
function MsiGetSourcePathW(hInstall: MSIHANDLE; szFolder: PWideChar;
  szPathBuf: PWideChar; var pcchPathBuf: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiGetSourcePathW}
function MsiGetSourcePath(hInstall: MSIHANDLE; szFolder: PChar;
  szPathBuf: PChar; var pcchPathBuf: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiGetSourcePath}

// Return the full target path for a folder in the Directory table
// Execution of this function sets the error record, accessible via MsiGetLastErrorRecord

function MsiGetTargetPathA(hInstall: MSIHANDLE; szFolder: PAnsiChar;
  szPathBuf: PAnsiChar; var pcchPathBuf: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiGetTargetPathA}
function MsiGetTargetPathW(hInstall: MSIHANDLE; szFolder: PWideChar;
  szPathBuf: PWideChar; var pcchPathBuf: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiGetTargetPathW}
function MsiGetTargetPath(hInstall: MSIHANDLE; szFolder: PChar;
  szPathBuf: PChar; var pcchPathBuf: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiGetTargetPath}

// Set the full target path for a folder in the Directory table
// Execution of this function sets the error record, accessible via MsiGetLastErrorRecord

function MsiSetTargetPathA(hInstall: MSIHANDLE; szFolder, szFolderPath: PAnsiChar): UINT; stdcall;
{$EXTERNALSYM MsiSetTargetPathA}
function MsiSetTargetPathW(hInstall: MSIHANDLE; szFolder, szFolderPath: PWideChar): UINT; stdcall;
{$EXTERNALSYM MsiSetTargetPathW}
function MsiSetTargetPath(hInstall: MSIHANDLE; szFolder, szFolderPath: PChar): UINT; stdcall;
{$EXTERNALSYM MsiSetTargetPath}

// Check to see if sufficent disk space is present for the current installation
// Returns ERROR_SUCCESS, ERROR_DISK_FULL, ERROR_INVALID_HANDLE_STATE, or ERROR_INVALID_HANDLE

function MsiVerifyDiskSpace(hInstall: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiVerifyDiskSpace}

// --------------------------------------------------------------------------
// Functions for rendering UI dialogs from the database representations.
// Purpose is for product development, not for use during installation.
// --------------------------------------------------------------------------

// Enable UI in preview mode to facilitate authoring of UI dialogs.
// The preview mode will end when the handle is closed.

function MsiEnableUIPreview(hDatabase: MSIHANDLE;	var phPreview: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiEnableUIPreview}

// Display any UI dialog as modeless and inactive.
// Supplying a null name will remove any current dialog.

function MsiPreviewDialogA(hPreview: MSIHANDLE; szDialogName: PAnsiChar): UINT; stdcall;
{$EXTERNALSYM MsiPreviewDialogA}
function MsiPreviewDialogW(hPreview: MSIHANDLE; szDialogName: PWideChar): UINT; stdcall;
{$EXTERNALSYM MsiPreviewDialogW}
function MsiPreviewDialog(hPreview: MSIHANDLE; szDialogName: POinter): UINT; stdcall;
{$EXTERNALSYM MsiPreviewDialog}

// Display a billboard within a host control in the displayed dialog.
// Supplying a null billboard name will remove any billboard displayed.

function MsiPreviewBillboardA(hPreview: MSIHANDLE; szControlName,
  szBillboard: PAnsiChar): UINT; stdcall;
{$EXTERNALSYM MsiPreviewBillboardA}
function MsiPreviewBillboardW(hPreview: MSIHANDLE; szControlName,
  szBillboard: PWideChar): UINT; stdcall;
{$EXTERNALSYM MsiPreviewBillboardW}
function MsiPreviewBillboard(hPreview: MSIHANDLE; szControlName,
  szBillboard: PChar): UINT; stdcall;
{$EXTERNALSYM MsiPreviewBillboard}

// Fetch the next sequential record from the view
// Result is ERROR_SUCCESS if a row is found, and its handle is returned
// else ERROR_NO_DATA if no records remain, and a null handle is returned
// else result is error: ERROR_INVALID_HANDLE_STATE, ERROR_INVALID_HANDLE, ERROR_GEN_FAILURE

// --------------------------------------------------------------------------
// Error handling not associated with any particular object
// --------------------------------------------------------------------------

// Return a record handle to the last function that generated an error record
// Only specified functions will set the error record, or clear it if success
// Field 1 of the record will contain the internal MSI error code
// Other fields will contain data specific to the particular error
// The error record is released internally after this function is executed

function MsiGetLastErrorRecord: MSIHANDLE;  // returns 0 if no cached record
{$EXTERNALSYM MsiGetLastErrorRecord}

implementation

const
  MsiLib = 'msi.dll';

// --------------------------------------------------------------------------
// Installer database access functions
// --------------------------------------------------------------------------

function MsiDatabaseOpenViewA; external MsiLib name 'MsiDatabaseOpenViewA';
function MsiDatabaseOpenViewW; external MsiLib name 'MsiDatabaseOpenViewW';
function MsiDatabaseOpenView; external MsiLib name 'MsiDatabaseOpenViewA';
function MsiViewGetErrorA; external MsiLib name 'MsiViewGetErrorA';
function MsiViewGetErrorW; external MsiLib name 'MsiViewGetErrorW';
function MsiViewGetError; external MsiLib name 'MsiViewGetErrorA';
function MsiViewExecute; external MsiLib name 'MsiViewExecute';
function MsiViewFetch; external MsiLib name 'MsiViewFetch';
function MsiViewModify; external MsiLib name 'MsiViewModify';
function MsiViewGetColumnInfo; external MsiLib name 'MsiViewGetColumnInfo';
function MsiViewClose; external MsiLib name 'MsiViewClose';
function MsiDatabaseGetPrimaryKeysA; external MsiLib name 'MsiDatabaseGetPrimaryKeysA';
function MsiDatabaseGetPrimaryKeysW; external MsiLib name 'MsiDatabaseGetPrimaryKeysW';
function MsiDatabaseGetPrimaryKeys; external MsiLib name 'MsiDatabaseGetPrimaryKeysA';
function MsiDatabaseIsTablePersistentA; external MsiLib name 'MsiDatabaseIsTablePersistentA';
function MsiDatabaseIsTablePersistentW; external MsiLib name 'MsiDatabaseIsTablePersistentW';
function MsiDatabaseIsTablePersistent; external MsiLib name 'MsiDatabaseIsTablePersistentA';

// --------------------------------------------------------------------------
// Summary information stream management functions
// --------------------------------------------------------------------------

function MsiGetSummaryInformationA; external MsiLib name 'MsiGetSummaryInformationA';
function MsiGetSummaryInformationW; external MsiLib name 'MsiGetSummaryInformationW';
function MsiGetSummaryInformation; external MsiLib name 'MsiGetSummaryInformationA';
function MsiSummaryInfoGetPropertyCount; external MsiLib name 'MsiSummaryInfoGetPropertyCount';
function MsiSummaryInfoSetPropertyA; external MsiLib name 'MsiSummaryInfoSetPropertyA';
function MsiSummaryInfoSetPropertyW; external MsiLib name 'MsiSummaryInfoSetPropertyW';
function MsiSummaryInfoSetProperty; external MsiLib name 'MsiSummaryInfoSetPropertyA';
function MsiSummaryInfoGetPropertyA; external MsiLib name 'MsiSummaryInfoGetPropertyA';
function MsiSummaryInfoGetPropertyW; external MsiLib name 'MsiSummaryInfoGetPropertyW';
function MsiSummaryInfoGetProperty; external MsiLib name 'MsiSummaryInfoGetPropertyA';
function MsiSummaryInfoPersist; external MsiLib name 'MsiSummaryInfoPersist';

// --------------------------------------------------------------------------
// Installer database management functions - not used by custom actions
// --------------------------------------------------------------------------

function MsiOpenDatabaseA; external MsiLib name 'MsiOpenDatabaseA';
function MsiOpenDatabaseW; external MsiLib name 'MsiOpenDatabaseW';
function MsiOpenDatabase; external MsiLib name 'MsiOpenDatabaseA';
function MsiDatabaseImportA; external MsiLib name 'MsiDatabaseImportA';
function MsiDatabaseImportW; external MsiLib name 'MsiDatabaseImportW';
function MsiDatabaseImport; external MsiLib name 'MsiDatabaseImportA';
function MsiDatabaseExportA; external MsiLib name 'MsiDatabaseExportA';
function MsiDatabaseExportW; external MsiLib name 'MsiDatabaseExportW';
function MsiDatabaseExport; external MsiLib name 'MsiDatabaseExportA';
function MsiDatabaseMergeA; external MsiLib name 'MsiDatabaseMergeA';
function MsiDatabaseMergeW; external MsiLib name 'MsiDatabaseMergeW';
function MsiDatabaseMerge; external MsiLib name 'MsiDatabaseMergeA';
function MsiDatabaseGenerateTransformA; external MsiLib name 'MsiDatabaseGenerateTransformA';
function MsiDatabaseGenerateTransformW; external MsiLib name 'MsiDatabaseGenerateTransformW';
function MsiDatabaseGenerateTransform; external MsiLib name 'MsiDatabaseGenerateTransformA';
function MsiDatabaseApplyTransformA; external MsiLib name 'MsiDatabaseApplyTransformA';
function MsiDatabaseApplyTransformW; external MsiLib name 'MsiDatabaseApplyTransformW';
function MsiDatabaseApplyTransform; external MsiLib name 'MsiDatabaseApplyTransformA';
function MsiCreateTransformSummaryInfoA; external MsiLib name 'MsiCreateTransformSummaryInfoA';
function MsiCreateTransformSummaryInfoW; external MsiLib name 'MsiCreateTransformSummaryInfoW';
function MsiCreateTransformSummaryInfo; external MsiLib name 'MsiCreateTransformSummaryInfoA';
function MsiDatabaseCommit; external MsiLib name 'MsiDatabaseCommit';
function MsiGetDatabaseState; external MsiLib name 'MsiGetDatabaseState';

// --------------------------------------------------------------------------
// Record object functions
// --------------------------------------------------------------------------

function MsiCreateRecord; external MsiLib name 'MsiCreateRecord';
function MsiRecordIsNull; external MsiLib name 'MsiRecordIsNull';
function MsiRecordDataSize; external MsiLib name 'MsiRecordDataSize';
function MsiRecordSetInteger; external MsiLib name 'MsiRecordSetInteger';
function MsiRecordSetStringA; external MsiLib name 'MsiRecordSetStringA';
function MsiRecordSetStringW; external MsiLib name 'MsiRecordSetStringW';
function MsiRecordSetString; external MsiLib name 'MsiRecordSetStringA';
function MsiRecordGetInteger; external MsiLib name 'MsiRecordGetInteger';
function MsiRecordGetStringA; external MsiLib name 'MsiRecordGetStringA';
function MsiRecordGetStringW; external MsiLib name 'MsiRecordGetStringW';
function MsiRecordGetString; external MsiLib name 'MsiRecordGetStringA';
function MsiRecordGetFieldCount; external MsiLib name 'MsiRecordGetFieldCount';
function MsiRecordSetStreamA; external MsiLib name 'MsiRecordSetStreamA';
function MsiRecordSetStreamW; external MsiLib name 'MsiRecordSetStreamW';
function MsiRecordSetStream; external MsiLib name 'MsiRecordSetStreamA';
function MsiRecordReadStream; external MsiLib name 'MsiRecordReadStream';
function MsiRecordClearData; external MsiLib name 'MsiRecordClearData';

// --------------------------------------------------------------------------
// Functions to access a running installation, called from custom actions
// The install handle is the single argument passed to custom actions
// --------------------------------------------------------------------------

function MsiGetActiveDatabase; external MsiLib name 'MsiGetActiveDatabase';
function MsiSetPropertyA; external MsiLib name 'MsiSetPropertyA';
function MsiSetPropertyW; external MsiLib name 'MsiSetPropertyW';
function MsiSetProperty; external MsiLib name 'MsiSetPropertyA';
function MsiGetPropertyA; external MsiLib name 'MsiGetPropertyA';
function MsiGetPropertyW; external MsiLib name 'MsiGetPropertyW';
function MsiGetProperty; external MsiLib name 'MsiGetPropertyA';
function MsiGetLanguage; external MsiLib name 'MsiGetLanguage';
function MsiGetMode; external MsiLib name 'MsiGetMode';
function MsiSetMode; external MsiLib name 'MsiSetMode';
function MsiFormatRecordA; external MsiLib name 'MsiFormatRecordA';
function MsiFormatRecordW; external MsiLib name 'MsiFormatRecordW';
function MsiFormatRecord; external MsiLib name 'MsiFormatRecordA';
function MsiDoActionA; external MsiLib name 'MsiDoActionA';
function MsiDoActionW; external MsiLib name 'MsiDoActionW';
function MsiDoAction; external MsiLib name 'MsiDoActionA';
function MsiSequenceA; external MsiLib name 'MsiSequenceA';
function MsiSequenceW; external MsiLib name 'MsiSequenceW';
function MsiSequence; external MsiLib name 'MsiSequenceA';
function MsiProcessMessage; external MsiLib name 'MsiProcessMessage';
function MsiEvaluateConditionA; external MsiLib name 'MsiEvaluateConditionA';
function MsiEvaluateConditionW; external MsiLib name 'MsiEvaluateConditionW';
function MsiEvaluateCondition; external MsiLib name 'MsiEvaluateConditionA';
function MsiGetFeatureStateA; external MsiLib name 'MsiGetFeatureStateA';
function MsiGetFeatureStateW; external MsiLib name 'MsiGetFeatureStateW';
function MsiGetFeatureState; external MsiLib name 'MsiGetFeatureStateA';
function MsiSetFeatureStateA; external MsiLib name 'MsiSetFeatureStateA';
function MsiSetFeatureStateW; external MsiLib name 'MsiSetFeatureStateW';
function MsiSetFeatureState; external MsiLib name 'MsiSetFeatureStateA';
function MsiGetComponentStateA; external MsiLib name 'MsiGetComponentStateA';
function MsiGetComponentStateW; external MsiLib name 'MsiGetComponentStateW';
function MsiGetComponentState; external MsiLib name 'MsiGetComponentStateA';
function MsiSetComponentStateA; external MsiLib name 'MsiSetComponentStateA';
function MsiSetComponentStateW; external MsiLib name 'MsiSetComponentStateW';
function MsiSetComponentState; external MsiLib name 'MsiSetComponentStateA';
function MsiGetFeatureCostA; external MsiLib name 'MsiGetFeatureCostA';
function MsiGetFeatureCostW; external MsiLib name 'MsiGetFeatureCostW';
function MsiGetFeatureCost; external MsiLib name 'MsiGetFeatureCostA';
function MsiSetInstallLevel; external MsiLib name 'MsiSetInstallLevel';
function MsiGetFeatureValidStatesA; external MsiLib name 'MsiGetFeatureValidStatesA';
function MsiGetFeatureValidStatesW; external MsiLib name 'MsiGetFeatureValidStatesW';
function MsiGetFeatureValidStates; external MsiLib name 'MsiGetFeatureValidStatesA';
function MsiGetSourcePathA; external MsiLib name 'MsiGetSourcePathA';
function MsiGetSourcePathW; external MsiLib name 'MsiGetSourcePathW';
function MsiGetSourcePath; external MsiLib name 'MsiGetSourcePathA';
function MsiGetTargetPathA; external MsiLib name 'MsiGetTargetPathA';
function MsiGetTargetPathW; external MsiLib name 'MsiGetTargetPathW';
function MsiGetTargetPath; external MsiLib name 'MsiGetTargetPathA';
function MsiSetTargetPathA; external MsiLib name 'MsiSetTargetPathA';
function MsiSetTargetPathW; external MsiLib name 'MsiSetTargetPathW';
function MsiSetTargetPath; external MsiLib name 'MsiSetTargetPathA';
function MsiVerifyDiskSpace; external MsiLib name 'MsiVerifyDiskSpace';

// --------------------------------------------------------------------------
// Functions for rendering UI dialogs from the database representations.
// Purpose is for product development, not for use during installation.
// --------------------------------------------------------------------------

function MsiEnableUIPreview; external MsiLib name 'MsiEnableUIPreview';
function MsiPreviewDialogA; external MsiLib name 'MsiPreviewDialogA';
function MsiPreviewDialogW; external MsiLib name 'MsiPreviewDialogW';
function MsiPreviewDialog; external MsiLib name 'MsiPreviewDialogA';
function MsiPreviewBillboardA; external MsiLib name 'MsiPreviewBillboardA';
function MsiPreviewBillboardW; external MsiLib name 'MsiPreviewBillboardW';
function MsiPreviewBillboard; external MsiLib name 'MsiPreviewBillboardA';

// --------------------------------------------------------------------------
// Error handling not associated with any particular object
// --------------------------------------------------------------------------

function MsiGetLastErrorRecord; external MsiLib name 'MsiGetLastErrorRecord';

end.
