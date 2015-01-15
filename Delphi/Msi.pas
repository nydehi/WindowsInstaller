unit Msi;
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
{$HPPEMIT '#include "msi.h"'}
{$HPPEMIT ''}

uses
  Windows;
const
 // ERROR_INSTALL_FAILURE = 1603;
  ERROR_SUCCESS =0;
  ERROR_MORE_DATA =234;

// NOTES:  All buffers sizes are TCHAR count, null included only on input      
//         Return argument pointers may be null if not interested in value

// --------------------------------------------------------------------------
// Installer generic handle definitions
// --------------------------------------------------------------------------

type
  UINT = LongWord;
  PHWND = ^HWND;           // Introduced for MsiSetInternalUI
  MSIHANDLE = THandle;     // abstract generic handle, 0 == no Handle
  {$EXTERNALSYM MSIHANDLE}

// Close a open handle of any type
// All handles obtained from API calls must be closed when no longer needed
// Normally succeeds, returning TRUE.

function MsiCloseHandle(hAny: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiCloseHandle}

// Close all handles open in the process, a diagnostic call
// This should NOT be used as a cleanup mechanism -- use PMSIHANDLE class
// Can be called at termination to assure that all handles have been closed
// Returns 0 if all handles have been close, else number of open handles

function MsiCloseAllHandles: UINT; stdcall;
{$EXTERNALSYM MsiCloseAllHandles}

// Install message type for callback is a combination of the following:
//  A message box style:      MB_*, where MB_OK is the default
//  A message box icon type:  MB_ICON*, where no icon is the default
//  A default button:         MB_DEFBUTTON?, where MB_DEFBUTTON1 is the default
//  One of the following install message types, no default

const
  INSTALLMESSAGE_FATALEXIT      = $00000000; // premature termination, possibly fatal OOM
  {$EXTERNALSYM INSTALLMESSAGE_FATALEXIT}
  INSTALLMESSAGE_ERROR          = $01000000; // formatted error message
  {$EXTERNALSYM INSTALLMESSAGE_ERROR}
  INSTALLMESSAGE_WARNING        = $02000000; // formatted warning message
  {$EXTERNALSYM INSTALLMESSAGE_WARNING}
  INSTALLMESSAGE_USER           = $03000000; // user request message
  {$EXTERNALSYM INSTALLMESSAGE_USER}
  INSTALLMESSAGE_INFO           = $04000000; // informative message for log
  {$EXTERNALSYM INSTALLMESSAGE_INFO}
  INSTALLMESSAGE_FILESINUSE     = $05000000; // list of files in use that need to be replaced
  {$EXTERNALSYM INSTALLMESSAGE_FILESINUSE}
  INSTALLMESSAGE_RESOLVESOURCE  = $06000000; // request to determine a valid source location
  {$EXTERNALSYM INSTALLMESSAGE_RESOLVESOURCE}
  INSTALLMESSAGE_OUTOFDISKSPACE = $07000000; // insufficient disk space message
  {$EXTERNALSYM INSTALLMESSAGE_OUTOFDISKSPACE}
  INSTALLMESSAGE_ACTIONSTART    = $08000000; // start of action: action name & description
  {$EXTERNALSYM INSTALLMESSAGE_ACTIONSTART}
  INSTALLMESSAGE_ACTIONDATA     = $09000000; // formatted data associated with individual action item
  {$EXTERNALSYM INSTALLMESSAGE_ACTIONDATA}
  INSTALLMESSAGE_PROGRESS       = $0A000000; // progress gauge info: units so far, total
  {$EXTERNALSYM INSTALLMESSAGE_PROGRESS}
  INSTALLMESSAGE_COMMONDATA     = $0B000000; // product info for dialog: language Id, dialog Caption
  {$EXTERNALSYM INSTALLMESSAGE_COMMONDATA}
  INSTALLMESSAGE_INITIALIZE     = $0C000000; // sent prior to UI initialization, no string data
  {$EXTERNALSYM INSTALLMESSAGE_INITIALIZE}
  INSTALLMESSAGE_TERMINATE      = $0D000000; // sent after UI termination, no string data
  {$EXTERNALSYM INSTALLMESSAGE_TERMINATE}
  INSTALLMESSAGE_SHOWDIALOG     = $0E000000; // sent prior to display or authored dialog or wizard
  {$EXTERNALSYM INSTALLMESSAGE_SHOWDIALOG}

type
  TInstallMessage = INSTALLMESSAGE_FATALEXIT..INSTALLMESSAGE_SHOWDIALOG;

// external error handler supplied to installation API function

  TInstallUIHandlerA = function (pvContext: Pointer; iMessageType: UINT; szMessage: PAnsiChar): Integer; stdcall;
  TInstallUIHandlerW = function (pvContext: Pointer; iMessageType: UINT; szMessage: PWideChar): Integer; stdcall;
  TInstallUIHandler = TInstallUIHandlerA;

const
  INSTALLUILEVEL_NOCHANGE     = 0;  // UI level is unchanged
  {$EXTERNALSYM INSTALLUILEVEL_NOCHANGE}
  INSTALLUILEVEL_DEFAULT      = 1;  // default UI is uses
  {$EXTERNALSYM INSTALLUILEVEL_DEFAULT}
  INSTALLUILEVEL_NONE         = 2;  // completely silent installation
  {$EXTERNALSYM INSTALLUILEVEL_NONE}
  INSTALLUILEVEL_BASIC        = 3;  // simple progress and error handling
  {$EXTERNALSYM INSTALLUILEVEL_BASIC}
  INSTALLUILEVEL_REDUCED      = 4;  // authored UI, wizard dialogs suppressed
  {$EXTERNALSYM INSTALLUILEVEL_REDUCED}
  INSTALLUILEVEL_FULL         = 5;  // authored UI with wizards, progress, errors
  {$EXTERNALSYM INSTALLUILEVEL_FULL}
  INSTALLUILEVEL_PROGRESSONLY = $40; // display only progress dialog
  {$EXTERNALSYM INSTALLUILEVEL_PROGRESSONLY}
  INSTALLUILEVEL_ENDDIALOG    = $80; // display success/failure dialog at end of install
  {$EXTERNALSYM INSTALLUILEVEL_ENDDIALOG}

type
  TInstallUILevel = INSTALLUILEVEL_NOCHANGE..INSTALLUILEVEL_ENDDIALOG;

const
  INSTALLSTATE_NOTUSED      = -7;  // component disabled
  {$EXTERNALSYM INSTALLSTATE_NOTUSED}
  INSTALLSTATE_BADCONFIG    = -6;  // configuration data corrupt
  {$EXTERNALSYM INSTALLSTATE_BADCONFIG}
  INSTALLSTATE_INCOMPLETE   = -5;  // installation suspended or in progress
  {$EXTERNALSYM INSTALLSTATE_INCOMPLETE}
  INSTALLSTATE_SOURCEABSENT = -4;  // run from source, source is unavailable
  {$EXTERNALSYM INSTALLSTATE_SOURCEABSENT}
  INSTALLSTATE_MOREDATA     = -3;  // return buffer overflow
  {$EXTERNALSYM INSTALLSTATE_MOREDATA}
  INSTALLSTATE_INVALIDARG   = -2;  // invalid function argument
  {$EXTERNALSYM INSTALLSTATE_INVALIDARG}
  INSTALLSTATE_UNKNOWN      = -1;  // unrecognized product or feature
  {$EXTERNALSYM INSTALLSTATE_UNKNOWN}
  INSTALLSTATE_BROKEN       =  0;  // broken
  {$EXTERNALSYM INSTALLSTATE_BROKEN}
  INSTALLSTATE_ADVERTISED   =  1;  // advertised feature
  {$EXTERNALSYM INSTALLSTATE_ADVERTISED}
  INSTALLSTATE_REMOVED      =  1;  // component being removed (action state, not settable)
  {$EXTERNALSYM INSTALLSTATE_REMOVED}
  INSTALLSTATE_ABSENT       =  2;  // uninstalled
  {$EXTERNALSYM INSTALLSTATE_ABSENT}
  INSTALLSTATE_LOCAL        =  3;  // installed on local drive
  {$EXTERNALSYM INSTALLSTATE_LOCAL}
  INSTALLSTATE_SOURCE       =  4;  // run from source, CD or Next
  {$EXTERNALSYM INSTALLSTATE_SOURCE}
  INSTALLSTATE_DEFAULT      =  5;  // use default, local or Source
  {$EXTERNALSYM INSTALLSTATE_DEFAULT}

type
  TInstallState = INSTALLSTATE_NOTUSED..INSTALLSTATE_DEFAULT;

const
  USERINFOSTATE_MOREDATA   = -3;  // return buffer overflow
  {$EXTERNALSYM USERINFOSTATE_MOREDATA}
  USERINFOSTATE_INVALIDARG = -2;  // invalid function argument
  {$EXTERNALSYM USERINFOSTATE_INVALIDARG}
  USERINFOSTATE_UNKNOWN    = -1;  // unrecognized product
  {$EXTERNALSYM USERINFOSTATE_UNKNOWN}
  USERINFOSTATE_ABSENT     =  0;  // user info and PID not initialized
  {$EXTERNALSYM USERINFOSTATE_ABSENT}
  USERINFOSTATE_PRESENT    =  1;  // user info and PID initialized
  {$EXTERNALSYM USERINFOSTATE_PRESENT}

