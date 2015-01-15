// <file>
//     <copyright see=""/>
//     <license see=""/>
//     <owner name="Youseful Software" email="support@youseful.com"/>
//     <version value="$version"/>
// </file>
using System;
using System.Runtime.Serialization;
using System.Runtime.InteropServices;
//using Youseful.Installer.Nativemsi;
using Youseful.Exceptions.Win32;

/* A High Level Wrapper for msi.dll */
namespace Youseful.Installer.WI.Nativemsi.Exceptions
{
	
	#region Exception Types
	
		
	[Serializable]
	public class MsiException : Exception, ISerializable
	{
		private string _ErrorMessage;
	
		public MsiException (string errorMessage) : base(errorMessage)
		{
		
		}	
		public MsiException () : base()
		{
		
		}	
		
		public MsiException (string errorMessage, Exception innerException) 
			: base(errorMessage, innerException)
		{
		
		}	

		public string ErrorMessage { get { return _ErrorMessage;}}

		public override string Message
		{
			get
			{
				string msg = base.Message;
				if (_ErrorMessage != null)
					msg += Environment.NewLine + "WI API: " + _ErrorMessage;
				return msg;
			}
		}

		protected MsiException(SerializationInfo info,
			StreamingContext context) : base(info, context)
		{
			_ErrorMessage = info.GetString("ErrorMessage");

		}

		void ISerializable.GetObjectData(SerializationInfo info,
			StreamingContext context)
		{
			info.AddValue("ErrorMessage",_ErrorMessage);
			base.GetObjectData(info,context);
		}

		public MsiException(string message, string errormessage,
			Exception innerException) : this(message, innerException)
		{
			this._ErrorMessage = errormessage;
		}
	
		
	}

	[Serializable]
	sealed public class MsiDBException : MsiException, ISerializable
	{
		private string _ErrorMessage;
	
	 public MsiDBException (string errorMessage) : base(errorMessage)
	  {
		
      }	
		public MsiDBException () : base()
	{
		
	}	
		
		public MsiDBException (string errorMessage, Exception innerException) 
			: base(errorMessage, innerException)
	{
		
	}	

	public string ErrorMessage { get { return _ErrorMessage;}}

	public override string Message
	{
		get
		{
			string msg = base.Message;
			if (_ErrorMessage != null)
				msg += Environment.NewLine + "WI DB API: " + _ErrorMessage;
			return msg;
		}
	}

	protected MsiDBException(SerializationInfo info,
		StreamingContext context) : base(info, context)
	{
		_ErrorMessage = info.GetString("ErrorMessage");

	}

	void ISerializable.GetObjectData(SerializationInfo info,
		StreamingContext context)
	{
		info.AddValue("ErrorMessage",_ErrorMessage);
		base.GetObjectData(info,context);
	}

	public MsiDBException(string message, string errormessage,
		Exception innerException) : this(message, innerException)
	{
		this._ErrorMessage = errormessage;
	}
	
		
	}

	

	#endregion


	
	#region Low Level Exception Classes

	

	sealed public class MsiCheckAll
	{
		//private MsiCheck Check;
		//private MsiDBCheck DBCheck;
	
	/*	public MsiCheckAll ()
		{
			//Check = new MsiCheck();
			//DBCheck = new MsiDBCheck();

	
				}

		public void CheckEx (long ErrorCode)
		{
			//Check.CheckEx(ErrorCode);
		
			//DBCheck.CheckEx(Convert.ToInt32(ErrorCode));
		}*/

		/// <summary>
		/// Checks and calls appropiate exceptions
		/// </summary>
		public static void CheckAll (long ErrorCode)
		{
			MsiCheck.CheckEx(ErrorCode);
		
			MsiDBCheck.CheckEx(Convert.ToInt32(ErrorCode));

			Win32Check.CheckEx(ErrorCode);
		}
	}

	

	#region MsiCheck 







