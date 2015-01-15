unit MsiDefs;
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
{$HPPEMIT '#include "msidefs.h"'}
{$HPPEMIT ''}

//--------------------------------------------------------------------------
// INSTALLER PROPERTY DEFINITIONS
//--------------------------------------------------------------------------

const

// Required properties: set in Property table

  IPROPNAME_PRODUCTNAME            = 'ProductName';        // name registered for display
  IPROPNAME_PRODUCTCODE            = 'ProductCode';        // unique string GUID for product
  IPROPNAME_PRODUCTVERSION         = 'ProductVersion';     // string product version
  IPROPNAME_INSTALLLANGUAGE        = 'ProductLanguage';    // install language of product, use to load resources
  IPROPNAME_MANUFACTURER           = 'Manufacturer';       // name of manufacturer

// Customization properties: set in Property table

  IPROPNAME_UPGRADECODE            = 'UpgradeCode';        // unique string GUID for product family
  IPROPNAME_PIDTEMPLATE            = 'PIDTemplate';        // drives Product ID processing
  IPROPNAME_DISKPROMPT             = 'DiskPrompt';         // prompt for CD
  IPROPNAME_LEFTUNIT               = 'LeftUnit';           // name of unit placed to left of number instead of right
  IPROPNAME_ADMIN_PROPERTIES       = 'AdminProperties';    // properties to stuff in admin package
  IPROPNAME_DEFAULTUIFONT          = 'DefaultUIFont';      // the font used in the UI if no other font is specified
  IPROPNAME_ALLOWEDPROPERTIES      = 'SecureCustomProperties';
  IPROPNAME_ENABLEUSERCONTROL      = 'EnableUserControl';  // allows user to specify any public property

// Customization properties: set on command-line or in Property table

  IPROPNAME_USERNAME               = 'USERNAME';
  IPROPNAME_COMPANYNAME            = 'COMPANYNAME';
  IPROPNAME_PIDKEY                 = 'PIDKEY';             // used with PIDTemplate to form ProductID
  IPROPNAME_PATCH                  = 'PATCH';              // patch package to apply - SET BY INSTALLER
  IPROPNAME_TARGETDIR              = 'TARGETDIR';          // target location - defaults to ROOTDRIVE
  IPROPNAME_ACTION                 = 'ACTION';             // top-level action to perform - default to INSTALL
  IPROPNAME_LIMITUI                = 'LIMITUI';            // limit ui level to Basic
  IPROPNAME_LOGACTION              = 'LOGACTION';          // log only these actions
  IPROPNAME_ALLUSERS               = 'ALLUSERS';           // install for all users
  IPROPNAME_INSTALLLEVEL           = 'INSTALLLEVEL';
  IPROPNAME_REBOOT                 = 'REBOOT';             // force or suppress reboot
  IPROPNAME_EXECUTEMODE            = 'EXECUTEMODE';        // NONE or SCRIPT
  IPROPVALUE_EXECUTEMODE_NONE      = 'NONE';               // do not update system
  IPROPVALUE_EXECUTEMODE_SCRIPT    = 'SCRIPT';             // default - run script to update system
  IPROPNAME_EXECUTEACTION          = 'EXECUTEACTION';      // run action on server side
  IPROPNAME_SOURCELIST             = 'SOURCELIST';
  IPROPNAME_ROOTDRIVE              = 'ROOTDRIVE';          // default drive to install - SET BY INSTALLER
  IPROPNAME_TRANSFORMS             = 'TRANSFORMS';         // transforms to apply
  IPROPNAME_TRANSFORMSATSOURCE     = 'TRANSFORMSATSOURCE'; // transforms can be found at source
  IPROPNAME_TRANSFORMSSECURE       = 'TRANSFORMSSECURE';   // file transforms are secured
  IPROPNAME_SEQUENCE               = 'SEQUENCE';           // sequence table to run with SEQUENCE action
  IPROPNAME_SHORTFILENAMES         = 'SHORTFILENAMES';     // force short file names
  IPROPNAME_PRIMARYFOLDER          = 'PRIMARYFOLDER';	     // Folder on the volume the author wants costing info for
  IPROPNAME_AFTERREBOOT            = 'AFTERREBOOT';        // install is after a ForceReboot triggered reboot
  IPROPNAME_NOCOMPANYNAME          = 'NOCOMPANYNAME';
  IPROPNAME_NOUSERNAME             = 'NOUSERNAME';
  IPROPNAME_DISABLEROLLBACK        = 'DISABLEROLLBACK';    // disable rollback for this install
  IPROPNAME_AVAILABLEFREEREG       = 'AVAILABLEFREEREG';   // set up the free space in the registry before commencing the install
  IPROPNAME_DISABLEADVTSHORTCUTS   = 'DISABLEADVTSHORTCUTS'; // disable creating darwin shortcuts even if supported
  IPROPNAME_PATCHNEWPACKAGECODE    = 'PATCHNEWPACKAGECODE';  // added to property table by patch transforms - used to update
																						               // PackageCode of admin packages when patching admin installs
  IPROPNAME_PATCHNEWSUMMARYSUBJECT = 'PATCHNEWSUMMARYSUBJECT'; // added to property table by patch transforms - used to update
																								           // Subject summary info property of admin packages when patching admin installs
  IPROPNAME_PATCHNEWSUMMARYCOMMENTS = 'PATCHNEWSUMMARYCOMMENTS'; // added to property table by patch transforms - used to update
																								           // Comments summary info property of admin packages when patching admin installs
  IPROPNAME_PRODUCTLANGUAGE        = 'PRODUCTLANGUAGE';    // requested language, must be one in summary information list, selects language transform