type
  TUserInfoState = USERINFOSTATE_MOREDATA..USERINFOSTATE_PRESENT;

const
  INSTALLLEVEL_DEFAULT = 0;             // install authored default
  {$EXTERNALSYM INSTALLLEVEL_DEFAULT}
  INSTALLLEVEL_MINIMUM = 1;             // install only required features
  {$EXTERNALSYM INSTALLLEVEL_MINIMUM}
  INSTALLLEVEL_MAXIMUM = DWORD($FFFF); // install all features
  {$EXTERNALSYM INSTALLLEVEL_MAXIMUM}   // intermediate levels dependent on authoring

type
  TInstallLevel = INSTALLLEVEL_DEFAULT..INSTALLLEVEL_MAXIMUM;

const
  REINSTALLMODE_REPAIR           = $00000001;  // Reserved bit - currently ignored
  {$EXTERNALSYM REINSTALLMODE_REPAIR}
  REINSTALLMODE_FILEMISSING      = $00000002;  // Reinstall only if file is missing
  {$EXTERNALSYM REINSTALLMODE_FILEMISSING}
  REINSTALLMODE_FILEOLDERVERSION = $00000004;  // Reinstall if file is missing, or older version
  {$EXTERNALSYM REINSTALLMODE_FILEOLDERVERSION}
  REINSTALLMODE_FILEEQUALVERSION = $00000008;  // Reinstall if file is missing, or equal or older version
  {$EXTERNALSYM REINSTALLMODE_FILEEQUALVERSION}
  REINSTALLMODE_FILEEXACT        = $00000010;  // Reinstall if file is missing, or not exact version
  {$EXTERNALSYM REINSTALLMODE_FILEEXACT}
  REINSTALLMODE_FILEVERIFY       = $00000020;  // checksum executables, reinstall if missing or corrupt
  {$EXTERNALSYM REINSTALLMODE_FILEVERIFY}
  REINSTALLMODE_FILEREPLACE      = $00000040;  // Reinstall all files, regardless of version
  {$EXTERNALSYM REINSTALLMODE_FILEREPLACE}
  REINSTALLMODE_MACHINEDATA      = $00000080;  // insure required machine reg entries
  {$EXTERNALSYM REINSTALLMODE_MACHINEDATA}
  REINSTALLMODE_USERDATA         = $00000100;  // insure required user reg entries
  {$EXTERNALSYM REINSTALLMODE_USERDATA}
  REINSTALLMODE_SHORTCUT         = $00000200;  // validate shortcuts Items
  {$EXTERNALSYM REINSTALLMODE_SHORTCUT}
  REINSTALLMODE_PACKAGE          = $00000400;  // use re-cache source install package
  {$EXTERNALSYM REINSTALLMODE_PACKAGE}

type
  TReinstallMode = REINSTALLMODE_REPAIR..REINSTALLMODE_PACKAGE;

const
  INSTALLLOGMODE_FATALEXIT      = (1 shl (INSTALLMESSAGE_FATALEXIT shr 24));
  {$EXTERNALSYM INSTALLLOGMODE_FATALEXIT}
  INSTALLLOGMODE_ERROR          = (1 shl (INSTALLMESSAGE_ERROR shr 24));
  {$EXTERNALSYM INSTALLLOGMODE_ERROR}
  INSTALLLOGMODE_WARNING        = (1 shl (INSTALLMESSAGE_WARNING shr 24));
  {$EXTERNALSYM INSTALLLOGMODE_WARNING}
  INSTALLLOGMODE_USER           = (1 shl (INSTALLMESSAGE_USER shr 24));
  {$EXTERNALSYM INSTALLLOGMODE_USER}
  INSTALLLOGMODE_INFO           = (1 shl (INSTALLMESSAGE_INFO shr 24));
  {$EXTERNALSYM INSTALLLOGMODE_INFO}
  INSTALLLOGMODE_RESOLVESOURCE  = (1 shl (INSTALLMESSAGE_RESOLVESOURCE shr 24));
  {$EXTERNALSYM INSTALLLOGMODE_RESOLVESOURCE}
  INSTALLLOGMODE_OUTOFDISKSPACE = (1 shl (INSTALLMESSAGE_OUTOFDISKSPACE shr 24));
  {$EXTERNALSYM INSTALLLOGMODE_OUTOFDISKSPACE}
  INSTALLLOGMODE_ACTIONSTART    = (1 shl (INSTALLMESSAGE_ACTIONSTART shr 24));
  {$EXTERNALSYM INSTALLLOGMODE_ACTIONSTART}
  INSTALLLOGMODE_ACTIONDATA     = (1 shl (INSTALLMESSAGE_ACTIONDATA shr 24));
  {$EXTERNALSYM INSTALLLOGMODE_ACTIONDATA}
  INSTALLLOGMODE_COMMONDATA     = (1 shl (INSTALLMESSAGE_COMMONDATA shr 24));
  {$EXTERNALSYM INSTALLLOGMODE_COMMONDATA}
  INSTALLLOGMODE_PROPERTYDUMP   = (1 shl (INSTALLMESSAGE_PROGRESS shr 24));   // log only
  {$EXTERNALSYM INSTALLLOGMODE_PROPERTYDUMP}
  INSTALLLOGMODE_VERBOSE        = (1 shl (INSTALLMESSAGE_INITIALIZE shr 24)); // log only
  {$EXTERNALSYM INSTALLLOGMODE_VERBOSE}
  INSTALLLOGMODE_PROGRESS       = (1 shl (INSTALLMESSAGE_PROGRESS shr 24));   // external handler only
  {$EXTERNALSYM INSTALLLOGMODE_PROGRESS}
  INSTALLLOGMODE_INITIALIZE     = (1 shl (INSTALLMESSAGE_INITIALIZE shr 24)); // external handler only
  {$EXTERNALSYM INSTALLLOGMODE_INITIALIZE}
  INSTALLLOGMODE_TERMINATE      = (1 shl (INSTALLMESSAGE_TERMINATE shr 24));  // external handler only
  {$EXTERNALSYM INSTALLLOGMODE_TERMINATE}
  INSTALLLOGMODE_SHOWDIALOG     = (1 shl (INSTALLMESSAGE_SHOWDIALOG shr 24)); // external handler only
  {$EXTERNALSYM INSTALLLOGMODE_SHOWDIALOG}

type
  TInstallLogMode = INSTALLLOGMODE_FATALEXIT..INSTALLLOGMODE_SHOWDIALOG;

const
  INSTALLLOGATTRIBUTES_APPEND        = 1 shl 0;
  {$EXTERNALSYM INSTALLLOGATTRIBUTES_APPEND}
  INSTALLLOGATTRIBUTES_FLUSHEACHLINE = 1 shl 1;
  {$EXTERNALSYM INSTALLLOGATTRIBUTES_FLUSHEACHLINE}

type
  TInstallLogAttributes = INSTALLLOGATTRIBUTES_APPEND..INSTALLLOGATTRIBUTES_FLUSHEACHLINE;

const
  INSTALLFEATUREATTRIBUTE_FAVORLOCAL             = 1 shl 0;
  {$EXTERNALSYM INSTALLFEATUREATTRIBUTE_FAVORLOCAL}
  INSTALLFEATUREATTRIBUTE_FAVORSOURCE            = 1 shl 1;
  {$EXTERNALSYM INSTALLFEATUREATTRIBUTE_FAVORSOURCE}
  INSTALLFEATUREATTRIBUTE_FOLLOWPARENT           = 1 shl 2;
  {$EXTERNALSYM INSTALLFEATUREATTRIBUTE_FOLLOWPARENT}
  INSTALLFEATUREATTRIBUTE_FAVORADVERTISE         = 1 shl 3;
  {$EXTERNALSYM INSTALLFEATUREATTRIBUTE_FAVORADVERTISE}
  INSTALLFEATUREATTRIBUTE_DISALLOWADVERTISE      = 1 shl 4;
  {$EXTERNALSYM INSTALLFEATUREATTRIBUTE_DISALLOWADVERTISE}
  INSTALLFEATUREATTRIBUTE_NOUNSUPPORTEDADVERTISE = 1 shl 5;
  {$EXTERNALSYM INSTALLFEATUREATTRIBUTE_NOUNSUPPORTEDADVERTISE}

type
  TInstallFeatureAttribute = INSTALLFEATUREATTRIBUTE_FAVORLOCAL..INSTALLFEATUREATTRIBUTE_NOUNSUPPORTEDADVERTISE;