  public class MsiCheck 
  {
// --------------------------------------------------------------------------
// Error codes for installer access functions - until merged to winerr.h
// --------------------------------------------------------------------------

///ifndef ERROR_INSTALL_FAILURE
     public const long ERROR_INSTALL_USEREXIT         =  1602L;  // User cancel installation.
     public const long ERROR_INSTALL_FAILURE          =  1603L;  // Fatal error during installation.
     public const long ERROR_INSTALL_SUSPEND          =  1604L;  // Installation suspended, incomplete.
// LOCALIZE BEGIN:
     public const long  ERROR_UNKNOWN_PRODUCT         =  1605L;  // This action is only valid for products that are currently installed.
// LOCALIZE END
     public const long  ERROR_UNKNOWN_FEATURE         =  1606L;  // Feature ID not registered.
     public const long  ERROR_UNKNOWN_COMPONENT       =  1607L;  // Component ID not registered.
     public const long  ERROR_UNKNOWN_PROPERTY        =  1608L;  // Unknown property.
     public const long  ERROR_INVALID_HANDLE_STATE    =  1609L;  // Handle is in an invalid state.
// LOCALIZE BEGIN:
     public const long  ERROR_BAD_CONFIGURATION            =  1610L;  // The configuration data for this product is corrupt.  Contact your support personnel.
// LOCALIZE END:
     public const long  ERROR_INDEX_ABSENT                 =  1611L;  // Component qualifier not present.
// LOCALIZE BEGIN:
     public const long  ERROR_INSTALL_SOURCE_ABSENT        =  1612L;  // The installation source for this product is not available.  Verify that the source exists and that you can access it.
// LOCALIZE END;;
     public const long  ERROR_PRODUCT_UNINSTALLED          =  1614L;  // Product is uninstalled.
     public const long  ERROR_BAD_QUERY_SYNTAX             =  1615L;  // SQL query syntax invalid or unsupported.
     public const long  ERROR_INVALID_FIELD                =  1616L;  // Record field does not exist.
//endif

// LOCALIZE BEGIN:
//ifndef ERROR_INSTALL_SERVICE_FAILURE
     public const long  ERROR_INSTALL_SERVICE_FAILURE      =  1601L; // The Windows Installer service could not be accessed.  Contact your support personnel to verify that the Windows Installer service is properly registered.
     public const long  ERROR_INSTALL_PACKAGE_VERSION      =  1613L; // This installation package cannot be installed by the Windows Installer service.  You must install a Windows service pack that contains a newer version of the Windows Installer service.
     public const long  ERROR_INSTALL_ALREADY_RUNNING      =  1618L; // Another installation is already in progress.  Complete that installation before proceeding with this install.
     public const long  ERROR_INSTALL_PACKAGE_OPEN_FAILED  =  1619L; // This installation package could not be opened.  Verify that the package exists and that you can access it, or contact the application vendor to verify that this is a valid Windows Installer package.
     public const long  ERROR_INSTALL_PACKAGE_INVALID      =  1620L; // This installation package could not be opened.  Contact the application vendor to verify that this is a valid Windows Installer package.
     public const long  ERROR_INSTALL_UI_FAILURE           =  1621L; // There was an error starting the Windows Installer service user interface.  Contact your support personnel.
     public const long  ERROR_INSTALL_LOG_FAILURE          =  1622L; // Error opening installation log file.  Verify that the specified log file location exists and is writable.
     public const long  ERROR_INSTALL_LANGUAGE_UNSUPPORTED =  1623L; // This language of this installation package is not supported by your system.
     public const long  ERROR_INSTALL_PACKAGE_REJECTED     =  1625L; // The system administrator has set policies to prevent this installation.
// LOCALIZE END