// Properties used to populate Add/Remove Control Panel values

  IPROPNAME_ARPAUTHORIZEDCDFPREFIX = 'ARPAUTHORIZEDCDFPREFIX';
  IPROPNAME_ARPCOMMENTS            = 'ARPCOMMENTS';
  IPROPNAME_ARPCONTACT             = 'ARPCONTACT';
  IPROPNAME_ARPHELPLINK            = 'ARPHELPLINK';
  IPROPNAME_ARPHELPTELEPHONE       = 'ARPHELPTELEPHONE';
  IPROPNAME_ARPINSTALLLOCATION     = 'ARPINSTALLLOCATION';
  IPROPNAME_ARPNOMODIFY            = 'ARPNOMODIFY';
  IPROPNAME_ARPNOREMOVE            = 'ARPNOREMOVE';
  IPROPNAME_ARPNOREPAIR            = 'ARPNOREPAIR';
  IPROPNAME_ARPREADME              = 'ARPREADME';
  IPROPNAME_ARPSIZE                = 'ARPSIZE';
  IPROPNAME_ARPSYSTEMCOMPONENT     = 'ARPSYSTEMCOMPONENT';
  IPROPNAME_ARPURLINFOABOUT        = 'ARPURLINFOABOUT';
  IPROPNAME_ARPURLUPDATEINFO       = 'ARPURLUPDATEINFO';

// Dynamic properties set by installer during install

  IPROPNAME_INSTALLED              = 'Installed';          // product already installed
  IPROPNAME_PRODUCTSTATE           = 'ProductState';       // state of product (installed,advertised,etc...)
  IPROPNAME_PRESELECTED            = 'Preselected';        // selections made on command line
  IPROPNAME_RESUME                 = 'RESUME';             // resuming suspended install
  IPROPNAME_UPDATESTARTED          = 'UpdateStarted';      // have begun to update system
  IPROPNAME_PRODUCTID              = 'ProductID';          // the complete validated Product ID
  IPROPNAME_OUTOFDISKSPACE         = 'OutOfDiskSpace';
  IPROPNAME_OUTOFNORBDISKSPACE     = 'OutOfNoRbDiskSpace';
  IPROPNAME_COSTINGCOMPLETE        = 'CostingComplete';
  IPROPNAME_SOURCEDIR              = 'SourceDir';          // source location - SET BY INSTALLER
  IPROPNAME_REPLACEDINUSEFILES     = 'ReplacedInUseFiles'; // need reboot to completely install one or more files
  IPROPNAME_PRIMARYFOLDER_PATH     = 'PrimaryVolumePath';
  IPROPNAME_PRIMARYFOLDER_SPACEAVAILABLE = 'PrimaryVolumeSpaceAvailable';
  IPROPNAME_PRIMARYFOLDER_SPACEREQUIRED  = 'PrimaryVolumeSpaceRequired';
  IPROPNAME_PRIMARYFOLDER_SPACEREMAINING = 'PrimaryVolumeSpaceRemaining';
  IPROPNAME_ISADMINPACKAGE         = 'IsAdminPackage';
  IPROPNAME_ROLLBACKDISABLED       = 'RollbackDisabled';
  IPROPNAME_RESTRICTEDUSERCONTROL  = 'RestrictedUserControl';