const
  INSTALLMODE_NOSOURCERESOLUTION = -3;  // skip source resolution
  {$EXTERNALSYM INSTALLMODE_NOSOURCERESOLUTION}
  INSTALLMODE_NODETECTION        = -2;  // skip detection
  {$EXTERNALSYM INSTALLMODE_NODETECTION}
  INSTALLMODE_EXISTING           = -1;  // provide, if available
  {$EXTERNALSYM INSTALLMODE_EXISTING}
  INSTALLMODE_DEFAULT            =  0;  // install, if absent
  {$EXTERNALSYM INSTALLMODE_DEFAULT}

type
  TInstallMode = INSTALLMODE_NOSOURCERESOLUTION..INSTALLMODE_DEFAULT;

const
  MAX_FEATURE_CHARS = 38;   // maximum chars in feature name (same as string GUID)
  {$EXTERNALSYM MAX_FEATURE_CHARS}

// Product info attributes: advertised information

  INSTALLPROPERTY_TRANSFORMS     : LPCTSTR = 'Transforms';
  {$EXTERNALSYM INSTALLPROPERTY_TRANSFORMS}
  INSTALLPROPERTY_LANGUAGE       : LPCTSTR = 'Language';
  {$EXTERNALSYM INSTALLPROPERTY_LANGUAGE}
  INSTALLPROPERTY_PRODUCTNAME    : LPCTSTR = 'ProductName';
  {$EXTERNALSYM INSTALLPROPERTY_PRODUCTNAME}
  INSTALLPROPERTY_ASSIGNMENTTYPE : LPCTSTR = 'AssignmentType';
  {$EXTERNALSYM INSTALLPROPERTY_ASSIGNMENTTYPE}
  INSTALLPROPERTY_PACKAGECODE    : LPCTSTR = 'PackageCode';
  {$EXTERNALSYM INSTALLPROPERTY_PACKAGECODE}
  INSTALLPROPERTY_VERSION        : LPCTSTR = 'Version';
  {$EXTERNALSYM INSTALLPROPERTY_VERSION}

// Product info attributes: installed information

  INSTALLPROPERTY_INSTALLEDPRODUCTNAME : LPCTSTR = 'InstalledProductName';
  {$EXTERNALSYM INSTALLPROPERTY_INSTALLEDPRODUCTNAME}
  INSTALLPROPERTY_VERSIONSTRING        : LPCTSTR = 'VersionString';
  {$EXTERNALSYM INSTALLPROPERTY_VERSIONSTRING}
  INSTALLPROPERTY_HELPLINK             : LPCTSTR = 'HelpLink';
  {$EXTERNALSYM INSTALLPROPERTY_HELPLINK}
  INSTALLPROPERTY_HELPTELEPHONE        : LPCTSTR = 'HelpTelephone';
  {$EXTERNALSYM INSTALLPROPERTY_HELPTELEPHONE}
  INSTALLPROPERTY_INSTALLLOCATION      : LPCTSTR = 'InstallLocation';
  {$EXTERNALSYM INSTALLPROPERTY_INSTALLLOCATION}
  INSTALLPROPERTY_INSTALLSOURCE        : LPCTSTR = 'InstallSource';
  {$EXTERNALSYM INSTALLPROPERTY_INSTALLSOURCE}
  INSTALLPROPERTY_INSTALLDATE          : LPCTSTR = 'InstallDate';
  {$EXTERNALSYM INSTALLPROPERTY_INSTALLDATE}
  INSTALLPROPERTY_PUBLISHER            : LPCTSTR = 'Publisher';
  {$EXTERNALSYM INSTALLPROPERTY_PUBLISHER}
  INSTALLPROPERTY_LOCALPACKAGE         : LPCTSTR = 'LocalPackage';
  {$EXTERNALSYM INSTALLPROPERTY_LOCALPACKAGE}
  INSTALLPROPERTY_URLINFOABOUT         : LPCTSTR = 'URLInfoAbout';
  {$EXTERNALSYM INSTALLPROPERTY_URLINFOABOUT}
  INSTALLPROPERTY_URLUPDATEINFO        : LPCTSTR = 'URLUpdateInfo';
  {$EXTERNALSYM INSTALLPROPERTY_URLUPDATEINFO}
  INSTALLPROPERTY_VERSIONMINOR         : LPCTSTR = 'VersionMinor';
  {$EXTERNALSYM INSTALLPROPERTY_VERSIONMINOR}
  INSTALLPROPERTY_VERSIONMAJOR         : LPCTSTR = 'VersionMajor';
  {$EXTERNALSYM INSTALLPROPERTY_VERSIONMAJOR}

const
	INSTALLTYPE_DEFAULT       = 0;   // set to indicate default behavior
  {$EXTERNALSYM INSTALLTYPE_DEFAULT}
	INSTALLTYPE_NETWORK_IMAGE = 1;   // set to indicate network install
  {$EXTERNALSYM INSTALLTYPE_NETWORK_IMAGE}

type
  TInstallType = INSTALLTYPE_DEFAULT..INSTALLTYPE_NETWORK_IMAGE;

// --------------------------------------------------------------------------
// Functions to set the UI handling and logging. The UI will be used for error,
// progress, and log messages for all subsequent calls to Installer Service
// API functions that require UI.
// --------------------------------------------------------------------------

// Enable internal UI

function MsiSetInternalUI(dwUILevel: TInstallUILevel;	phWnd: PHWND): TInstallUILevel; stdcall;
{$EXTERNALSYM MsiSetInternalUI}

// Enable external UI handling, returns any previous handler or NULL if none.
// Messages are designated with a combination of bits from INSTALLLOGMODE enum.

function MsiSetExternalUIA(puiHandler: TInstallUIHandlerA;
  dwMessageFilter: DWORD; pvContext: Pointer): TInstallUIHandlerA; stdcall;
{$EXTERNALSYM MsiSetExternalUIA}
function MsiSetExternalUIW(puiHandler: TInstallUIHandlerW;
  dwMessageFilter: DWORD; pvContext: Pointer): TInstallUIHandlerW; stdcall;
{$EXTERNALSYM MsiSetExternalUIW}
function MsiSetExternalUI(puiHandler: TInstallUIHandler;
  dwMessageFilter: DWORD; pvContext: Pointer): TInstallUIHandler; stdcall;
{$EXTERNALSYM MsiSetExternalUI}

// Enable logging to a file for all install sessions for the client process,
// with control over which log messages are passed to the specified log file.
// Messages are designated with a combination of bits from INSTALLLOGMODE enum.

function MsiEnableLogA(dwLogMode: DWORD; szLogFile: PAnsiChar; dwLogAttributes: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiEnableLogA}
function MsiEnableLogW(dwLogMode: DWORD; szLogFile: PWideChar; dwLogAttributes: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiEnableLogW}
function MsiEnableLog(dwLogMode: DWORD; szLogFile: PChar; dwLogAttributes: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiEnableLog}

// --------------------------------------------------------------------------
// Functions to query and configure a product as a whole.
// A component descriptor string may be used instead of the product code.
// --------------------------------------------------------------------------

// Return the installed state for a product

function MsiQueryProductStateA(szProduct: PAnsiChar): TInstallState; stdcall;
{$EXTERNALSYM MsiQueryProductStateA}
function MsiQueryProductStateW(szProduct: PWideChar): TInstallState; stdcall;
{$EXTERNALSYM MsiQueryProductStateW}
function MsiQueryProductState(szProduct: PChar): TInstallState; stdcall;
{$EXTERNALSYM MsiQueryProductState}

// Return product info

function MsiGetProductInfoA(szProduct, szAttribute: PAnsiChar; lpValueBuf: PAnsiChar;
  pcchValueBuf: PDWORD): UINT; stdcall;
{$EXTERNALSYM MsiGetProductInfoA}
function MsiGetProductInfoW(szProduct, szAttribute: PWideChar; lpValueBuf: PAnsiChar;
  pcchValueBuf: PDWORD): UINT; stdcall;
{$EXTERNALSYM MsiGetProductInfoW}
function MsiGetProductInfo(szProduct, szAttribute: PChar; lpValueBuf: PAnsiChar;
  pcchValueBuf: PDWORD): UINT; stdcall;
{$EXTERNALSYM MsiGetProductInfo}

// Install a new product.
// Either may be NULL, but the DATABASE property must be specfied

function MsiInstallProductA(szPackagePath, szCommandLine: PAnsiChar): UINT; stdcall;
{$EXTERNALSYM MsiInstallProductA}
function MsiInstallProductW(szPackagePath, szCommandLine: PWideChar): UINT; stdcall;
{$EXTERNALSYM MsiInstallProductW}
function MsiInstallProduct(szPackagePath, szCommandLine: PChar): UINT; stdcall;
{$EXTERNALSYM MsiInstallProduct}

// Install/uninstall an advertised or installed product
// No action if installed and INSTALLSTATE_DEFAULT specified

