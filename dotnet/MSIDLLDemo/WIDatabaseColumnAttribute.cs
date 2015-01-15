using System;
using System.Reflection;
using Youseful.Installer.Nativemsi;


namespace Youseful.Installer.Base
{
    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false, Inherited = false)]
    public class WIDatabaseColumnAttribute : System.Attribute
    {
        private string _ColumnName;
        private Data_Types _DataType;
        private bool _Nullable;
        private bool _PrimaryKey;
        private WindowsInstallerVersion _Version;

        public WIDatabaseColumnAttribute(string ColumnName)
        {
            this._ColumnName = ColumnName;
        }

        public string ColumnName
        {
            get { return _ColumnName; }
        }

        public Data_Types DataType
        {
            get { return _DataType; }
            set { _DataType = value; }
        }

        public bool Nullable
        {
            get { return _Nullable; }
            set { _Nullable = value; }
        }

        public bool PrimaryKey
        {
            get { return _PrimaryKey; }
            set { _PrimaryKey = value; }
        }

        public WindowsInstallerVersion Version
        {
            get
            { return _Version; }
            set { _Version = value; }
        }
    }

    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false, Inherited = false)]
    public class WITableAttribute : System.Attribute
    {
        private string _TableName;
        private WindowsInstallerVersion _Version;


        public WITableAttribute(string TableName)
        {
            this._TableName = TableName;
        }

        public string TableName
        {
            get { return _TableName; }
        }

        public WindowsInstallerVersion Version
        {
            get
            { return _Version; }
            set { _Version = value; }
        }
    }
}