     public const long  ERROR_FUNCTION_NOT_CALLED          =  1626L; // Function could not be executed.
     public const long  ERROR_FUNCTION_FAILED              =  1627L; // Function failed during execution.
     public const long  ERROR_INVALID_TABLE                =  1628L; // Invalid or unknown table specified.
     public const long  ERROR_DATATYPE_MISMATCH            =  1629L; // Data supplied is of wrong type.
     public const long  ERROR_UNSUPPORTED_TYPE             =  1630L; // Data of this type is not supported.
// LOCALIZE BEGIN:;
     public const long  ERROR_CREATE_FAILED                =  1631L; // The Windows Installer service failed to start.  Contact your support personnel.
// LOCALIZE END:
//endif

// LOCALIZE BEGIN:
//ifndef ERROR_INSTALL_TEMP_UNWRITABLE      
     public const long  ERROR_INSTALL_TEMP_UNWRITABLE      =  1632L; // The Temp folder is on a drive that is full or is inaccessible. Free up space on the drive or verify that you have write permission on the Temp folder.
//endif

//ifndef ERROR_INSTALL_PLATFORM_UNSUPPORTED
     public const long  ERROR_INSTALL_PLATFORM_UNSUPPORTED =  1633L; // This installation package is not supported by this processor type. Contact your product vendor.
// endif
// LOCALIZE END

//ifndef ERROR_INSTALL_NOTUSED
     public const long  ERROR_INSTALL_NOTUSED              =  1634L; // Component not used on this machine
//endif

// LOCALIZE BEGIN:
//ifndef ERROR_INSTALL_TRANSFORM_FAILURE
     public const long  ERROR_INSTALL_TRANSFORM_FAILURE    =  1624L; // Error applying transforms.  Verify that the specified transform paths are valid.
//endif

//ifndef ERROR_PATCH_PACKAGE_OPEN_FAILED
     public const long  ERROR_PATCH_PACKAGE_OPEN_FAILED    =  1635L; // This patch package could not be opened.  Verify that the patch package exists and that you can access it, or contact the application vendor to verify that this is a valid Windows Installer patch package.
     public const long  ERROR_PATCH_PACKAGE_INVALID        =  1636L; // This patch package could not be opened.  Contact the application vendor to verify that this is a valid Windows Installer patch package.
     public const long  ERROR_PATCH_PACKAGE_UNSUPPORTED    =  1637L; // This patch package cannot be processed by the Windows Installer service.  You must install a Windows service pack that contains a newer version of the Windows Installer service.
//endif

//ndef ERROR_PRODUCT_VERSION
     public const long  ERROR_PRODUCT_VERSION              =  1638L;// Another version of this product is already installed.  Installation of this version cannot continue.  To configure or remove the existing version of this product, use Add/Remove Programs on the Control Panel.
//endif

//ifndef ERROR_INVALID_COMMAND_LINE
     public const long  ERROR_INVALID_COMMAND_LINE         =  1639L; // Invalid command line argument.  Consult the Windows Installer SDK for detailed command line help.
//endif

// The following three error codes are not returned from MSI version 1.0

//ifndef ERROR_INSTALL_REMOTE_DISALLOWED
     public const long  ERROR_INSTALL_REMOTE_DISALLOWED    =  1640L; // Configuration of this product is not permitted from remote sessions. Contact your administrator.
//endif

// LOCALIZE END

//ifndef ERROR_SUCCESS_REBOOT_INITIATED
     public const long  ERROR_SUCCESS_REBOOT_INITIATED     =  1641L; // The requested operation completed successfully.  The system will be restarted so the changes can take effect.
//endif

// LOCALIZE BEGIN:
//ifndef ERROR_PATCH_TARGET_NOT_FOUND
     public const long  ERROR_PATCH_TARGET_NOT_FOUND       =  1642L; // The upgrade patch cannot be installed by the Windows Installer service because the program to be upgraded may be missing, or the upgrade patch may update a different version of the program. Verify that the program to be upgraded exists on your computer and that you have the correct upgrade patch.
//endif
// LOCALIZE END

// The following two error codes are not returned from MSI version 1.0, 1.1. or 1.2

// LOCALIZE BEGIN:
//ifndef ERROR_PATCH_PACKAGE_REJECTED
     public const long  ERROR_PATCH_PACKAGE_REJECTED       =  1643L; // The patch package is not permitted by system policy.  It is not signed with an appropriate certificate.
//endif

//ifndef ERROR_INSTALL_TRANSFORM_REJECTED
     public const long  ERROR_INSTALL_TRANSFORM_REJECTED   =  1644L; // One or more customizations are not permitted by system policy.  They are not signed with an appropriate certificate.
//endif
// LOCALIZE END

