// <file>
//     <copyright see=""/>
//     <license see=""/>
//     <owner name="Youseful Software" email="support@youseful.com"/>
//     <version value="$version"/>
// </file>
using System;
using System.Runtime.Serialization;


namespace Youseful.Exceptions.Win32
{

	[Serializable]
	public class Win32Exception : Exception, ISerializable
	{
		private string _ErrorMessage;
		private long _ErrorCode =-1; 
	
		public Win32Exception (string errorMessage) : base(errorMessage)
		{
		
		}	

		public Win32Exception (string errorMessage,long errorCode) : base(errorMessage)
		{
			_ErrorCode = errorCode;
		}	

		public Win32Exception () : base()
		{
		
		}	
		
		public Win32Exception (string errorMessage, Exception innerException) 
			: base(errorMessage, innerException)
		{
		
		}	

		public string ErrorMessage { get { return _ErrorMessage;}}

		public long ErrorCode { get { return _ErrorCode;}}

		public override string Message
		{
			get
			{
				string msg = base.Message;
				if (_ErrorMessage != null)
					msg += Environment.NewLine + "Win32 API: " + _ErrorMessage;
				return msg;
			}
		}

		protected Win32Exception(SerializationInfo info,
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

		public Win32Exception(string message, string errormessage,
			Exception innerException) : this(message, innerException)
		{
			this._ErrorMessage = errormessage;
		}
			
	}
  //must be public to test for specific errors
	public class Win32Check 
	{
		
		public const long ERROR_NO_MORE_ITEMS         =  259L;
		

		public  Win32Check ()
		{

		}


		public static void CheckEx (long ErrorCode)
		{
			//switch(ErrorCode)
			//{
			//	case ERROR_NO_MORE_ITEMS            :
			//		throw new  Win32Exception("Error No More Items" ,ERROR_NO_MORE_ITEMS);
				
			//}
     
     
     
		}
   
		~Win32Check()
		{
    
		}
  
    
	}




}