function MsiConfigureProductA(szProduct: PAnsiChar;	iInstallLevel: Integer;
	eInstallState: TInstallState): UINT; stdcall;
{$EXTERNALSYM MsiConfigureProductA}
function MsiConfigureProductW(szProduct: PWideChar;	iInstallLevel: Integer;
	eInstallState: TInstallState): UINT; stdcall;
{$EXTERNALSYM MsiConfigureProductW}
function MsiConfigureProduct(szProduct: PChar;	iInstallLevel: Integer;
	eInstallState: TInstallState): UINT; stdcall;
{$EXTERNALSYM MsiConfigureProduct}

// Install/uninstall an advertised or installed product
// No action if installed and INSTALLSTATE_DEFAULT specified

function MsiConfigureProductExA(szProduct: PAnsiChar; iInstallLevel: Integer;
  eInstallState: TInstallState; szCommandLine: PAnsiChar): UINT; stdcall;
{$EXTERNALSYM MsiConfigureProductExA}
function MsiConfigureProductExW(szProduct: PWideChar; iInstallLevel: Integer;
  eInstallState: TInstallState; szCommandLine: PWideChar): UINT; stdcall;
{$EXTERNALSYM MsiConfigureProductExW}
function MsiConfigureProductEx(szProduct: PChar; iInstallLevel: Integer;
  eInstallState: TInstallState; szCommandLine: PChar): UINT; stdcall;
{$EXTERNALSYM MsiConfigureProductEx}

// Reinstall product, used to validate or correct problems

function MsiReinstallProductA(szProduct: PAnsiChar;	szReinstallMode: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiReinstallProductA}
function MsiReinstallProductW(szProduct: PWideChar;	szReinstallMode: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiReinstallProductW}
function MsiReinstallProduct(szProduct: PChar;	szReinstallMode: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiReinstallProduct}

// Return the product code for a registered component, called once by apps

function MsiGetProductCodeA(szComponent: PAnsiChar;	lpBuf39: PAnsiChar): UINT; stdcall;
{$EXTERNALSYM MsiGetProductCodeA}
function MsiGetProductCodeW(szComponent: PWideChar;	lpBuf39: PWideChar): UINT; stdcall;
{$EXTERNALSYM MsiGetProductCodeW}
function MsiGetProductCode(szComponent: PChar;	lpBuf39: PChar): UINT; stdcall;
{$EXTERNALSYM MsiGetProductCode}

// Return the registered user information for an installed product

function MsiGetUserInfoA(szProduct: PAnsiChar; lpUserNameBuf: PAnsiChar;
	var pcchUserNameBuf: DWORD; lpOrgNameBuf: PAnsiChar;	var pcchOrgNameBuf: DWORD;
	lpSerialBuf: PAnsiChar; var pcchSerialBuf: DWORD): TUserInfoState; stdcall;
{$EXTERNALSYM MsiGetUserInfoA}
function MsiGetUserInfoW(szProduct: PWideChar; lpUserNameBuf: PAnsiChar;
	var pcchUserNameBuf: DWORD; lpOrgNameBuf: PWideChar;	var pcchOrgNameBuf: DWORD;
	lpSerialBuf: PWideChar; var pcchSerialBuf: DWORD): TUserInfoState; stdcall;
{$EXTERNALSYM MsiGetUserInfoW}
function MsiGetUserInfo(szProduct: PChar; lpUserNameBuf: PAnsiChar;
	var pcchUserNameBuf: DWORD; lpOrgNameBuf: PChar;	var pcchOrgNameBuf: DWORD;
	lpSerialBuf: PChar; var pcchSerialBuf: DWORD): TUserInfoState; stdcall;
{$EXTERNALSYM MsiGetUserInfo}

// Obtain and store user info and PID from installation wizard (first run)

function MsiCollectUserInfoA(szProduct: PAnsiChar): UINT; stdcall;
{$EXTERNALSYM MsiCollectUserInfoA}
function MsiCollectUserInfoW(szProduct: PWideChar): UINT; stdcall;
{$EXTERNALSYM MsiCollectUserInfoW}
function MsiCollectUserInfo(szProduct: PChar): UINT; stdcall;
{$EXTERNALSYM MsiCollectUserInfo}

// --------------------------------------------------------------------------
// Functions to patch existing products
// --------------------------------------------------------------------------

// Patch all possible installed products.

function MsiApplyPatchA(szPatchPackage, szInstallPackage: PAnsiChar;
  eInstallType: TInstallType; szCommandLine: PAnsiChar): UINT; stdcall;
{$EXTERNALSYM MsiApplyPatchA}
function MsiApplyPatchW(szPatchPackage, szInstallPackage: PWideChar;
  eInstallType: TInstallType; szCommandLine: PWideChar): UINT; stdcall;
{$EXTERNALSYM MsiApplyPatchW}
function MsiApplyPatch(szPatchPackage, szInstallPackage: PChar;
  eInstallType: TInstallType; szCommandLine: PChar): UINT; stdcall;
{$EXTERNALSYM MsiApplyPatch}

// Return patch info

function MsiGetPatchInfoA(szPatch, szAttribute: PAnsiChar; lpValueBuf: PAnsiChar;
  pcchValueBuf: PDWORD): UINT; stdcall;
{$EXTERNALSYM MsiGetPatchInfoA}
function MsiGetPatchInfoW(szPatch, szAttribute: PWideChar; lpValueBuf: PWideChar;
  pcchValueBuf: PDWORD): UINT; stdcall;
{$EXTERNALSYM MsiGetPatchInfoW}
function MsiGetPatchInfo(szPatch, szAttribute: PChar; lpValueBuf: PChar;
  pcchValueBuf: PDWORD): UINT; stdcall;
{$EXTERNALSYM MsiGetPatchInfo}

// Enumerate all patches for a product

function MsiEnumPatchesA(szProduct: PAnsiChar; iPatchIndex: DWORD; lpPatchBuf,
  lpTransformsBuf: PAnsiChar; var pcchTransformsBuf: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiEnumPatchesA}
function MsiEnumPatchesW(szProduct: PWideChar; iPatchIndex: DWORD; lpPatchBuf,
  lpTransformsBuf: PWideChar; var pcchTransformsBuf: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiEnumPatchesW}
function MsiEnumPatches(szProduct: PChar; iPatchIndex: DWORD; lpPatchBuf,
  lpTransformsBuf: PChar; var pcchTransformsBuf: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiEnumPatches}

// --------------------------------------------------------------------------
// Functions to query and configure a feature within a product.
// Separate wrapper functions are provided that accept a descriptor string.
// --------------------------------------------------------------------------

// Return the installed state for a product feature

function MsiQueryFeatureStateA(szProduct, szFeature: PAnsiChar): TInstallState; stdcall;
{$EXTERNALSYM MsiQueryFeatureStateA}
function MsiQueryFeatureStateW(szProduct, szFeature: PWideChar): TInstallState; stdcall;
{$EXTERNALSYM MsiQueryFeatureStateW}
function MsiQueryFeatureState(szProduct, szFeature: PChar): TInstallState; stdcall;
{$EXTERNALSYM MsiQueryFeatureState}

// Indicate intent to use a product feature, increments usage count
// Prompts for CD if not loaded, does not install feature

function MsiUseFeatureA(szProduct, szFeature: PAnsiChar): TInstallState; stdcall;
{$EXTERNALSYM MsiUseFeatureA}
function MsiUseFeatureW(szProduct, szFeature: PWideChar): TInstallState; stdcall;
{$EXTERNALSYM MsiUseFeatureW}
function MsiUseFeature(szProduct, szFeature: PChar): TInstallState; stdcall;
{$EXTERNALSYM MsiUseFeature}

// Indicate intent to use a product feature, increments usage count
// Prompts for CD if not loaded, does not install feature
// Allows for bypassing component detection where performance is critical

function MsiUseFeatureExA(szProduct, szFeature: PAnsiChar; dwInstallMode,
  dwReserved: DWORD): TInstallState; stdcall;
{$EXTERNALSYM MsiUseFeatureExA}
function MsiUseFeatureExW(szProduct, szFeature: PWideChar; dwInstallMode,
  dwReserved: DWORD): TInstallState; stdcall;
{$EXTERNALSYM MsiUseFeatureExW}
function MsiUseFeatureEx(szProduct, szFeature: PChar; dwInstallMode,
  dwReserved: DWORD): TInstallState; stdcall;
{$EXTERNALSYM MsiUseFeatureEx}

// Return the usage metrics for a product feature

function MsiGetFeatureUsageA(szProduct, szFeature: PAnsiChar;
  var pdwUseCount: DWORD; var pwDateUsed: WORD): UINT; stdcall;
{$EXTERNALSYM MsiGetFeatureUsageA}
function MsiGetFeatureUsageW(szProduct, szFeature: PWideChar;
  var pdwUseCount: DWORD; var pwDateUsed: WORD): UINT; stdcall;
{$EXTERNALSYM MsiGetFeatureUsageW}
function MsiGetFeatureUsage(szProduct, szFeature: PChar;
  var pdwUseCount: DWORD; var pwDateUsed: WORD): UINT; stdcall;
{$EXTERNALSYM MsiGetFeatureUsage}

// Force the installed state for a product feature