	  public MsiCheck ()
	  {

	  }


	public static void CheckEx (long ErrorCode)
    {
       switch(ErrorCode)
       {
         case ERROR_INSTALL_USEREXIT            :
         	throw new  MsiException("User cancel installation.");
         case ERROR_INSTALL_FAILURE             :
         	throw new  MsiException("Fatal error during installation.");
         case ERROR_INSTALL_SUSPEND             :
            throw new  MsiException("Installation suspended, incomplete.");
         case ERROR_UNKNOWN_PRODUCT             :
            throw new  MsiException("This action is only valid for products that are currently installed.");
         case ERROR_UNKNOWN_FEATURE             :
            throw new  MsiException("Feature ID not registered.");
         case ERROR_UNKNOWN_COMPONENT           :
            throw new  MsiException("Component ID not registered.");
         case ERROR_UNKNOWN_PROPERTY            :
            throw new  MsiException("Unknown property.");
         case ERROR_INVALID_HANDLE_STATE        :
            throw new  MsiException("Handle is in an invalid state.");
         case ERROR_BAD_CONFIGURATION           :     
            throw new  MsiException("The configuration data for this product is corrupt.  Contact your support personnel.");
         case ERROR_INDEX_ABSENT                :   
            throw new  MsiException("Component qualifier not present.");
         case ERROR_INSTALL_SOURCE_ABSENT       :   
            throw new  MsiException("The installation source for this product is not available.  Verify that the source exists and that you can access it.");
         case ERROR_PRODUCT_UNINSTALLED         :    
            throw new  MsiException("Product is uninstalled.");
         case ERROR_BAD_QUERY_SYNTAX            :    
            throw new  MsiException("SQL query syntax invalid or unsupported.");
         case ERROR_INVALID_FIELD               :    
            throw new  MsiException("Record field does not exist.");
         case ERROR_INSTALL_SERVICE_FAILURE     :     
            throw new  MsiException("The Windows Installer service could not be accessed.  Contact your support personnel to verify that the Windows Installer service is properly registered.");
         case ERROR_INSTALL_PACKAGE_VERSION     :      
            throw new  MsiException("This installation package cannot be installed by the Windows Installer service.  You must install a Windows service pack that contains a newer version of the Windows Installer service.");
         case ERROR_INSTALL_ALREADY_RUNNING     :     
            throw new  MsiException("Another installation is already in progress.  Complete that installation before proceeding with this install.");
         case ERROR_INSTALL_PACKAGE_OPEN_FAILED :
            throw new  MsiException("This installation package could not be opened.  Verify that the package exists and that you can access it, or contact the application vendor to verify that this is a valid Windows Installer package.");
         case ERROR_INSTALL_PACKAGE_INVALID     :
            throw new  MsiException("This installation package could not be opened.  Contact the application vendor to verify that this is a valid Windows Installer package.");
         case ERROR_INSTALL_UI_FAILURE          :
            throw new  MsiException("There was an error starting the Windows Installer service user interface.  Contact your support personnel.");
         case ERROR_INSTALL_LOG_FAILURE         :
            throw new  MsiException("Error opening installation log file.  Verify that the specified log file location exists and is writable.");
         case ERROR_INSTALL_LANGUAGE_UNSUPPORTED  :
            throw new  MsiException("This language of this installation package is not supported by your system.");
         case ERROR_INSTALL_PACKAGE_REJECTED      :
            throw new  MsiException("The system administrator has set policies to prevent this installation.");
         case ERROR_FUNCTION_NOT_CALLED           :
            throw new  MsiException("Function could not be executed.");
         case ERROR_FUNCTION_FAILED               :
            throw new  MsiException(" Function failed during execution.");
         case ERROR_INVALID_TABLE                 :
            throw new  MsiException("Invalid or unknown table specified.");
         case ERROR_DATATYPE_MISMATCH             :
            throw new  MsiException("Data supplied is of wrong type.");
         case ERROR_UNSUPPORTED_TYPE              :  
            throw new  MsiException("Data of this type is not supported.");
         case ERROR_CREATE_FAILED                 :
            throw new  MsiException("The Windows Installer service failed to start.  Contact your support personnel.");
         case ERROR_INSTALL_TEMP_UNWRITABLE       :
            throw new  MsiException("The Temp folder is on a drive that is full or is inaccessible. Free up space on the drive or verify that you have write permission on the Temp folder.");
         case ERROR_INSTALL_PLATFORM_UNSUPPORTED  :
            throw new  MsiException("This installation package is not supported by this processor type. Contact your product vendor.");
         case ERROR_INSTALL_NOTUSED               :
            throw new  MsiException("Component not used on this machine");
         case ERROR_INSTALL_TRANSFORM_FAILURE     :
            throw new  MsiException("Error applying transforms.  Verify that the specified transform paths are valid.");
         case ERROR_PATCH_PACKAGE_OPEN_FAILED     :
            throw new  MsiException("This patch package could not be opened.  Verify that the patch package exists and that you can access it, or contact the application vendor to verify that this is a valid Windows Installer patch package.");
         case ERROR_PATCH_PACKAGE_INVALID         :
            throw new  MsiException("This patch package could not be opened.  Contact the application vendor to verify that this is a valid Windows Installer patch package.");
         case ERROR_PATCH_PACKAGE_UNSUPPORTED     :
            throw new  MsiException("This patch package cannot be processed by the Windows Installer service.  You must install a Windows service pack that contains a newer version of the Windows Installer service.");
         case ERROR_PRODUCT_VERSION               :
            throw new  MsiException("Another version of this product is already installed.  Installation of this version cannot continue.  To configure or remove the existing version of this product, use Add/Remove Programs on the Control Panel.");
         case ERROR_INVALID_COMMAND_LINE          :
            throw new  MsiException("Invalid command line argument.  Consult the Windows Installer SDK for detailed command line help.");
         case ERROR_INSTALL_REMOTE_DISALLOWED     :
            throw new  MsiException("Configuration of this product is not permitted from remote sessions. Contact your administrator.");
         case ERROR_SUCCESS_REBOOT_INITIATED      :
            throw new  MsiException("The requested operation completed successfully.  The system will be restarted so the changes can take effect.");
         case ERROR_PATCH_TARGET_NOT_FOUND        :
            throw new  MsiException("The upgrade patch cannot be installed by the Windows Installer service because the program to be upgraded may be missing, or the upgrade patch may update a different version of the program. Verify that the program to be upgraded exists on your computer and that you have the correct upgrade patch.");
         case ERROR_PATCH_PACKAGE_REJECTED        :
            throw new  MsiException("The patch package is not permitted by system policy.  It is not signed with an appropriate certificate.");
         case ERROR_INSTALL_TRANSFORM_REJECTED    :
            throw new  MsiException("One or more customizations are not permitted by system policy.  They are not signed with an appropriate certificate.");
 	
     	
     	
     }
     
     
     
   }
   