// Dynamic properties evaluated upon use

  IPROPNAME_TIME                   = 'Time';
  IPROPNAME_DATE                   = 'Date';
  IPROPNAME_DATETIME               = 'DateTime';

// Hardware properties: set by installer at initialization

  IPROPNAME_INTEL                  = 'Intel';
  IPROPNAME_ALPHA                  = 'Alpha';
  IPROPNAME_TEXTHEIGHT             = 'TextHeight';
  IPROPNAME_SCREENX                = 'ScreenX';
  IPROPNAME_SCREENY                = 'ScreenY';
  IPROPNAME_CAPTIONHEIGHT          = 'CaptionHeight';
  IPROPNAME_BORDERTOP              = 'BorderTop';
  IPROPNAME_BORDERSIDE             = 'BorderSide';
  IPROPNAME_COLORBITS              = 'ColorBits';
  IPROPNAME_PHYSICALMEMORY         = 'PhysicalMemory';
  IPROPNAME_VIRTUALMEMORY          = 'VirtualMemory';

// Operating System properties: set by installer at initialization

  IPROPNAME_VERSIONNT              = 'VersionNT';
  IPROPNAME_VERSION9X              = 'Version9X';
  IPROPNAME_WINDOWSBUILD           = 'WindowsBuild';
  IPROPNAME_SERVICEPACKLEVEL       = 'ServicePackLevel';
  IPROPNAME_SHAREDWINDOWS          = 'SharedWindows';
  IPROPNAME_COMPUTERNAME           = 'ComputerName';
  IPROPNAME_SHELLADVTSUPPORT       = 'ShellAdvtSupport';
  IPROPNAME_OLEADVTSUPPORT         = 'OLEAdvtSupport';
  IPROPNAME_SYSTEMLANGUAGEID       = 'SystemLanguageID';
  IPROPNAME_TTCSUPPORT             = 'TTCSupport';
  IPROPNAME_TERMSERVER		         = 'TerminalServer';

// User properties: set by installer at initialization

  IPROPNAME_LOGONUSER              = 'LogonUser';
  IPROPNAME_USERSID                = 'UserSID';
  IPROPNAME_ADMINUSER              = 'AdminUser';
  IPROPNAME_USERLANGUAGEID         = 'UserLanguageID';
  IPROPNAME_PRIVILEGED             = 'Privileged';

