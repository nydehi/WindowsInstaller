unit exceptions_msi;
 (*----------------------------------------------------------------------------
 *  this program is confidential and proprietary to Mele Systems, LLC and
 *  MAY NOT BE REPRODUCED, PUBLISHED OR DISCLOSED TO OTHERS
 *  WITHOUT COMPANY AUTHORIZATION.
 *  Copyright: (c)1999 by  MELE Systems, LLC
 *      ALL RIGHTS RESERVED
 *----------------------------------------------------------------------------*)

 interface
uses msi,msiquery,SysUtils;

type
TysflHresult = Longint;

EYsflMsi = Class(Exception);

//general installer functions
EysflMSINoMoreItems = class(EYsflMsi);
EysflMSIInvalidParameter = Class(EYsflMsi);
EysflMSIUnknownProperty  = Class(EYsflMsi);
EysflMSIUnknownProduct   = Class(EYsflMsi);
EysflMSIInstallFailure   = Class(EYsflMsi);
EysflMSIInstallSuspend   = Class(EYsflMsi);
EysflMSIUnknownFeature   = Class(EYsflMsi);
EysflMSIUnknownComponent  = Class(EYsflMsi);
EysflMSIInvalidHandleState  = Class(EYsflMsi);
EysflMSIBadConfiguration  = Class(EYsflMsi);
EysflMSIIndexAbsent  = Class(EYsflMsi);
EysflMSIInstallSourceAbsent  = Class(EYsflMsi);
EysflMSIProductUnistalled  = Class(EYsflMsi);
EysflMSIBadQuerySyntax     = Class(EYsflMsi);
EysflMSIInvalidField  = Class(EYsflMsi);
EysflMSIInstallServiceFailure = class(EYsflMsi);
EysflMSIInstallPackageVersion = Class(EYsflMsi);
EysflMSIInstallAlreadyRunning  = Class(EYsflMsi);
EysflMSIInstallPackageOpenFailed  = Class(EYsflMsi);
EysflMSIInstallPackageInvalid  = Class(EYsflMsi);
EysflMSIInstallUIFailure = Class(EYsflMsi);
EysflMSIInstallLogFailure  = Class(EYsflMsi);
EysflMSIInstallLanguageUnsupported  = Class(EYsflMsi);
EysflMSIInstallPackageRejected  = Class(EYsflMsi);
EysflMSIFunctionNotCalled  = Class(EYsflMsi);
EysflMSIFunctionFailed  = Class(EYsflMsi);
EysflMSIInvalidTable    = Class(EYsflMsi);
EysflMSIDataTypeMismatch  = Class(EYsflMsi);
EysflMSIUnsupportedType  = Class(EYsflMsi);
EysflMSICreateFailed  = Class(EYsflMsi);
EysflMSIInstallTempUnwritable  = Class(EYsflMsi);
EysflMSIInstallPlatformUnsupported  = Class(EYsflMsi);
EysflMSIInstallNotUsed  = Class(EYsflMsi);
EysflMSIInstallTransformFailure  = Class(EYsflMsi);
EysflMSIPatchPackageOpenFailed  = Class(EYsflMsi);
EysflMSIPatchPackageInvalid = Class(EYsflMsi);
EysflMSIProductVersion  = Class(EYsflMsi);
EysflMSIInvalidCommandLine  = Class(EYsflMsi);

//Database Exceptions
EysflMSIDBERRORINVALIDARG = Class(EYsflMsi);
EysflMSIDBERRORMOREDATA   = Class(EYsflMsi);
EysflMSIDBERRORFUNCTIONERROR= Class(EYsflMsi);
EysflMSIDBERRORNOERROR       = Class(EYsflMsi);
EysflMSIDBERRORDUPLICATEKEY  = Class(EYsflMsi);
EysflMSIDBERRORREQUIRED      = Class(EYsflMsi);
EysflMSIDBERRORBADLINK       = Class(EYsflMsi);
EysflMSIDBERROROVERFLOW      = Class(EYsflMsi);
EysflMSIDBERRORUNDERFLOW     = Class(EYsflMsi);
EysflMSIDBERRORNOTINSET      = Class(EYsflMsi);
EysflMSIDBERRORBADVERSION    = Class(EYsflMsi);
EysflMSIDBERRORBADCASE      = Class(EYsflMsi);
EysflMSIDBERRORBADGUID      = Class(EYsflMsi);
EysflMSIDBERRORBADWILDCARD  = Class(EYsflMsi);
EysflMSIDBERRORBADIDENTIFIER = Class(EYsflMsi);
EysflMSIDBERRORBADLANGUAGE  = Class(EYsflMsi);
EysflMSIDBERRORBADFILENAME  = Class(EYsflMsi);
EysflMSIDBERRORBADPATH = Class(EYsflMsi);
EysflMSIDBERRORBADCONDITION = Class(EYsflMsi);
EysflMSIDBERRORBADFORMATTED  = Class(EYsflMsi);
EysflMSIDBERRORBADTEMPLATE    = Class(EYsflMsi);
EysflMSIDBERRORBADDEFAULTDIR  = Class(EYsflMsi);
EysflMSIDBERRORBADREGPATH    = Class(EYsflMsi);
EysflMSIDBERRORBADCUSTOMSOURCE  = Class(EYsflMsi);
EysflMSIDBERRORBADPROPERTY    = Class(EYsflMsi);
EysflMSIDBERRORMISSINGDATA    = Class(EYsflMsi);
EysflMSIDBERRORBADCATEGORY     = Class(EYsflMsi);
EysflMSIDBERRORBADKEYTABLE     = Class(EYsflMsi);
EysflMSIDBERRORBADMAXMINVALUES  = Class(EYsflMsi);
EysflMSIDBERRORBADCABINET       = Class(EYsflMsi);
EysflMSIDBERRORBADSHORTCUT      = Class(EYsflMsi);
EysflMSIDBERRORSTRINGOVERFLOW   = Class(EYsflMsi);
EysflMSIDBERRORBADLOCALIZEATTRIB = Class(EYsflMsi);