  ~MsiCheck()
  {
    
  }
  
    
 }
	#endregion
 
	#region MsiDBCheck
public class MsiDBCheck 
 {
   
     
    // public enum MSIDBERROR : int
    // {
	public const int    MSIDBERROR_INVALIDARG        = -3; //  invalid argument
	public const int	MSIDBERROR_MOREDATA          = -2; //  buffer too small
	public const int	MSIDBERROR_FUNCTIONERROR     = -1; //  function error
	public const int	MSIDBERROR_NOERROR           = 0;  //  no error
	public const int	MSIDBERROR_DUPLICATEKEY      = 1;  //  new record duplicates primary keys of existing record in table
	public const int	MSIDBERROR_REQUIRED          = 2;  //  non-nullable column; no null values allowed
	public const int	MSIDBERROR_BADLINK           = 3;  //  corresponding record in foreign table not found
	public const int	MSIDBERROR_OVERFLOW          = 4;  //  data greater than maximum value allowed
	public const int	MSIDBERROR_UNDERFLOW         = 5;  //  data less than minimum value allowed
	public const int	MSIDBERROR_NOTINSET          = 6;  //  data not a member of the values permitted in the set
	public const int	MSIDBERROR_BADVERSION        = 7;  //  invalid version string
	public const int	MSIDBERROR_BADCASE           = 8;  //  invalid case; must be all upper-case or all lower-case
	public const int	MSIDBERROR_BADGUID           = 9;  //  invalid GUID
	public const int	MSIDBERROR_BADWILDCARD       = 10; //  invalid wildcardfilename or use of wildcards
	public const int	MSIDBERROR_BADIDENTIFIER     = 11; //  bad identifier
	public const int	MSIDBERROR_BADLANGUAGE       = 12; //  bad language Id(s)
	public const int	MSIDBERROR_BADFILENAME       = 13; //  bad filename
	public const int	MSIDBERROR_BADPATH           = 14; //  bad path
	public const int	MSIDBERROR_BADCONDITION      = 15; //  bad conditional statement
	public const int	MSIDBERROR_BADFORMATTED      = 16; //  bad format string
	public const int	MSIDBERROR_BADTEMPLATE       = 17; //  bad template string
	public const int	MSIDBERROR_BADDEFAULTDIR     = 18; //  bad string in DefaultDir column of Directory table
	public const int	MSIDBERROR_BADREGPATH        = 19; //  bad registry path string
	public const int	MSIDBERROR_BADCUSTOMSOURCE   = 20; //  bad string in CustomSource column of CustomAction table
	public const int	MSIDBERROR_BADPROPERTY       = 21; //  bad property string
	public const int	MSIDBERROR_MISSINGDATA       = 22; //  _Validation table missing reference to column
	public const int	MSIDBERROR_BADCATEGORY       = 23; //  Category column of _Validation table for column is invalid
    public const int    MSIDBERROR_BADKEYTABLE       = 24; //  table in KeyTable column of _Validation table could not be found/loaded
	public const int	MSIDBERROR_BADMAXMINVALUES   = 25; //  value in MaxValue column of _Validation table is less than value in MinValue column
	public const int	MSIDBERROR_BADCABINET        = 26; //  bad cabinet name
	public const int	MSIDBERROR_BADSHORTCUT       = 27; //  bad shortcut target
	public const int	MSIDBERROR_STRINGOVERFLOW    = 28; //  string overflow (greater than length allowed in column def)
	public const int	MSIDBERROR_BADLOCALIZEATTRIB = 29;  //  invalid localization attribute (primary keys cannot be localized)
     //}
     