// System folder properties: set by installer at initialization

  IPROPNAME_WINDOWS_FOLDER         = 'WindowsFolder';
  IPROPNAME_SYSTEM_FOLDER          = 'SystemFolder';
  IPROPNAME_SYSTEM16_FOLDER        = 'System16Folder';
  IPROPNAME_WINDOWS_VOLUME         = 'WindowsVolume';
  IPROPNAME_TEMP_FOLDER            = 'TempFolder';
  IPROPNAME_PROGRAMFILES_FOLDER    = 'ProgramFilesFolder';
  IPROPNAME_COMMONFILES_FOLDER     = 'CommonFilesFolder';
  IPROPNAME_STARTMENU_FOLDER       = 'StartMenuFolder';
  IPROPNAME_PROGRAMMENU_FOLDER     = 'ProgramMenuFolder';
  IPROPNAME_STARTUP_FOLDER         = 'StartupFolder';
  IPROPNAME_NETHOOD_FOLDER         = 'NetHoodFolder';
  IPROPNAME_PERSONAL_FOLDER        = 'PersonalFolder';
  IPROPNAME_SENDTO_FOLDER          = 'SendToFolder';
  IPROPNAME_DESKTOP_FOLDER         = 'DesktopFolder';
  IPROPNAME_TEMPLATE_FOLDER        = 'TemplateFolder';
  IPROPNAME_FONTS_FOLDER           = 'FontsFolder';
  IPROPNAME_FAVORITES_FOLDER       = 'FavoritesFolder';
  IPROPNAME_RECENT_FOLDER          = 'RecentFolder';
  IPROPNAME_APPDATA_FOLDER         = 'AppDataFolder';
  IPROPNAME_PRINTHOOD_FOLDER       = 'PrintHoodFolder';

// Feature/Component installation properties: set on command-line

  IPROPNAME_FEATUREADDLOCAL        = 'ADDLOCAL';
  IPROPNAME_FEATUREADDSOURCE       = 'ADDSOURCE';
  IPROPNAME_FEATUREADDDEFAULT      = 'ADDDEFAULT';
  IPROPNAME_FEATUREREMOVE          = 'REMOVE';
  IPROPNAME_FEATUREADVERTISE       = 'ADVERTISE';
  IPROPVALUE_FEATURE_ALL           = 'ALL';

  IPROPNAME_COMPONENTADDLOCAL      = 'COMPADDLOCAL';
  IPROPNAME_COMPONENTADDSOURCE     = 'COMPADDSOURCE';
  IPROPNAME_COMPONENTADDDEFAULT    = 'COMPADDDEFAULT';

  IPROPNAME_FILEADDLOCAL           = 'FILEADDLOCAL';
  IPROPNAME_FILEADDSOURCE          = 'FILEADDSOURCE';
  IPROPNAME_FILEADDDEFAULT         = 'FILEADDDEFAULT';

  IPROPNAME_REINSTALL              = 'REINSTALL';
  IPROPNAME_REINSTALLMODE          = 'REINSTALLMODE';
  IPROPNAME_PROMPTROLLBACKCOST     = 'PROMPTROLLBACKCOST';
  IPROPVALUE_RBCOST_PROMPT         = 'P';
  IPROPVALUE_RBCOST_SILENT         = 'D';
  IPROPVALUE_RBCOST_FAIL           = 'F';

//--------------------------------------------------------------------------
// TOP-LEVEL ACTION NAMES
//--------------------------------------------------------------------------

  IACTIONNAME_INSTALL              = 'INSTALL';
  IACTIONNAME_ADVERTISE            = 'ADVERTISE';
  IACTIONNAME_ADMIN                = 'ADMIN';
  IACTIONNAME_SEQUENCE             = 'SEQUENCE';
  IACTIONNAME_COLLECTUSERINFO      = 'CollectUserInfo';
  IACTIONNAME_FIRSTRUN             = 'FirstRun';

//--------------------------------------------------------------------------
//  SummaryInformation property stream property IDs
//--------------------------------------------------------------------------

// #undef PID_SECURITY // defined as ( 0x80000002 ) in objidl.h, need to redefine here

// standard property definitions, from OLE2 documentation

  PID_DICTIONARY   = 0;   // integer count + array of entries
  PID_CODEPAGE     = 1;   // short integer
  PID_TITLE        = 2;   // string
  PID_SUBJECT      = 3;   // string
  PID_AUTHOR       = 4;   // string
  PID_KEYWORDS     = 5;   // string
  PID_COMMENTS     = 6;   // string
  PID_TEMPLATE     = 7;   // string
  PID_LASTAUTHOR   = 8;   // string
  PID_REVNUMBER    = 9;   // string
  PID_EDITTIME     = 10;  // datatime
  PID_LASTPRINTED  = 11;  // datetime
  PID_CREATE_DTM   = 12;  // datetime
  PID_LASTSAVE_DTM = 13;  // datetime
  PID_PAGECOUNT    = 14;  // integer
  PID_WORDCOUNT    = 15;  // integer
  PID_CHARCOUNT    = 16;  // integer
  PID_THUMBNAIL    = 17;  // clipboard format + metafile/bitmap (not supported)
  PID_APPNAME      = 18;  // string
  PID_SECURITY     = 19;  // integer