procedure MsiCheck(Result: TysflHresult);
procedure MsiDBCheck(Result: TysflHresult);
procedure MsiCheckAll(Result: TysflHresult);

implementation
uses ActiveX,Comobj,exceptions_youseful;

procedure MsiCheckAll(Result: TysflHresult);
begin
  OleCheck(Result);
  MsiCheck(Result);
  MsiDBCheck(Result);
end;

procedure MsiDBCheck(Result: TysflHresult);
begin
  case (result) of
   MSIDBERROR_INVALIDARG : //
            Raise EysflMSIDBErrorInvalidArg.Create('invalid argument');
    MSIDBERROR_MOREDATA : //
             Raise EysflMSIDBERRORMOREDATA.Create(' buffer too small ');
    MSIDBERROR_FUNCTIONERROR : //
             Raise EysflMSIDBERRORFUNCTIONERROR.Create(' function error ');
  //  MSIDBERROR_NOERROR      :   //
       //      Raise EysflMSIDBERRORNOERROR.Create(' no error ');
    MSIDBERROR_DUPLICATEKEY   :    //
             Raise EysflMSIDBERRORDUPLICATEKEY.Create('new record duplicates primary keys of existing record in TTable ');
    MSIDBERROR_REQUIRED       :   //
             Raise EysflMSIDBERRORREQUIRED.Create(' non-nullable column, no null values allowed ');
    MSIDBERROR_BADLINK       :    //
             Raise EysflMSIDBERRORBADLINK.Create('corresponding record in foreign table not found ');
    MSIDBERROR_OVERFLOW     :   //
            Raise  EysflMSIDBERROROVERFLOW.Create('data greater than maximum value allowed ');
    MSIDBERROR_UNDERFLOW    : //
           Raise   EysflMSIDBERRORUNDERFLOW.Create('data less than minimum value allowed ');
    MSIDBERROR_NOTINSET     :       //
            Raise  EysflMSIDBERRORNOTINSET.Create('data not a member of the values permitted in the set');
    MSIDBERROR_BADVERSION    :    //
            Raise  EysflMSIDBERRORBADVERSION.Create('invalid version string');
    MSIDBERROR_BADCASE      :   //
            Raise  EysflMSIDBERRORBADCASE.Create('invalid case, must be all upper-case or all lower-case ');
    MSIDBERROR_BADGUID      :    //
            Raise  EysflMSIDBERRORBADGUID.Create('invalid GUID ');
    MSIDBERROR_BADWILDCARD   :    //
          Raise  EysflMSIDBERRORBADWILDCARD.Create(' invalid wildcardfilename or use of wildcards');
    MSIDBERROR_BADIDENTIFIER :   //
          Raise  EysflMSIDBERRORBADIDENTIFIER.Create('bad identifier');
    MSIDBERROR_BADLANGUAGE    :    //
         Raise   EysflMSIDBERRORBADLANGUAGE.Create('bad language Id(s) ');
    MSIDBERROR_BADFILENAME    :    //
          Raise  EysflMSIDBERRORBADFILENAME.Create('bad FileName ');
    MSIDBERROR_BADPATH    :    //
          Raise   EysflMSIDBERRORBADPATH.Create('bad path ');
    MSIDBERROR_BADCONDITION :     //
          Raise  EysflMSIDBERRORBADCONDITION.Create('bad conditional statement ');
    MSIDBERROR_BADFORMATTED  :   //
          Raise  EysflMSIDBERRORBADFORMATTED.Create('bad format string ');
    MSIDBERROR_BADTEMPLATE   :   //
          Raise EysflMSIDBERRORBADTEMPLATE.Create('bad template string ');
    MSIDBERROR_BADDEFAULTDIR  :   //
          Raise EysflMSIDBERRORBADDEFAULTDIR.Create('bad string in DefaultDir column of Directory TTable ');
    MSIDBERROR_BADREGPATH    :     //
          Raise   EysflMSIDBERRORBADREGPATH.Create(' bad registry path string ');
    MSIDBERROR_BADCUSTOMSOURCE :   //
          Raise  EysflMSIDBERRORBADCUSTOMSOURCE.Create(' bad string in CustomSource column of CustomAction TTable ');
    MSIDBERROR_BADPROPERTY    :    //
          Raise  EysflMSIDBERRORBADPROPERTY.Create('bad property string ');
    MSIDBERROR_MISSINGDATA    :    //
          Raise    EysflMSIDBERRORMISSINGDATA.Create('_Validation table missing reference to column ');
    MSIDBERROR_BADCATEGORY    :    //
          Raise    EysflMSIDBERRORBADCATEGORY.Create('Category column of _Validation table for column is invalid ');
    MSIDBERROR_BADKEYTABLE    :    //
          Raise   EysflMSIDBERRORBADKEYTABLE.Create('table in KeyTable column of _Validation table could not be found/Loaded ');
    MSIDBERROR_BADMAXMINVALUES :   //
          Raise   EysflMSIDBERRORBADMAXMINVALUES.Create('value in MaxValue column of _Validation table is less than value in MinValue column ');
    MSIDBERROR_BADCABINET      :   //
          Raise  EysflMSIDBERRORBADCABINET.Create('bad cabinet Name ');
    MSIDBERROR_BADSHORTCUT     :   //
          Raise   EysflMSIDBERRORBADSHORTCUT.Create('bad shortcut target ');
    MSIDBERROR_STRINGOVERFLOW  :   //
          Raise   EysflMSIDBERRORSTRINGOVERFLOW.Create('string overflow (greater than length allowed in column def) ');
    MSIDBERROR_BADLOCALIZEATTRIB : //
          Raise   EysflMSIDBERRORBADLOCALIZEATTRIB.Create('invalid localization attribute (primary keys cannot be localized ')
   else
      Olecheck(Result);
   end;

