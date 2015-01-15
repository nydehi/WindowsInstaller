//This file contains attributes and types that are basic to Interop implemented in .NET
using System;


namespace Youseful.WinAPI
{
	[Flags]
	public enum OS
	{
        None  = 0x0000,
        WinVista = 0x0001,
        Win95	 = 0x0001,
		Win98	 = 0x0002,
		Win98SE  = 0x0004,
		WinME    = 0x0008,
		WinCE    = 0x0010,
		WinNT	 = 0x0020,
		WinXP    = 0x0040,
		Win2k	 = 0x0080,
		Win2k3   = 0x0100,
	}

	public enum XPEdition
	{
		Home,
		Professional,
		NA
	}
	
	public enum Win2kEdition
	{
		//Standard,
		Professional,
		Server
	}


    




}