	public MsiDBCheck ()
	{
	}
	
	public static void CheckEx (int ErrorCode)
     {
     
     switch(ErrorCode)
     {
        case MSIDBERROR_INVALIDARG      :
        	    throw new  MsiDBException("invalid argument");
		case MSIDBERROR_MOREDATA        :
			    throw new  MsiDBException("buffer too small");
		case MSIDBERROR_FUNCTIONERROR   :
			    throw new  MsiDBException("function error");
		//case  MSIDBERROR_NOERROR       :
		//        throw new  MsiException("no error"); 
		case  MSIDBERROR_DUPLICATEKEY    :
			    throw new  MsiDBException("new record duplicates primary keys of existing record in table");
		case  MSIDBERROR_REQUIRED        :
			    throw new  MsiDBException("non-nullable column, no null values allowed");
		case  MSIDBERROR_BADLINK         :
			    throw new  MsiDBException("corresponding record in foreign table not found");
		case  MSIDBERROR_OVERFLOW        :
			    throw new  MsiDBException("data greater than maximum value allowed");
		case  MSIDBERROR_UNDERFLOW       :
			    throw new  MsiDBException("data less than minimum value allowed");
		case  MSIDBERROR_NOTINSET        :
			    throw new  MsiDBException("data not a member of the values permitted in the set");
		case  MSIDBERROR_BADVERSION      :
	            throw new  MsiDBException("invalid version string");
		case  MSIDBERROR_BADCASE         :
			    throw new  MsiDBException("invalid case, must be all upper-case or all lower-case");
		case  MSIDBERROR_BADGUID         :
			    throw new  MsiDBException("invalid GUID");
		case  MSIDBERROR_BADWILDCARD     :
			    throw new  MsiDBException("invalid wildcardfilename or use of wildcards");
		case  MSIDBERROR_BADIDENTIFIER   :
			    throw new  MsiDBException("bad identifier");
		case  MSIDBERROR_BADLANGUAGE     :
			    throw new  MsiDBException("bad language Id(s)");
		case  MSIDBERROR_BADFILENAME     :
			    throw new  MsiDBException("bad filename");
		case  MSIDBERROR_BADPATH         :
			    throw new  MsiDBException("bad path");
		case  MSIDBERROR_BADCONDITION    :
			    throw new  MsiDBException("bad conditional statement");
		case  MSIDBERROR_BADFORMATTED    :
			    throw new  MsiDBException("bad format string");
		case  MSIDBERROR_BADTEMPLATE     :
			    throw new  MsiDBException("bad template string");
		case  MSIDBERROR_BADDEFAULTDIR   :
			    throw new  MsiDBException("bad string in DefaultDir column of Directory table");
		case  MSIDBERROR_BADREGPATH      :
			    throw new  MsiDBException("bad registry path string");
		case  MSIDBERROR_BADCUSTOMSOURCE :
			    throw new  MsiDBException("bad string in CustomSource column of CustomAction table");
		case  MSIDBERROR_BADPROPERTY     :
			    throw new  MsiDBException("bad property string");
		case  MSIDBERROR_MISSINGDATA     :
			    throw new  MsiDBException("Validation table missing reference to column");
		case  MSIDBERROR_BADCATEGORY     :
			    throw new  MsiDBException("Category column of _Validation table for column is invalid");
		case  MSIDBERROR_BADKEYTABLE     :
			    throw new  MsiDBException("table in KeyTable column of _Validation table could not be found/loaded");
		case  MSIDBERROR_BADMAXMINVALUES :
			    throw new  MsiDBException("value in MaxValue column of _Validation table is less than value in MinValue column");
		case  MSIDBERROR_BADCABINET      :
			    throw new  MsiDBException("bad cabinet name");
		case  MSIDBERROR_BADSHORTCUT     :
			    throw new  MsiDBException("bad shortcut target");
		case  MSIDBERROR_STRINGOVERFLOW  :
			    throw new  MsiDBException("string overflow (greater than length allowed in column def)");
		case  MSIDBERROR_BADLOCALIZEATTRIB  :
			    throw new  MsiDBException("invalid localization attribute (primary keys cannot be localized)");
    	
    } // switch(ErrorCode)
   
   
   }
   
   
  ~MsiDBCheck()
  {
     
  }
  
 }
	#endregion
	
	#endregion
}
