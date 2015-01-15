using System;
using System.Collections.Generic;
using System.Text;

namespace Youseful.WinAPI.Interop
{
    [AttributeUsage(AttributeTargets.Enum | AttributeTargets.Method | AttributeTargets.Struct
         | AttributeTargets.Interface, AllowMultiple = false,
         Inherited = false)]
    public class WinAPIAttribute : System.Attribute
    {
        private OS _Version;
        private XPEdition _XPEdition;
        private string _FileName;
        private OS _UpgradeVersion;

        public WinAPIAttribute(OS version)
        {
            this._Version = version;
            this._XPEdition = XPEdition.NA;
        }

        public OS UpgradeVersion
        {
            get
            { return _UpgradeVersion; }
            set
            { _UpgradeVersion = value; }
        }

        public string FileName
        {
            get { return _FileName; }
            set { _FileName = value; }
        }


        public OS Version
        {
            get
            { return _Version; }
            //set	{ _Version = value;}
        }

        public XPEdition XP_Edition
        {
            get { return _XPEdition; }
            set { _XPEdition = value; }
        }



    }
}
