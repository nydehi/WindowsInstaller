unit WindowsInstaller_TLB;
   (*----------------------------------------------------------------------------
 *  this program is confidential and proprietary to Mele Systems, LLC and
 *  MAY NOT BE REPRODUCED, PUBLISHED OR DISCLOSED TO OTHERS
 *  WITHOUT COMPANY AUTHORIZATION.
 *  Copyright: (c)1999 by  MELE Systems, LLC
 *      ALL RIGHTS RESERVED
 *----------------------------------------------------------------------------*)

{ This file contains pascal declarations imported from a type library.
  This file will be written during each import or refresh of the type
  library editor.  Changes to this file will be discarded during the
  refresh process. }

{ Microsoft Windows installer Object Library }
{ Version 1.0 }

{ Conversion log:
  Warning: 'Record' is a reserved word. Record changed to Record_
  Warning: 'File' is a reserved word. Parameter 'File' in Database.Import changed to 'File_'
  Warning: 'File' is a reserved word. Parameter 'File' in Database.Export changed to 'File_'
  Warning: 'Record' is a reserved word. Parameter 'Record' in View.Modify changed to 'Record_'
  Warning: 'Property' is a reserved word. SummaryInfo.Property changed to Property_
  Warning: 'Property' is a reserved word. UIPreview.Property changed to Property_
  Warning: 'Property' is a reserved word. Session.Property changed to Property_
  Warning: 'Record' is a reserved word. Parameter 'Record' in Session.FormatRecord changed to 'Record_'
  Warning: 'Record' is a reserved word. Parameter 'Record' in Session.Message changed to 'Record_'
  Warning: 'Property' is a reserved word. Parameter 'Property' in Session.ProductProperty changed to 'Property_'
 }

interface

uses Windows, ActiveX, Classes, Graphics, StdVCL;

const
  LIBID_WindowsInstaller: TGUID = '{000C1092-0000-0000-C000-000000000046}';

const

{ Constants }

  msiDatabaseNullInteger = $80000000;

{ MsiOpenDatabaseMode }

  msiOpenDatabaseModeReadOnly = 0;
  msiOpenDatabaseModeTransact = 1;
  msiOpenDatabaseModeDirect = 2;
  msiOpenDatabaseModeCreate = 3;
  msiOpenDatabaseModeCreateDirect = 4;

{ MsiDatabaseState }

  msiDatabaseStateRead = 0;
  msiDatabaseStateWrite = 1;

{ MsiColumnInfo }

  msiColumnInfoNames = 0;
  msiColumnInfoTypes = 1;

{ MsiReadStream }

  msiReadStreamInteger = 0;
  msiReadStreamBytes = 1;
  msiReadStreamAnsi = 2;
  msiReadStreamDirect = 3;

{ MsiTransformError }

  msiTransformErrorNone = 0;
  msiTransformErrorAddExistingRow = 1;
  msiTransformErrorDeleteNonExistingRow = 2;
  msiTransformErrorAddExistingTable = 4;
  msiTransformErrorDeleteNonExistingTable = 8;
  msiTransformErrorUpdateNonExistingRow = 16;
  msiTransformErrorChangeCodePage = 32;

{ MsiTransformValidation }

  msiTransformValidationNone = 0;
  msiTransformValidationLanguage = 1;
  msiTransformValidationProduct = 2;
  msiTransformValidationPlatform = 4;
  msiTransformValidationMajorVer = 8;
  msiTransformValidationMinorVer = 16;
  msiTransformValidationUpdateVer = 32;
  msiTransformValidationLess = 64;
  msiTransformValidationLessOrEqual = 128;
  msiTransformValidationEqual = 256;
  msiTransformValidationGreaterOrEqual = 512;
  msiTransformValidationGreater = 1024;
  msiTransformValidationUpgradeCode = 2048;

{ MsiViewModify }

  msiViewModifySeek = -1;
  msiViewModifyRefresh = 0;
  msiViewModifyInsert = 1;
  msiViewModifyUpdate = 2;
  msiViewModifyAssign = 3;
  msiViewModifyReplace = 4;
  msiViewModifyMerge = 5;
  msiViewModifyDelete = 6;
  msiViewModifyInsertTemporary = 7;
  msiViewModifyValidate = 8;
  msiViewModifyValidateNew = 9;
  msiViewModifyValidateField = 10;
  msiViewModifyValidateDelete = 11;

{ MsiEvaluateCondition }

  msiEvaluateConditionFalse = 0;
  msiEvaluateConditionTrue = 1;
  msiEvaluateConditionNone = 2;
  msiEvaluateConditionError = 3;