end;

procedure MsiCheck(Result: TysflHresult);
begin
  Case(Result) of
 //   ERROR_NO_MORE_ITEMS:
     //      Raise EysflMSINoMoreItems.Create('');
    ERROR_UNKNOWN_PROPERTY:
           Raise EysflMSIUnknownProperty.create('Unknown Property');
    ERROR_UNKNOWN_PRODUCT:   // This action is only valid for products that are currently installed.
           Raise EysflMSIUnknownProduct.create('Unknown Product ');
    ERROR_INSTALL_USEREXIT :          //
           Raise EAIUserAbort.Create;//Fmt('User cancel installation from Windows Installer',[]);
    ERROR_INSTALL_FAILURE  :            // Fatal error during installation.
           Raise EysflMSIInstallFailure.create('Install Failure');
    ERROR_INSTALL_SUSPEND  :           // Installation suspended, incomplete.
           Raise EysflMSIInstallSuspend.create('Install Suspend');
    ERROR_UNKNOWN_FEATURE  :          // Feature ID not registered.
           Raise EysflMSIUnknownFeature.create('Unknown Feature');
    ERROR_UNKNOWN_COMPONENT  :         // Component ID not registered.
           Raise EysflMSIUnknownComponent.create('Unknown Component');
    ERROR_INVALID_HANDLE_STATE  :       // .
           Raise EysflMSIInvalidHandleState.create('Handle is in an invalid state');
    ERROR_BAD_CONFIGURATION   :      //
           Raise EysflMSIBadConfiguration.create('The configuration data for this product is corrupt.  Contact your support personnel.');
    ERROR_INDEX_ABSENT       :    //
           Raise EysflMSIIndexAbsent.create('Component qualifier not present.');
    ERROR_INSTALL_SOURCE_ABSENT  :    //
           Raise EysflMSIInstallSourceAbsent.create('The installation source for this product is not available.  Verify that the source exists and that you can access it. ');
    //ERROR_PRODUCT_UNINSTALLED  :         //
      //     Raise EysflMSIProductUninstalled.create('Product is uninstalled.');
    ERROR_BAD_QUERY_SYNTAX     :        //
           Raise EysflMSIBadQuerySyntax.create('SQL query syntax invalid or unsupported.');
    ERROR_INVALID_FIELD        :      //
           Raise EysflMSIInvalidField.create('Record field does not exist.');
    ERROR_INSTALL_SERVICE_FAILURE   :  //
           Raise EysflMSIInstallServiceFailure.create('The Windows Installer service could not be accessed.  Contact your support personnel to verify that the Windows Installer service is properly registered.');
    ERROR_INSTALL_PACKAGE_VERSION   : //
           Raise EysflMSIInstallPackageVersion.create('This installation package cannot be installed by the Windows Installer service.  You must install a Windows service pack that contains a newer version of the Windows Installer service.');
    ERROR_INSTALL_ALREADY_RUNNING   :    //
           Raise EysflMSIInstallAlreadyRunning.create('Another installation is already in progress.  Complete that installation before proceeding with this install. ');
    ERROR_INSTALL_PACKAGE_OPEN_FAILED  :  //
           Raise EysflMSIInstallPackageOpenFailed.create('This installation package could not be opened.  Verify that the package exists and that you can access it, or contact the application vendor to verify that this is a valid Windows Installer package.');
    ERROR_INSTALL_PACKAGE_INVALID    : //
           Raise EysflMSIInstallPackageInvalid.create('This installation package could not be opened.  Contact the application vendor to verify that this is a valid Windows Installer package.');
    ERROR_INSTALL_UI_FAILURE          : //
           Raise EysflMSIInstallUIFailure.create('There was an error starting the Windows Installer service user interface.  Contact your support personnel.');
    ERROR_INSTALL_LOG_FAILURE       : //
           Raise EysflMSIInstallLogFailure.create('Error opening installation log file.  Verify that the specified log file location exists and is writable.');
    ERROR_INSTALL_LANGUAGE_UNSUPPORTED: //
           Raise EysflMSIInstallLanguageUnsupported.create('This language of this installation package is not supported by your system.');
    ERROR_INSTALL_PACKAGE_REJECTED  :   //
           Raise EysflMSIInstallPackageRejected.create('This installation is forbidden by system policy.  Contact your system administrator.');
    ERROR_FUNCTION_NOT_CALLED       : //
          Raise EysflMSIFunctionNotCalled.create('Function could not be executed.');
    ERROR_FUNCTION_FAILED          : //
           Raise EysflMSIFunctionFailed.create('Function failed during execution.');
    ERROR_INVALID_TABLE       : //
           Raise EysflMSIInvalidTable.create('Invalid or unknown table specified.');
    //ERROR_DATATYPE_MISMATCH    : // .
     //                  Raise EysflMSIiDataTypeMismatch.create('Data supplied is of wrong type');
    ERROR_UNSUPPORTED_TYPE     : //
                       Raise EysflMSIUnsupportedType.create('Data of this type is not supported.');
    ERROR_CREATE_FAILED       : //
                       Raise EysflMSICreateFailed.create('The Windows Installer service failed to start.  Contact your support personnel.');
    ERROR_INSTALL_TEMP_UNWRITABLE     : //
                       Raise EysflMSIInstallTempUnwritable.create('The temp folder is either full or inaccessible.  Verify that the temp folder exists and that you can write to it.');
    ERROR_INSTALL_PLATFORM_UNSUPPORTED : //
                       Raise EysflMSIInstallPlatformUnsupported.create('This installation package is not supported on this platform.  Contact your application vendor');
    ERROR_INSTALL_NOTUSED              : //
                       Raise EysflMSIInstallNotUsed.create('Component not used on this machine') ;
    ERROR_INSTALL_TRANSFORM_FAILURE    : //
                       Raise EysflMSIInstallTransformFailure.create('Error applying transforms.  Verify that the specified transform paths are valid.');
    ERROR_PATCH_PACKAGE_OPEN_FAILED   : //
                       Raise EysflMSIPatchPackageOpenFailed.create('This patch package could not be opened.  Verify that the patch package exists and that you can access it, or contact the application vendor to verify that this is a valid Windows Installer patch package.');
    ERROR_PATCH_PACKAGE_INVALID      : //
                       Raise EysflMSIPatchPackageInvalid.create('This patch package could not be opened.  Contact the application vendor to verify that this is a valid Windows Installer patch package.');
    //ERROR_PATCH_PACKAGE_UNSUPPORTED   ://
        //               Raise EysflMSIPatchPackageUnsupported.create('This patch package cannot be processed by the Windows Installer service.  You must install a Windows service pack that contains a newer version of the Windows Installer service.');
    ERROR_PRODUCT_VERSION    :         //
              Raise EysflMSIProductVersion.create('Another version of this product is already installed.  Installation of this version cannot continue.  To configure or remove the existing version of this product, use Add/Remove Programs on the Control Panel.');
    ERROR_INVALID_COMMAND_LINE   :       //
           Raise EysflMSIInvalidCommandLine.create('Invalid command line argument.  Consult the Windows Installer SDK for detailed command line help.');
  else
     OleCheck(Result);
  end;

end;

end.