function MsiConfigureFeatureA(szProduct, szFeature: PAnsiChar;
  eInstallState: TInstallState): UINT; stdcall;
{$EXTERNALSYM MsiConfigureFeatureA}
function MsiConfigureFeatureW(szProduct, szFeature: PWideChar;
  eInstallState: TInstallState): UINT; stdcall;
{$EXTERNALSYM MsiConfigureFeatureW}
function MsiConfigureFeature(szProduct, szFeature: PChar;
  eInstallState: TInstallState): UINT; stdcall;
{$EXTERNALSYM MsiConfigureFeature}

// Reinstall feature, used to validate or correct problems

function MsiReinstallFeatureA(szProduct, szFeature: PAnsiChar;
  dwReinstallMode: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiReinstallFeatureA}
function MsiReinstallFeatureW(szProduct, szFeature: PAnsiChar;
  dwReinstallMode: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiReinstallFeatureW}
function MsiReinstallFeature(szProduct, szFeature: PAnsiChar;
  dwReinstallMode: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiReinstallFeature}

// --------------------------------------------------------------------------
// Functions to return a path to a particular component.
// The state of the feature being used should have been checked previously.
// --------------------------------------------------------------------------

// Return full component path, performing any necessary installation
// calls MsiQueryFeatureState to detect that all components are installed
// then calls MsiConfigureFeature if any of its components are uninstalled
// then calls MsiLocateComponent to obtain the path the its key file

function MsiProvideComponentA(szProduct, szFeature,	szComponent: PAnsiChar;
	dwInstallMode: DWORD; lpPathBuf: PAnsiChar;	pcchPathBuf: PDWORD): UINT; stdcall;
{$EXTERNALSYM MsiProvideComponentA}
function MsiProvideComponentW(szProduct, szFeature,	szComponent: PWideChar;
	dwInstallMode: DWORD; lpPathBuf: PWideChar;	pcchPathBuf: PDWORD): UINT; stdcall;
{$EXTERNALSYM MsiProvideComponentW}
function MsiProvideComponent(szProduct, szFeature,	szComponent: PChar;
	dwInstallMode: DWORD; lpPathBuf: PChar;	pcchPathBuf: PDWORD): UINT; stdcall;
{$EXTERNALSYM MsiProvideComponent}

// For an advertised component that registers descriptor strings,
// return full component path, performing any necessary installation.
// Calls MsiProvideComponent to install and return the path.

function MsiProvideQualifiedComponentA(szCategory, szQualifier: PAnsiChar;
	dwInstallMode: DWORD; lpPathBuf: PAnsiChar;	pcchPathBuf: PDWORD): UINT; stdcall
{$EXTERNALSYM MsiProvideQualifiedComponentA}
function MsiProvideQualifiedComponentW(szCategory, szQualifier: PWideChar;
	dwInstallMode: DWORD; lpPathBuf: PWideChar;	pcchPathBuf: PDWORD): UINT; stdcall
{$EXTERNALSYM MsiProvideQualifiedComponentW}
function MsiProvideQualifiedComponent(szCategory, szQualifier: PChar;
	dwInstallMode: DWORD; lpPathBuf: PChar;	pcchPathBuf: PDWORD): UINT; stdcall
{$EXTERNALSYM MsiProvideQualifiedComponent}

// For an advertised component that registers descriptor strings,
// return full component path, performing any necessary installation.
// If the szProduct is NULL the works same as MsiProvideQualifiedComponent, 
// else will look for the descriptor advertised by the particular product ONLY.
// Calls MsiProvideComponent to install and return the path.

function MsiProvideQualifiedComponentExA(szCategory, szQualifier: PAnsiChar;
  dwInstallMode: DWORD; szProduct: PAnsiChar; dwUnused1, dwUnused2: DWORD;
  lpPathBuf: PAnsiChar; pcchPathBuf: PDWORD): UINT; stdcall;
{$EXTERNALSYM MsiProvideQualifiedComponentExA}
function MsiProvideQualifiedComponentExW(szCategory, szQualifier: PWideChar;
  dwInstallMode: DWORD; szProduct: PWideChar; dwUnused1, dwUnused2: DWORD;
  lpPathBuf: PWideChar; pcchPathBuf: PDWORD): UINT; stdcall;
{$EXTERNALSYM MsiProvideQualifiedComponentExW}
function MsiProvideQualifiedComponentEx(szCategory, szQualifier: PChar;
  dwInstallMode: DWORD; szProduct: PChar; dwUnused1, dwUnused2: DWORD;
  lpPathBuf: PChar; pcchPathBuf: PDWORD): UINT; stdcall;
{$EXTERNALSYM MsiProvideQualifiedComponentEx}

// Return full path to an installed component

function MsiGetComponentPathA(szProduct, szComponent: PAnsiChar;
  lpPathBuf: PAnsiChar; pcchBuf: PDWORD): TInstallState; stdcall;
{$EXTERNALSYM MsiGetComponentPathA}
function MsiGetComponentPathW(szProduct, szComponent: PWideChar;
  lpPathBuf: PWideChar; pcchBuf: PDWORD): TInstallState; stdcall;
{$EXTERNALSYM MsiGetComponentPathW}
function MsiGetComponentPath(szProduct, szComponent: PChar;
  lpPathBuf: PChar; pcchBuf: PDWORD): TInstallState; stdcall;
{$EXTERNALSYM MsiGetComponentPath}

// --------------------------------------------------------------------------
// Functions to iterate registered products, features, and components.
// As with reg keys, they accept a 0-based index into the enumeration.
// --------------------------------------------------------------------------

// Enumerate the registered products, either installed or advertised

function MsiEnumProductsA(iProductIndex: DWORD;	lpProductBuf: PAnsiChar): UINT; stdcall;
{$EXTERNALSYM MsiEnumProductsA}
function MsiEnumProductsW(iProductIndex: DWORD;	lpProductBuf: PWideChar): UINT; stdcall;
{$EXTERNALSYM MsiEnumProductsW}
function MsiEnumProducts(iProductIndex: DWORD;	lpProductBuf: PChar): UINT; stdcall;
{$EXTERNALSYM MsiEnumProducts}

// Enumerate the advertised features for a given product.
// If parent is not required, supplying NULL will improve performance.

function MsiEnumFeaturesA(szProduct: PAnsiChar;	iFeatureIndex: DWORD;
	lpFeatureBuf,	lpParentBuf: PAnsiChar): UINT; stdcall;
{$EXTERNALSYM MsiEnumFeaturesA}
function MsiEnumFeaturesW(szProduct: PWideChar;	iFeatureIndex: DWORD;
	lpFeatureBuf,	lpParentBuf: PWideChar): UINT; stdcall;
{$EXTERNALSYM MsiEnumFeaturesW}
function MsiEnumFeatures(szProduct: PChar;	iFeatureIndex: DWORD;
	lpFeatureBuf,	lpParentBuf: PChar): UINT; stdcall;
{$EXTERNALSYM MsiEnumFeatures}

// Enumerate the installed components for all products

function MsiEnumComponentsA(iComponentIndex: DWORD;	lpComponentBuf: PAnsiChar): UINT; stdcall;
{$EXTERNALSYM MsiEnumComponentsA}
function MsiEnumComponentsW(iComponentIndex: DWORD;	lpComponentBuf: PWideChar): UINT; stdcall;
{$EXTERNALSYM MsiEnumComponentsW}
function MsiEnumComponents(iComponentIndex: DWORD;	lpComponentBuf: PChar): UINT; stdcall;
{$EXTERNALSYM MsiEnumComponents}

// Enumerate the client products for a component

function MsiEnumClientsA(szComponent: PAnsiChar; iProductIndex: DWORD;
  lpProductBuf: PAnsiChar): UINT; stdcall;
{$EXTERNALSYM MsiEnumClientsA}
function MsiEnumClientsW(szComponent: PWideChar; iProductIndex: DWORD;
  lpProductBuf: PWideChar): UINT; stdcall;
{$EXTERNALSYM MsiEnumClientsW}
function MsiEnumClients(szComponent: PChar; iProductIndex: DWORD;
  lpProductBuf: PChar): UINT; stdcall;
{$EXTERNALSYM MsiEnumClients}

// Enumerate the qualifiers for an advertised component.

function MsiEnumComponentQualifiersA(szComponent: PAnsiChar; iIndex: DWORD;
	lpQualifierBuf: PAnsiChar;	var pcchQualifierBuf: DWORD; lpApplicationDataBuf: PAnsiChar;
	pcchApplicationDataBuf: PDWORD): UINT; stdcall;
{$EXTERNALSYM MsiEnumComponentQualifiersA}
function MsiEnumComponentQualifiersW(szComponent: PWideChar; iIndex: DWORD;
	lpQualifierBuf: PWideChar;	var pcchQualifierBuf: DWORD; lpApplicationDataBuf: PWideChar;
	pcchApplicationDataBuf: PDWORD): UINT; stdcall;
{$EXTERNALSYM MsiEnumComponentQualifiersW}
function MsiEnumComponentQualifiers(szComponent: PChar; iIndex: DWORD;
	lpQualifierBuf: PChar;	var pcchQualifierBuf: DWORD; lpApplicationDataBuf: PChar;
	pcchApplicationDataBuf: PDWORD): UINT; stdcall;
{$EXTERNALSYM MsiEnumComponentQualifiers}