// PIDs given specific meanings for Installer

  PID_MSIVERSION   = PID_PAGECOUNT;  // integer, Installer version number (major*100+minor)
  PID_MSISOURCE    = PID_WORDCOUNT;  // integer, type of file image, short/long, media/tree
  PID_MSIRESTRICT  = PID_CHARCOUNT;  // integer, transform restrictions

//--------------------------------------------------------------------------
// INSTALLER DATABASE INTEGER COLUMN DEFINITIONS
//--------------------------------------------------------------------------

// BBControl.Attributes
// Control.Attributes

// enum msidbControlAttributes {
	msidbControlAttributesVisible           = $00000001;
	msidbControlAttributesEnabled           = $00000002;
	msidbControlAttributesSunken            = $00000004;
	msidbControlAttributesIndirect          = $00000008;
	msidbControlAttributesInteger           = $00000010;
	msidbControlAttributesRTLRO             = $00000020;
	msidbControlAttributesRightAligned      = $00000040;
	msidbControlAttributesLeftScroll        = $00000080;
	msidbControlAttributesBiDi              = msidbControlAttributesRTLRO or
	                                          msidbControlAttributesRightAligned or
										                        msidbControlAttributesLeftScroll;

	// Text Controls
  msidbControlAttributesTransparent       = $00010000;
	msidbControlAttributesNoPrefix          = $00020000;
	msidbControlAttributesNoWrap            = $00040000;
	msidbControlAttributesFormatSize        = $00080000;
	msidbControlAttributesUsersLanguage     = $00100000;

	// Edit controls
	msidbControlAttributesMultiline         = $00010000;

	// ProgressBar controls
	msidbControlAttributesProgress95        = $00010000;

	// VolumeSelectCombo and DirectoryCombo controls
	msidbControlAttributesRemovableVolume   = $00010000;
	msidbControlAttributesFixedVolume       = $00020000;
	msidbControlAttributesRemoteVolume      = $00040000;
	msidbControlAttributesCDROMVolume       = $00080000;
	msidbControlAttributesRAMDiskVolume     = $00100000;
	msidbControlAttributesFloppyVolume      = $00200000;

	// VolumeCostList controls
	msidbControlShowRollbackCost            = $00400000;

	// ListBox and ComboBox controls
	msidbControlAttributesSorted            = $00010000;
	msidbControlAttributesComboList         = $00020000;

	// picture button controls
	msidbControlAttributesImageHandle       = $00010000;
	msidbControlAttributesPushLike          = $00020000;
	msidbControlAttributesBitmap            = $00040000;
	msidbControlAttributesIcon              = $00080000;
	msidbControlAttributesFixedSize         = $00100000;
	msidbControlAttributesIconSize16        = $00200000;
	msidbControlAttributesIconSize32        = $00400000;
	msidbControlAttributesIconSize48        = $00600000;

	// RadioButton controls
	msidbControlAttributesHasBorder         = $01000000;

// CompLocator.Type
// IniLocator.Type
// RegLocator.Type

//typedef enum _msidbLocatorType {
	msidbLocatorTypeDirectory = $00000000;
	msidbLocatorTypeFileName  = $00000001;
//} msidbLocatorType;