{ MsiDoActionStatus }

  msiDoActionStatusNoAction = 0;
  msiDoActionStatusSuccess = 1;
  msiDoActionStatusUserExit = 2;
  msiDoActionStatusFailure = 3;
  msiDoActionStatusSuspend = 4;
  msiDoActionStatusFinished = 5;
  msiDoActionStatusWrongState = 6;
  msiDoActionStatusBadActionData = 7;

{ MsiMessageType }

  msiMessageTypeFatalExit = 0;
  msiMessageTypeError = 16777216;
  msiMessageTypeWarning = 33554432;
  msiMessageTypeUser = 50331648;
  msiMessageTypeInfo = 67108864;
  msiMessageTypeFilesInUse = 83886080;
  msiMessageTypeResolveSource = 100663296;
  msiMessageTypeOutOfDiskSpace = 117440512;
  msiMessageTypeActionStart = 134217728;
  msiMessageTypeActionData = 150994944;
  msiMessageTypeProgress = 167772160;
  msiMessageTypeCommonData = 184549376;
  msiMessageTypeOk = 0;
  msiMessageTypeOkCancel = 1;
  msiMessageTypeAbortRetryIgnore = 2;
  msiMessageTypeYesNoCancel = 3;
  msiMessageTypeYesNo = 4;
  msiMessageTypeRetryCancel = 5;
  msiMessageTypeDefault1 = 0;
  msiMessageTypeDefault2 = 256;
  msiMessageTypeDefault3 = 512;

{ MsiMessageStatus }

  msiMessageStatusError = -1;
  msiMessageStatusNone = 0;
  msiMessageStatusOk = 1;
  msiMessageStatusCancel = 2;
  msiMessageStatusAbort = 3;
  msiMessageStatusRetry = 4;
  msiMessageStatusIgnore = 5;
  msiMessageStatusYes = 6;
  msiMessageStatusNo = 7;

{ MsiInstallState }

  msiInstallStateNotUsed = -7;
  msiInstallStateBadConfig = -6;
  msiInstallStateIncomplete = -5;
  msiInstallStateSourceAbsent = -4;
  msiInstallStateInvalidArg = -2;
  msiInstallStateUnknown = -1;
  msiInstallStateBroken = 0;
  msiInstallStateAdvertised = 1;
  msiInstallStateRemoved = 1;
  msiInstallStateAbsent = 2;
  msiInstallStateLocal = 3;
  msiInstallStateSource = 4;
  msiInstallStateDefault = 5;

{ MsiReinstallMode }

  msiReinstallModeFileMissing = 2;
  msiReinstallModeFileOlderVersion = 4;
  msiReinstallModeFileEqualVersion = 8;
  msiReinstallModeFileExact = 16;
  msiReinstallModeFileVerify = 32;
  msiReinstallModeFileReplace = 64;
  msiReinstallModeMachineData = 128;
  msiReinstallModeUserData = 256;
  msiReinstallModeShortcut = 512;
  msiReinstallModePackage = 1024;

{ MsiInstallMode }

  MsiInstallModeNoDetection = -2;
  MsiInstallModeExisting = -1;
  MsiInstallModeDefault = 0;

{ MsiUILevel }

  msiUILevelNoChange = 0;
  msiUILevelDefault = 1;
  msiUILevelNone = 2;
  msiUILevelBasic = 3;
  msiUILevelReduced = 4;
  msiUILevelFull = 5;
  msiUILevelEndDialog = 128;

{ MsiCostTree }

  msiCostTreeSelfOnly = 0;
  msiCostTreeChildren = 1;
  msiCostTreeParents = 2;

{ MsiInstallType }

  msiInstallTypeDefault = 0;
  msiInstallTypeNetworkImage = 1;

{ MsiRunMode }

  msiRunModeAdmin = 0;
  msiRunModeAdvertise = 1;
  msiRunModeMaintenance = 2;
  msiRunModeRollbackEnabled = 3;
  msiRunModeLogEnabled = 4;
  msiRunModeOperations = 5;
  msiRunModeRebootAtEnd = 6;
  msiRunModeRebootNow = 7;
  msiRunModeCabinet = 8;
  msiRunModeSourceShortNames = 9;
  msiRunModeTargetShortNames = 10;
  msiRunModeWindows9x = 12;
  msiRunModeZawEnabled = 13;
  msiRunModeScheduled = 16;
  msiRunModeRollback = 17;
  msiRunModeCommit = 18;

type

{ Forward declarations: Interfaces }
  Installer = dispinterface;
  Record_ = dispinterface;
  Database = dispinterface;
  View = dispinterface;
  SummaryInfo = dispinterface;
  UIPreview = dispinterface;
  Session = dispinterface;
  FeatureInfo = dispinterface;
  StringList = dispinterface;