// --------------------------------------------------------------------------
// Functions to obtain product or package information.
// --------------------------------------------------------------------------

// Open the installation for a product to obtain detailed information

function MsiOpenProductA(szProduct: PAnsiChar; var hProduct: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiOpenProductA}
function MsiOpenProductW(szProduct: PWideChar; var hProduct: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiOpenProductW}
function MsiOpenProduct(szProduct: PChar; var hProduct: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiOpenProduct}

// Open a product package in order to access product properties

function MsiOpenPackageA(szPackagePath: PAnsiChar; var hProduct: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiOpenPackageA}
function MsiOpenPackageW(szPackagePath: PWideChar; var hProduct: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiOpenPackageW}
function MsiOpenPackage(szPackagePath: PChar; var hProduct: MSIHANDLE): UINT; stdcall;
{$EXTERNALSYM MsiOpenPackage}

// Provide the value for an installation property.

function MsiGetProductPropertyA(hProduct: MSIHANDLE; szProperty: PAnsiChar;
  lpValueBuf: PAnsiChar;	pcchValueBuf: PDWORD): UINT; stdcall;
{$EXTERNALSYM MsiGetProductPropertyA}
function MsiGetProductPropertyW(hProduct: MSIHANDLE; szProperty: PWideChar;
  lpValueBuf: PWideChar;	pcchValueBuf: PDWORD): UINT; stdcall;
{$EXTERNALSYM MsiGetProductPropertyW}
function MsiGetProductProperty(hProduct: MSIHANDLE; szProperty: PChar;
  lpValueBuf: PChar;	pcchValueBuf: PDWORD): UINT; stdcall;
{$EXTERNALSYM MsiGetProductProperty}

// Determine whether a file is a package
// Returns ERROR_SUCCESS if file is a package.

function MsiVerifyPackageA(szPackagePath: PAnsiChar): UINT; stdcall;
{$EXTERNALSYM MsiVerifyPackageA}
function MsiVerifyPackageW(szPackagePath: PWideChar): UINT; stdcall;
{$EXTERNALSYM MsiVerifyPackageW}
function MsiVerifyPackage(szPackagePath: PChar): UINT; stdcall;
{$EXTERNALSYM MsiVerifyPackage}

// Provide descriptive information for product feature: title and description.
// Returns the install level for the feature, or -1 if feature is unknown.
//   0 = feature is not available on this machine
//   1 = highest priority, feature installed if parent is installed
//  >1 = decreasing priority, feature installation based on InstallLevel property

function MsiGetFeatureInfoA(hProduct: MSIHANDLE; szFeature: PAnsiChar;
  var lpAttributes: DWORD; lpTitleBuf: PAnsiChar; var pcchTitleBuf: DWORD;
	lpHelpBuf: PAnsiChar; var pcchHelpBuf: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiGetFeatureInfoA}
function MsiGetFeatureInfoW(hProduct: MSIHANDLE; szFeature: PWideChar;
  var lpAttributes: DWORD; lpTitleBuf: PWideChar; var pcchTitleBuf: DWORD;
	lpHelpBuf: PWideChar; var pcchHelpBuf: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiGetFeatureInfoW}
function MsiGetFeatureInfo(hProduct: MSIHANDLE; szFeature: PChar;
  var lpAttributes: DWORD; lpTitleBuf: PChar; var pcchTitleBuf: DWORD;
	lpHelpBuf: PChar; var pcchHelpBuf: DWORD): UINT; stdcall;
{$EXTERNALSYM MsiGetFeatureInfo}

// --------------------------------------------------------------------------
// Functions to access or install missing components and files.
// These should be used as a last resort.
// --------------------------------------------------------------------------

// Install a component unexpectedly missing, provided only for error recovery
// This would typically occur due to failue to establish feature availability
// The product feature having the smallest incremental cost is installed

function MsiInstallMissingComponentA(szProduct, szComponent: PAnsiChar;
  eInstallState: TInstallState): UINT; stdcall;
{$EXTERNALSYM MsiInstallMissingComponentA}
function MsiInstallMissingComponentW(szProduct, szComponent: PWideChar;
  eInstallState: TInstallState): UINT; stdcall;
{$EXTERNALSYM MsiInstallMissingComponentW}
function MsiInstallMissingComponent(szProduct, szComponent: PChar;
  eInstallState: TInstallState): UINT; stdcall;
{$EXTERNALSYM MsiInstallMissingComponent}

// Install a file unexpectedly missing, provided only for error recovery
// This would typically occur due to failue to establish feature availability
// The missing component is determined from the product's File table, then
// the product feature having the smallest incremental cost is installed

function MsiInstallMissingFileA(szProduct, szFile: PAnsiChar): UINT; stdcall;
{$EXTERNALSYM MsiInstallMissingFileA}
function MsiInstallMissingFileW(szProduct, szFile: PWideChar): UINT; stdcall;
{$EXTERNALSYM MsiInstallMissingFileW}
function MsiInstallMissingFile(szProduct, szFile: PChar): UINT; stdcall;
{$EXTERNALSYM MsiInstallMissingFile}

// Return full path to an installed component without a product code
// This function attempts to determine the product using MsiGetProductCode
// but is not guaranteed to find the correct product for the caller.
// MsiGetComponentPath should always be called when possible.

function MsiLocateComponentA(szComponent: PAnsiChar; lpPathBuf: PAnsiChar;
  pcchBuf: PDWORD): TInstallState; stdcall;
{$EXTERNALSYM MsiLocateComponentA}
function MsiLocateComponentW(szComponent: PWideChar; lpPathBuf: PWideChar;
  pcchBuf: PDWORD): TInstallState; stdcall;
{$EXTERNALSYM MsiLocateComponentW}
function MsiLocateComponent(szComponent: PChar; lpPathBuf: PChar;
  pcchBuf: PDWORD): TInstallState; stdcall;
{$EXTERNALSYM MsiLocateComponent}

// --------------------------------------------------------------------------
// Utility functions
// --------------------------------------------------------------------------

// Give the version string and language for a specified file

function MsiGetFileVersionA(szFilePath: PAnsiChar; lpVersionBuf: PAnsiChar;
  pcchVersionBuf: PDWORD; lpLangBuf: PAnsiChar; pcchLangBuf: PDWORD): UINT; stdcall;
{$EXTERNALSYM MsiGetFileVersionA}
function MsiGetFileVersionW(szFilePath: PWideChar; lpVersionBuf: PWideChar;
  pcchVersionBuf: PDWORD; lpLangBuf: PWideChar; pcchLangBuf: PDWORD): UINT; stdcall;
{$EXTERNALSYM MsiGetFileVersionW}
function MsiGetFileVersion(szFilePath: PChar; lpVersionBuf: PChar;
  pcchVersionBuf: PDWORD; lpLangBuf: PChar; pcchLangBuf: PDWORD): UINT; stdcall;
{$EXTERNALSYM MsiGetFileVersion}

// --------------------------------------------------------------------------
// Error codes for installer access functions - until merged to winerr.h
// --------------------------------------------------------------------------