// Component.Attributes
// enum msidbComponentAttributes{
	msidbComponentAttributesLocalOnly          = $00000000;
	msidbComponentAttributesSourceOnly         = $00000001;
	msidbComponentAttributesOptional           = $00000002; // local or source
	msidbComponentAttributesRegistryKeyPath    = $00000004; // KeyPath is key to Registry table
	msidbComponentAttributesSharedDllRefCount  = $00000008; // increment SharedDll count
	msidbComponentAttributesPermanent          = $00000010; // never uninstall component
	msidbComponentAttributesODBCDataSource     = $00000020; // KeyFile is key to ODBCDataSource table
	msidbComponentAttributesTransitive         = $00000040; // Can transition to/from installed/uninstalled based on changing conditional
	msidbComponentAttributesNeverOverwrite     = $00000080; // dont stomp over existing component if key path exists (file/ regkey)

// CustomAction.Type

//enum msidbCustomActionType{
	// executable types
	msidbCustomActionTypeDll              = $00000001;  // Target = entry point name
	msidbCustomActionTypeExe              = $00000002;  // Target = command line args
	msidbCustomActionTypeTextData         = $00000003;  // Target = text string to be formatted and set into property
	msidbCustomActionTypeJScript          = $00000005;  // Target = entry point name, null if none to call
	msidbCustomActionTypeVBScript         = $00000006;  // Target = entry point name, null if none to call
	msidbCustomActionTypeInstall          = $00000007;  // Target = property list for nested engine initialization

	// source of code
	msidbCustomActionTypeBinaryData       = $00000000;  // Source = Binary.Name, data stored in stream
	msidbCustomActionTypeSourceFile       = $00000010;  // Source = File.File, file part of installation
	msidbCustomActionTypeDirectory        = $00000020;  // Source = Directory.Directory, folder containing existing file
	msidbCustomActionTypeProperty         = $00000030;  // Source = Property.Property, full path to executable

	// return processing                  // default is syncronous execution, process return code
	msidbCustomActionTypeContinue         = $00000040;  // ignore action return status, continue running
	msidbCustomActionTypeAsync            = $00000080;  // run asynchronously

	// execution scheduling flags         // default is execute whenever sequenced
	msidbCustomActionTypeFirstSequence    = $00000100;  // skip if UI sequence already run
	msidbCustomActionTypeOncePerProcess   = $00000200;  // skip if UI sequence already run in same process
	msidbCustomActionTypeClientRepeat     = $00000300;  // run on client only if UI already run on client
	msidbCustomActionTypeInScript         = $00000400;  // queue for execution within script
	msidbCustomActionTypeRollback         = $00000100;  // in conjunction with InScript: queue in Rollback script
	msidbCustomActionTypeCommit           = $00000200;  // in conjunction with InScript: run Commit ops from script on success

	// security context flag, default to impersonate as user, valid only if InScript
	msidbCustomActionTypeNoImpersonate    = $00000800;  // no impersonation, run in system context

// Dialog.Attributes

//enum msidbDialogAttributes {
	msidbDialogAttributesVisible          = $00000001;
	msidbDialogAttributesModal            = $00000002;
	msidbDialogAttributesMinimize         = $00000004;
	msidbDialogAttributesSysModal         = $00000008;
	msidbDialogAttributesKeepModeless     = $00000010;
	msidbDialogAttributesTrackDiskSpace   = $00000020;
	msidbDialogAttributesUseCustomPalette = $00000040;
	msidbDialogAttributesRTLRO            = $00000080;
	msidbDialogAttributesRightAligned     = $00000100;
	msidbDialogAttributesLeftScroll       = $00000200;
	msidbDialogAttributesBiDi             = msidbDialogAttributesRTLRO or
										                      msidbDialogAttributesRightAligned or
										                      msidbDialogAttributesLeftScroll;
	msidbDialogAttributesError            = $00010000;

// Feature.Attributes
//enum msidbFeatureAttributes{
	msidbFeatureAttributesFavorLocal            = $00000000;
	msidbFeatureAttributesFavorSource           = $00000001;
	msidbFeatureAttributesFollowParent          = $00000002;
	msidbFeatureAttributesFavorAdvertise        = $00000004;
	msidbFeatureAttributesDisallowAdvertise     = $00000008;
	msidbFeatureAttributesUIDisallowAbsent      = $00000010;
	msidbFeatureAttributesNoUnsupportedAdvertise= $00000020;