{ Forward declarations: Enums }
  Constants = TOleEnum;
  MsiOpenDatabaseMode = TOleEnum;
  MsiDatabaseState = TOleEnum;
  MsiColumnInfo = TOleEnum;
  MsiReadStream = TOleEnum;
  MsiTransformError = TOleEnum;
  MsiTransformValidation = TOleEnum;
  MsiViewModify = TOleEnum;
  MsiEvaluateCondition = TOleEnum;
  MsiDoActionStatus = TOleEnum;
  MsiMessageType = TOleEnum;
  MsiMessageStatus = TOleEnum;
  MsiInstallState = TOleEnum;
  MsiReinstallMode = TOleEnum;
  MsiInstallMode = TOleEnum;
  MsiUILevel = TOleEnum;
  MsiCostTree = TOleEnum;
  MsiInstallType = TOleEnum;
  MsiRunMode = TOleEnum;

  Installer = dispinterface
    ['{000C1090-0000-0000-C000-000000000046}']
    property UILevel: MsiUILevel dispid 6;
    function CreateRecord(Count: Integer): Record_; dispid 1;
    function OpenPackage(PackagePath: OleVariant): Session; dispid 2;
    function OpenProduct(const ProductCode: WideString): Session; dispid 3;
    function OpenDatabase(const DatabasePath: WideString; OpenMode: OleVariant): Database; dispid 4;
    property SummaryInformation[const PackagePath: WideString; UpdateCount: Integer]: SummaryInfo readonly dispid 5;
    procedure EnableLog(const LogMode, LogFile: WideString); dispid 7;
    procedure InstallProduct(const PackagePath, PropertyValues: WideString); dispid 8;
    property Version: WideString readonly dispid 9;
    function LastErrorRecord: Record_; dispid 10;
    function RegistryValue(Root: OleVariant; const Key: WideString; Value: OleVariant): WideString; dispid 11;
    function FileAttributes(const FilePath: WideString): Integer; dispid 13;
    function FileSize(const FilePath: WideString): Integer; dispid 15;
    function FileVersion(const FilePath: WideString): WideString; dispid 16;
    property Environment[const Variable: WideString]: WideString dispid 12;
    property ProductState[const Product: WideString]: MsiInstallState readonly dispid 17;
    property ProductInfo[const Product, Attribute: WideString]: WideString readonly dispid 18;
    procedure ConfigureProduct(const Product: WideString; InstallLevel: Integer; InstallState: MsiInstallState); dispid 19;
    procedure ReinstallProduct(const Product: WideString; ReinstallMode: MsiReinstallMode); dispid 20;
    procedure CollectUserInfo(const Product: WideString); dispid 21;
    procedure ApplyPatch(const PatchPackage, InstallPackage: WideString; InstallType: MsiInstallType; const CommandLine: WideString); dispid 22;
    property FeatureParent[const Product, Feature: WideString]: WideString readonly dispid 23;
    property FeatureState[const Product, Feature: WideString]: MsiInstallState readonly dispid 24;
    procedure UseFeature(const Product, Feature: WideString; InstallMode: MsiInstallMode); dispid 25;
    property FeatureUsageCount[const Product, Feature: WideString]: Integer readonly dispid 26;
    property FeatureUsageDate[const Product, Feature: WideString]: TDateTime readonly dispid 27;
    procedure ConfigureFeature(const Product, Feature: WideString; InstallState: MsiInstallState); dispid 28;
    procedure ReinstallFeature(const Product, Feature: WideString; ReinstallMode: MsiReinstallMode); dispid 29;
    function ProvideComponent(const Product, Feature, Component: WideString; InstallMode: Integer): WideString; dispid 30;
    property ComponentPath[const Product, Component: WideString]: WideString readonly dispid 31;
    function ProvideQualifiedComponent(const Category, Qualifier: WideString; InstallMode: Integer): WideString; dispid 32;
    property QualifierDescription[const Category, Qualifier: WideString]: WideString readonly dispid 33;
    property ComponentQualifiers[const Category: WideString]: StringList readonly dispid 34;
    property Products: StringList readonly dispid 35;
    property Features[const Product: WideString]: StringList readonly dispid 36;
    property Components: StringList readonly dispid 37;
    property ComponentClients[const Product: WideString]: StringList readonly dispid 38;
  end;

  Record_ = dispinterface
    ['{000C1093-0000-0000-C000-000000000046}']
    property StringData[Field: Integer]: WideString dispid 1;
    property IntegerData[Field: Integer]: Integer dispid 2;
    procedure SetStream(Field: Integer; const FilePath: WideString); dispid 3;
    function ReadStream(Field, Length: Integer; Format: MsiReadStream): WideString; dispid 4;
    property FieldCount: Integer readonly dispid 0;
    property IsNull[Field: Integer]: WordBool readonly dispid 6;
    property DataSize[Field: Integer]: Integer readonly dispid 5;
    procedure ClearData; dispid 7;
    function FormatText: WideString; dispid 8;
  end;

  Database = dispinterface
    ['{000C109D-0000-0000-C000-000000000046}']
    property DatabaseState: MsiDatabaseState readonly dispid 1;
    property SummaryInformation[UpdateCount: Integer]: SummaryInfo readonly dispid 2;
    function OpenView(const Sql: WideString): View; dispid 3;
    procedure Commit; dispid 4;
    property PrimaryKeys[const Table: WideString]: Record_ readonly dispid 5;
    procedure Import(const Folder, File_: WideString); dispid 6;
    procedure Export(const Table, Folder, File_: WideString); dispid 7;
    function Merge(const Database: Database; const ErrorTable: WideString): WordBool; dispid 8;
    function GenerateTransform(const ReferenceDatabase: Database; const TransformFile: WideString): WordBool; dispid 9;
    procedure ApplyTransform(const TransformFile: WideString; ErrorConditions: MsiTransformError); dispid 10;
    function EnableUIPreview: UIPreview; dispid 11;
    property TablePersistent[const Table: WideString]: MsiEvaluateCondition readonly dispid 12;
    procedure CreateTransformSummaryInfo(const ReferenceDatabase: Database; const TransformFile: WideString; ErrorConditions: MsiTransformError; Validation: MsiTransformValidation); dispid 13;
  end;

  View = dispinterface
    ['{000C109C-0000-0000-C000-000000000046}']
    procedure Execute(const Params: Record_); dispid 1;
    function Fetch: Record_; dispid 2;
    procedure Modify(Mode: MsiViewModify; const Record_: Record_); dispid 3;
    property ColumnInfo[Info: MsiColumnInfo]: Record_ readonly dispid 5;
    procedure Close; dispid 4;
    function GetError: WideString; dispid 6;
  end;

  SummaryInfo = dispinterface
    ['{000C109B-0000-0000-C000-000000000046}']
    property Property_[Pid: Integer]: OleVariant dispid 1;
    property PropertyCount: Integer readonly dispid 2;
    procedure Persist; dispid 3;
  end;

  UIPreview = dispinterface
    ['{000C109A-0000-0000-C000-000000000046}']
    property Property_[const Name: WideString]: WideString dispid 1;
    procedure ViewDialog(const Dialog: WideString); dispid 2;
    procedure ViewBillboard(const Control, Billboard: WideString); dispid 3;
  end;

  Session = dispinterface
    ['{000C109E-0000-0000-C000-000000000046}']
    property Installer: Installer readonly dispid 1;
    property Property_[const Name: WideString]: WideString dispid 2;
    property Language: Integer readonly dispid 3;
    property Mode[Flag: MsiRunMode]: WordBool dispid 4;
    property Database: Database readonly dispid 5;
    property SourcePath[const Folder: WideString]: WideString readonly dispid 6;
    property TargetPath[const Folder: WideString]: WideString dispid 7;
    function DoAction(const Action: WideString): MsiDoActionStatus; dispid 8;
    function Sequence(const Table: WideString; Mode: OleVariant): MsiDoActionStatus; dispid 9;
    function EvaluateCondition(const Expression: WideString): MsiEvaluateCondition; dispid 10;
    function FormatRecord(const Record_: Record_): WideString; dispid 11;
    function Message(Kind: MsiMessageType; const Record_: Record_): MsiMessageStatus; dispid 12;
    property FeatureCurrentState[const Feature: WideString]: MsiInstallState readonly dispid 13;
    property FeatureRequestState[const Feature: WideString]: MsiInstallState dispid 14;
    property FeatureValidStates[const Feature: WideString]: Integer readonly dispid 15;
    property FeatureCost[const Feature: WideString; CostTree: MsiCostTree; State: MsiInstallState]: Integer readonly dispid 16;
    property ComponentCurrentState[const Component: WideString]: MsiInstallState readonly dispid 17;
    property ComponentRequestState[const Component: WideString]: MsiInstallState dispid 18;
    procedure SetInstallLevel(Level: Integer); dispid 19;
    property VerifyDiskSpace: WordBool readonly dispid 20;
    property ProductProperty[const Property_: WideString]: WideString readonly dispid 21;
    property FeatureInfo[const Feature: WideString]: FeatureInfo readonly dispid 22;
  end;

  FeatureInfo = dispinterface
    ['{000C109F-0000-0000-C000-000000000046}']
    property Title: WideString readonly dispid 1;
    property Description: WideString readonly dispid 2;
    property Attributes: Integer readonly dispid 3;
  end;

  StringList = dispinterface
    ['{000C1095-0000-0000-C000-000000000046}']
    function _NewEnum: IUnknown; dispid -4;
    property Item[Index: Integer]: WideString readonly dispid 0; default;
    property Count: Integer readonly dispid 1;
  end;



implementation


end.