const
  ERROR_INSTALL_USEREXIT             = 1602; // User cancel installation.
  {$EXTERNALSYM ERROR_INSTALL_USEREXIT}
  ERROR_INSTALL_FAILURE              = 1603; // Fatal error during installation.
  {$EXTERNALSYM ERROR_INSTALL_FAILURE}
  ERROR_INSTALL_SUSPEND              = 1604; // Installation suspended, incomplete.
  {$EXTERNALSYM ERROR_INSTALL_SUSPEND}
  ERROR_UNKNOWN_PRODUCT              = 1605; // This action is only valid for products that are currently installed.
  {$EXTERNALSYM ERROR_UNKNOWN_PRODUCT}
  ERROR_UNKNOWN_FEATURE              = 1606; // Feature ID not registered.
  {$EXTERNALSYM ERROR_UNKNOWN_FEATURE}
  ERROR_UNKNOWN_COMPONENT            = 1607; // Component ID not registered.
  {$EXTERNALSYM ERROR_UNKNOWN_COMPONENT}
  ERROR_UNKNOWN_PROPERTY             = 1608; // Unknown property.
  {$EXTERNALSYM ERROR_UNKNOWN_PROPERTY}
  ERROR_INVALID_HANDLE_STATE         = 1609; // Handle is in an invalid state.
  {$EXTERNALSYM ERROR_INVALID_HANDLE_STATE}
  ERROR_BAD_CONFIGURATION            = 1610; // The configuration data for this product is corrupt.  Contact your support personnel.
  {$EXTERNALSYM ERROR_BAD_CONFIGURATION}
  ERROR_INDEX_ABSENT                 = 1611; // Component qualifier not present.
  {$EXTERNALSYM ERROR_INDEX_ABSENT}
  ERROR_INSTALL_SOURCE_ABSENT        = 1612; // The installation source for this product is not available.  Verify that the source exists and that you can access it.
  {$EXTERNALSYM ERROR_INSTALL_SOURCE_ABSENT}
  ERROR_PRODUCT_UNINSTALLED          = 1614; // Product is uninstalled.
  {$EXTERNALSYM ERROR_PRODUCT_UNINSTALLED}
  ERROR_BAD_QUERY_SYNTAX             = 1615; // SQL query syntax invalid or unsupported.
  {$EXTERNALSYM ERROR_BAD_QUERY_SYNTAX}
  ERROR_INVALID_FIELD                = 1616; // Record field does not exist.
  {$EXTERNALSYM ERROR_INVALID_FIELD}

  ERROR_INSTALL_SERVICE_FAILURE      = 1601; // The Windows Installer service could not be accessed.  Contact your support personnel to verify that the Windows Installer service is properly registered.
  {$EXTERNALSYM ERROR_INSTALL_SERVICE_FAILURE}
  ERROR_INSTALL_PACKAGE_VERSION      = 1613; // This installation package cannot be installed by the Windows Installer service.  You must install a Windows service pack that contains a newer version of the Windows Installer service.
  {$EXTERNALSYM ERROR_INSTALL_PACKAGE_VERSION}
  ERROR_INSTALL_ALREADY_RUNNING      = 1618; // Another installation is already in progress.  Complete that installation before proceeding with this install.
  {$EXTERNALSYM ERROR_INSTALL_ALREADY_RUNNING}
  ERROR_INSTALL_PACKAGE_OPEN_FAILED  = 1619; // This installation package could not be opened.  Verify that the package exists and that you can access it, or contact the application vendor to verify that this is a valid Windows Installer package.
  {$EXTERNALSYM ERROR_INSTALL_PACKAGE_OPEN_FAILED}
  ERROR_INSTALL_PACKAGE_INVALID      = 1620; // This installation package could not be opened.  Contact the application vendor to verify that this is a valid Windows Installer package.
  {$EXTERNALSYM ERROR_INSTALL_PACKAGE_INVALID}
  ERROR_INSTALL_UI_FAILURE           = 1621; // There was an error starting the Windows Installer service user interface.  Contact your support personnel.
  {$EXTERNALSYM ERROR_INSTALL_UI_FAILURE}
  ERROR_INSTALL_LOG_FAILURE          = 1622; // Error opening installation log file.  Verify that the specified log file location exists and is writable.
  {$EXTERNALSYM ERROR_INSTALL_LOG_FAILURE}
  ERROR_INSTALL_LANGUAGE_UNSUPPORTED = 1623; // This language of this installation package is not supported by your system.
  {$EXTERNALSYM ERROR_INSTALL_LANGUAGE_UNSUPPORTED}
  ERROR_INSTALL_PACKAGE_REJECTED     = 1625; // This installation is forbidden by system policy.  Contact your system administrator.
  {$EXTERNALSYM ERROR_INSTALL_PACKAGE_REJECTED}

  ERROR_FUNCTION_NOT_CALLED          = 1626; // Function could not be executed.
  {$EXTERNALSYM ERROR_FUNCTION_NOT_CALLED}
  ERROR_FUNCTION_FAILED              = 1627; // Function failed during execution.
  {$EXTERNALSYM ERROR_FUNCTION_FAILED}
  ERROR_INVALID_TABLE                = 1628; // Invalid or unknown table specified.
  {$EXTERNALSYM ERROR_INVALID_TABLE}
  ERROR_DATATYPE_MISMATCH            = 1629; // Data supplied is of wrong type.
  {$EXTERNALSYM ERROR_DATATYPE_MISMATCH}
  ERROR_UNSUPPORTED_TYPE             = 1630; // Data of this type is not supported.
  {$EXTERNALSYM ERROR_UNSUPPORTED_TYPE}
  ERROR_CREATE_FAILED                = 1631; // The Windows Installer service failed to start.  Contact your support personnel.
  {$EXTERNALSYM ERROR_CREATE_FAILED}

  ERROR_INSTALL_TEMP_UNWRITABLE      = 1632; // The temp folder is either full or inaccessible.  Verify that the temp folder exists and that you can write to it.
  {$EXTERNALSYM ERROR_INSTALL_TEMP_UNWRITABLE}
  ERROR_INSTALL_PLATFORM_UNSUPPORTED = 1633; // This installation package is not supported on this platform.  Contact your application vendor.
  {$EXTERNALSYM ERROR_INSTALL_PLATFORM_UNSUPPORTED}
  ERROR_INSTALL_NOTUSED              = 1634; // Component not used on this machine
  {$EXTERNALSYM ERROR_INSTALL_NOTUSED}
  ERROR_INSTALL_TRANSFORM_FAILURE    = 1624; // Error applying transforms.  Verify that the specified transform paths are valid.
  {$EXTERNALSYM ERROR_INSTALL_TRANSFORM_FAILURE}

  ERROR_PATCH_PACKAGE_OPEN_FAILED    = 1635; // This patch package could not be opened.  Verify that the patch package exists and that you can access it, or contact the application vendor to verify that this is a valid Windows Installer patch package.
  {$EXTERNALSYM ERROR_PATCH_PACKAGE_OPEN_FAILED}
  ERROR_PATCH_PACKAGE_INVALID        = 1636; // This patch package could not be opened.  Contact the application vendor to verify that this is a valid Windows Installer patch package.
  {$EXTERNALSYM ERROR_PATCH_PACKAGE_INVALID}
  ERROR_PATCH_PACKAGE_UNSUPPORTED    = 1637; // This patch package cannot be processed by the Windows Installer service.  You must install a Windows service pack that contains a newer version of the Windows Installer service.
  {$EXTERNALSYM ERROR_PATCH_PACKAGE_UNSUPPORTED}

  ERROR_PRODUCT_VERSION              = 1638; // Another version of this product is already installed.  Installation of this version cannot continue.  To configure or remove the existing version of this product, use Add/Remove Programs on the Control Panel.
  {$EXTERNALSYM ERROR_PRODUCT_VERSION}

  ERROR_INVALID_COMMAND_LINE         = 1639; // Invalid command line argument.  Consult the Windows Installer SDK for detailed command line help.
  {$EXTERNALSYM ERROR_INVALID_COMMAND_LINE}

implementation

const
  MsiLib = 'msi.dll';

// --------------------------------------------------------------------------
// Installer generic handle definitions
// --------------------------------------------------------------------------

function MsiCloseHandle; external MsiLib name 'MsiCloseHandle';
function MsiCloseAllHandles; external MsiLib name 'MsiCloseAllHandles';

// --------------------------------------------------------------------------
// Functions to set the UI handling and logging. The UI will be used for error,
// progress, and log messages for all subsequent calls to Installer Service
// API functions that require UI.
// --------------------------------------------------------------------------

function MsiSetInternalUI; external MsiLib name 'MsiSetInternalUI';
function MsiSetexternalUIA; external MsiLib name 'MsiSetexternal MsiLibUIA';
function MsiSetexternalUIW; external MsiLib name 'MsiSetexternal MsiLibUIW';
function MsiSetexternalUI; external MsiLib name 'MsiSetexternal MsiLibUIA';
function MsiEnableLogA; external MsiLib name 'MsiEnableLogA';
function MsiEnableLogW; external MsiLib name 'MsiEnableLogW';
function MsiEnableLog; external MsiLib name 'MsiEnableLogA';
function MsiQueryProductStateA; external MsiLib name 'MsiQueryProductStateA';
function MsiQueryProductStateW; external MsiLib name 'MsiQueryProductStateW';
function MsiQueryProductState; external MsiLib name 'MsiQueryProductStateA';
function MsiGetProductInfoA; external MsiLib name 'MsiGetProductInfoA';
function MsiGetProductInfoW; external MsiLib name 'MsiGetProductInfoW';
function MsiGetProductInfo; external MsiLib name 'MsiGetProductInfoA';
function MsiInstallProductA; external MsiLib name 'MsiInstallProductA';
function MsiInstallProductW; external MsiLib name 'MsiInstallProductW';
function MsiInstallProduct; external MsiLib name 'MsiInstallProductA';
function MsiConfigureProductA; external MsiLib name 'MsiConfigureProductA';
function MsiConfigureProductW; external MsiLib name 'MsiConfigureProductW';
function MsiConfigureProduct; external MsiLib name 'MsiConfigureProductA';
function MsiConfigureProductExA; external MsiLib name 'MsiConfigureProductExA';
function MsiConfigureProductExW; external MsiLib name 'MsiConfigureProductExW';
function MsiConfigureProductEx; external MsiLib name 'MsiConfigureProductExA';
function MsiReinstallProductA; external MsiLib name 'MsiReinstallProductA';
function MsiReinstallProductW; external MsiLib name 'MsiReinstallProductW';
function MsiReinstallProduct; external MsiLib name 'MsiReinstallProductA';
function MsiGetProductCodeA; external MsiLib name 'MsiGetProductCodeA';
function MsiGetProductCodeW; external MsiLib name 'MsiGetProductCodeW';
function MsiGetProductCode; external MsiLib name 'MsiGetProductCodeA';
function MsiGetUserInfoA; external MsiLib name 'MsiGetUserInfoA';
function MsiGetUserInfoW; external MsiLib name 'MsiGetUserInfoW';
function MsiGetUserInfo; external MsiLib name 'MsiGetUserInfoA';
function MsiCollectUserInfoA; external MsiLib name 'MsiCollectUserInfoA';
function MsiCollectUserInfoW; external MsiLib name 'MsiCollectUserInfoW';
function MsiCollectUserInfo; external MsiLib name 'MsiCollectUserInfoA';