// File.Attributes

//enum msidbFileAttributes{
	msidbFileAttributesReadOnly       = $00000001;
	msidbFileAttributesHidden         = $00000002;
	msidbFileAttributesSystem         = $00000004;
	msidbFileAttributesReserved1      = $00000040; // Internal use only - must be 0
	msidbFileAttributesReserved2      = $00000080; // Internal use only - must be 0
	msidbFileAttributesReserved3      = $00000100; // Internal use only - must be 0
	msidbFileAttributesVital          = $00000200;
	msidbFileAttributesChecksum       = $00000400;
	msidbFileAttributesPatchAdded     = $00001000; // Internal use only - set by patches
	msidbFileAttributesNoncompressed  = $00002000;
	msidbFileAttributesCompressed     = $00004000;
	msidbFileAttributesReserved4      = $00008000; // Internal use only - must be 0

// IniFile.Action
// RemoveIniFile.Action
//typedef enum _msidbIniFileAction{
	msidbIniFileActionAddLine    = $00000000;
	msidbIniFileActionCreateLine = $00000001;
	msidbIniFileActionRemoveLine = $00000002;
	msidbIniFileActionAddTag     = $00000003;
	msidbIniFileActionRemoveTag  = $00000004;
//} msidbIniFileAction;

// MoveFile.Options
//enum msidbMoveFileOptions{
	msidbMoveFileOptionsMove = $00000001;

// ODBCDataSource.Registration
//typedef enum _msidbODBCDataSourceRegistration{
	msidbODBCDataSourceRegistrationPerMachine  = $00000000;
	msidbODBCDataSourceRegistrationPerUser     = $00000001;
//} msidbODBCDataSourceRegistration;

// Patch.Attributes
//enum msidbPatchAttributes{
	msidbPatchAttributesNonVital = $00000001;

// Registry.Root
// RegLocator.Root
// RemoveRegistry.Root
//enum msidbRegistryRoot{
	msidbRegistryRootClassesRoot  = 0;
	msidbRegistryRootCurrentUser  = 1;
	msidbRegistryRootLocalMachine = 2;
	msidbRegistryRootUsers        = 3;

// RemoveFile.InstallMode
//enum msidbRemoveFileInstallMode{
	msidbRemoveFileInstallModeOnInstall = $00000001;
	msidbRemoveFileInstallModeOnRemove  = $00000002;
	msidbRemoveFileInstallModeOnBoth    = $00000003;

// ServiceControl.Event
//enum msidbServiceControlEvent{
	msidbServiceControlEventStart             = $00000001;
	msidbServiceControlEventStop              = $00000002;
	msidbServiceControlEventDelete            = $00000008;
	msidbServiceControlEventUninstallStart    = $00000010;
	msidbServiceControlEventUninstallStop     = $00000020;
	msidbServiceControlEventUninstallDelete   = $00000080;

// ServiceInstall.ErrorControl
//enum msidbServiceInstallErrorControl{
	msidbServiceInstallErrorControlVital = $00008000;

// TextStyle.StyleBits
//enum msidbTextStyleStyleBits{
	msidbTextStyleStyleBitsBold         = $00000001;
	msidbTextStyleStyleBitsItalic       = $00000002;
	msidbTextStyleStyleBitsUnderline    = $00000004;
	msidbTextStyleStyleBitsStrike       = $00000008;

//--------------------------------------------------------------------------
// SUMMARY INFORMATION PROPERTY DEFINITIONS
//--------------------------------------------------------------------------

//enum msidbSumInfoSourceType{
	msidbSumInfoSourceTypeSFN            = $00000001;  // source uses short filenames
	msidbSumInfoSourceTypeCompressed     = $00000002;  // source is compressed
	msidbSumInfoSourceTypeAdminImage     = $00000004;  // source is an admin image

implementation

end.