// --------------------------------------------------------------------------
// Functions to patch existing products
// --------------------------------------------------------------------------

function MsiApplyPatchA; external MsiLib name 'MsiApplyPatchA';
function MsiApplyPatchW; external MsiLib name 'MsiApplyPatchW';
function MsiApplyPatch; external MsiLib name 'MsiApplyPatchA';
function MsiGetPatchInfoA; external MsiLib name 'MsiGetPatchInfoA';
function MsiGetPatchInfoW; external MsiLib name 'MsiGetPatchInfoW';
function MsiGetPatchInfo; external MsiLib name 'MsiGetPatchInfoA';
function MsiEnumPatchesA; external MsiLib name 'MsiEnumPatchesA';
function MsiEnumPatchesW; external MsiLib name 'MsiEnumPatchesW';
function MsiEnumPatches; external MsiLib name 'MsiEnumPatchesA';

// --------------------------------------------------------------------------
// Functions to query and configure a feature within a product.
// Separate wrapper functions are provided that accept a descriptor string.
// --------------------------------------------------------------------------

function MsiQueryFeatureStateA; external MsiLib name 'MsiQueryFeatureStateA';
function MsiQueryFeatureStateW; external MsiLib name 'MsiQueryFeatureStateW';
function MsiQueryFeatureState; external MsiLib name 'MsiQueryFeatureStateA';
function MsiUseFeatureA; external MsiLib name 'MsiUseFeatureA';
function MsiUseFeatureW; external MsiLib name 'MsiUseFeatureW';
function MsiUseFeature; external MsiLib name 'MsiUseFeatureA';
function MsiUseFeatureExA; external MsiLib name 'MsiUseFeatureExA';
function MsiUseFeatureExW; external MsiLib name 'MsiUseFeatureExW';
function MsiUseFeatureEx; external MsiLib name 'MsiUseFeatureExA';
function MsiGetFeatureUsageA; external MsiLib name 'MsiGetFeatureUsageA';
function MsiGetFeatureUsageW; external MsiLib name 'MsiGetFeatureUsageW';
function MsiGetFeatureUsage; external MsiLib name 'MsiGetFeatureUsageA';
function MsiConfigureFeatureA; external MsiLib name 'MsiConfigureFeatureA';
function MsiConfigureFeatureW; external MsiLib name 'MsiConfigureFeatureW';
function MsiConfigureFeature; external MsiLib name 'MsiConfigureFeatureA';
function MsiReinstallFeatureA; external MsiLib name 'MsiReinstallFeatureA';
function MsiReinstallFeatureW; external MsiLib name 'MsiReinstallFeatureW';
function MsiReinstallFeature; external MsiLib name 'MsiReinstallFeatureA';

// --------------------------------------------------------------------------
// Functions to return a path to a particular component.
// The state of the feature being used should have been checked previously.
// --------------------------------------------------------------------------

function MsiProvideComponentA; external MsiLib name 'MsiProvideComponentA';
function MsiProvideComponentW; external MsiLib name 'MsiProvideComponentW';
function MsiProvideComponent; external MsiLib name 'MsiProvideComponentA';
function MsiProvideQualifiedComponentA; external MsiLib name 'MsiProvideQualifiedComponentA';
function MsiProvideQualifiedComponentW; external MsiLib name 'MsiProvideQualifiedComponentW';
function MsiProvideQualifiedComponent; external MsiLib name 'MsiProvideQualifiedComponentA';
function MsiProvideQualifiedComponentExA; external MsiLib name 'MsiProvideQualifiedComponentExA';
function MsiProvideQualifiedComponentExW; external MsiLib name 'MsiProvideQualifiedComponentExW';
function MsiProvideQualifiedComponentEx; external MsiLib name 'MsiProvideQualifiedComponentExA';
function MsiGetComponentPathA; external MsiLib name 'MsiGetComponentPathA';
function MsiGetComponentPathW; external MsiLib name 'MsiGetComponentPathW';
function MsiGetComponentPath; external MsiLib name 'MsiGetComponentPathA';

// --------------------------------------------------------------------------
// Functions to iterate registered products, features, and components.
// As with reg keys, they accept a 0-based index into the enumeration.
// --------------------------------------------------------------------------

function MsiEnumProductsA; external MsiLib name 'MsiEnumProductsA';
function MsiEnumProductsW; external MsiLib name 'MsiEnumProductsW';
function MsiEnumProducts; external MsiLib name 'MsiEnumProductsA';
function MsiEnumFeaturesA; external MsiLib name 'MsiEnumFeaturesA';
function MsiEnumFeaturesW; external MsiLib name 'MsiEnumFeaturesW';
function MsiEnumFeatures; external MsiLib name 'MsiEnumFeaturesA';
function MsiEnumComponentsA; external MsiLib name 'MsiEnumComponentsA';
function MsiEnumComponentsW; external MsiLib name 'MsiEnumComponentsW';
function MsiEnumComponents; external MsiLib name 'MsiEnumComponentsA';
function MsiEnumClientsA; external MsiLib name 'MsiEnumClientsA';
function MsiEnumClientsW; external MsiLib name 'MsiEnumClientsW';
function MsiEnumClients; external MsiLib name 'MsiEnumClientsA';
function MsiEnumComponentQualifiersA; external MsiLib name 'MsiEnumComponentQualifiersA';
function MsiEnumComponentQualifiersW; external MsiLib name 'MsiEnumComponentQualifiersW';
function MsiEnumComponentQualifiers; external MsiLib name 'MsiEnumComponentQualifiersA';

// --------------------------------------------------------------------------
// Functions to obtain product or package information.
// --------------------------------------------------------------------------

function MsiOpenProductA; external MsiLib name 'MsiOpenProductA';
function MsiOpenProductW; external MsiLib name 'MsiOpenProductW';
function MsiOpenProduct; external MsiLib name 'MsiOpenProductA';
function MsiOpenPackageA; external MsiLib name 'MsiOpenPackageA';
function MsiOpenPackageW; external MsiLib name 'MsiOpenPackageW';
function MsiOpenPackage; external MsiLib name 'MsiOpenPackageA';
function MsiGetProductPropertyA; external MsiLib name 'MsiGetProductPropertyA';
function MsiGetProductPropertyW; external MsiLib name 'MsiGetProductPropertyW';
function MsiGetProductProperty; external MsiLib name 'MsiGetProductPropertyA';
function MsiVerifyPackageA; external MsiLib name 'MsiVerifyPackageA';
function MsiVerifyPackageW; external MsiLib name 'MsiVerifyPackageW';
function MsiVerifyPackage; external MsiLib name 'MsiVerifyPackageA';
function MsiGetFeatureInfoA; external MsiLib name 'MsiGetFeatureInfoA';
function MsiGetFeatureInfoW; external MsiLib name 'MsiGetFeatureInfoW';
function MsiGetFeatureInfo; external MsiLib name 'MsiGetFeatureInfoA';

// --------------------------------------------------------------------------
// Functions to access or install missing components and files.
// These should be used as a last resort.
// --------------------------------------------------------------------------

function MsiInstallMissingComponentA; external MsiLib name 'MsiInstallMissingComponentA';
function MsiInstallMissingComponentW; external MsiLib name 'MsiInstallMissingComponentW';
function MsiInstallMissingComponent; external MsiLib name 'MsiInstallMissingComponentA';
function MsiInstallMissingFileA; external MsiLib name 'MsiInstallMissingFileA';
function MsiInstallMissingFileW; external MsiLib name 'MsiInstallMissingFileW';
function MsiInstallMissingFile; external MsiLib name 'MsiInstallMissingFileA';
function MsiLocateComponentA; external MsiLib name 'MsiLocateComponentA';
function MsiLocateComponentW; external MsiLib name 'MsiLocateComponentW';
function MsiLocateComponent; external MsiLib name 'MsiLocateComponentA';

// --------------------------------------------------------------------------
// Utility functions
// --------------------------------------------------------------------------

function MsiGetFileVersionA; external MsiLib name 'MsiGetFileVersionA';
function MsiGetFileVersionW; external MsiLib name 'MsiGetFileVersionW';
function MsiGetFileVersion; external MsiLib name 'MsiGetFileVersionA';

end.
