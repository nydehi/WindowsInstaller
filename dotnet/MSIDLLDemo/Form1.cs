using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Youseful.Installer.Nativemsi;

namespace MSIDLLDemo
{
    public partial class Form1 : Form
    {

        private IntPtr preview_handle = IntPtr.Zero;
        private IntPtr db_handle = IntPtr.Zero;
        private IntPtr nil = IntPtr.Zero;
        private System.Windows.Forms.TabControl tabControl1;
        private System.Windows.Forms.TabPage tabPage1;
        private System.Windows.Forms.Button btnQuery;
        private System.Windows.Forms.ListBox LBDialogs;
        private System.Windows.Forms.Button btnViewDialog;
        private System.Windows.Forms.Button btnCloseDialog;
        private System.Windows.Forms.Button btnOpenDatabase;
        private System.Windows.Forms.TabPage tabPage2;
        private System.Windows.Forms.ListBox LBProducts;
        private System.Windows.Forms.Button btnListProducts;
        //	public string  MsiData;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label lblProductName;
        private System.Windows.Forms.TabPage tabPage3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.OpenFileDialog OFDmsi;
        private System.Windows.Forms.TextBox txtMsidll;
        private int product_installed_count = 0;
        private System.Windows.Forms.Button btnSummaryInfo;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TabPage tabPage5;
        private System.Windows.Forms.TextBox txtQuery;
        private System.Windows.Forms.Button btnCustomQuery;
        private System.Windows.Forms.TabPage tabPage4;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.RadioButton rbCreate;
        private System.Windows.Forms.RadioButton rbDrop;
        private string dbpath;
       

        //public System.Windows.Forms.MessageBox MSB;  

        public Form1()
        {
            InitializeComponent();
        }
        private void btnQuery_Click(object sender, System.EventArgs e)
		{
			
			IntPtr view_handle = IntPtr.Zero;
			
            IntPtr record_handle = IntPtr.Zero;
			int buffer_length = 255;

            int Hresult = Msidll.MsiDatabaseOpenView(db_handle, "SELECT * FROM `Dialog`", out view_handle);
            Hresult = Msidll.MsiViewExecute(view_handle, nil);
            Hresult = Msidll.MsiViewFetch(view_handle, out record_handle);
			//int field_count = Msidll.MsiRecordGetFieldCount(record_handle);
			
			//Now we loop thru all the fields in a record in the Dialog table.
			//for(int i = 0; i < dialog_count; i++)
			//{
            //  
            //}
			//Hresult = Msidll.MsiRecordGetString (record_handle, 1,  dialog_buffer, ref buffer_length);
          //Loop thru and grab all the dialog names
			LBDialogs.BeginUpdate();
			while (IntPtr.Zero != record_handle)
			{
			  buffer_length = 1;
              Hresult = Msidll.MsiRecordGetString(record_handle, 1, null, ref buffer_length);
              buffer_length = buffer_length + 1; 
			  StringBuilder dialog_buffer = new StringBuilder (buffer_length);
              Hresult = Msidll.MsiRecordGetString (record_handle, 1,dialog_buffer, ref buffer_length);
              LBDialogs.Items.Add(dialog_buffer.ToString());
		  	  Hresult = Msidll.MsiViewFetch (view_handle, out record_handle);
		  	}
			LBDialogs.EndUpdate();
			Hresult = Msidll.MsiViewClose (view_handle);
			
			//return dialog_buffer.Substring(0, buffer_length); 
		}

		private void btnOpenDatabase_Click(object sender, System.EventArgs e)
		{
          DialogResult return_value = OFDmsi.ShowDialog();
          dbpath = OFDmsi.FileName;//"C:\\DevTools\\Sample.msi";
		  txtMsidll.Text = dbpath;//Msidll.MsidllOPEN_DIRECT
		  int Hresult =  Msidll.MsiOpenDatabase (dbpath,Msidll.MsidbOPEN.TRANSACT, out db_handle);
		}

		private void btnViewDialog_Click(object sender, System.EventArgs e)
		{   //"WelcomeDlg"
			int Hresult = Msidll.MsiEnableUIPreview(db_handle,ref preview_handle);
			if( -1 == LBDialogs.SelectedIndex)
                return;
			string v12 = (string) LBDialogs.Items[LBDialogs.SelectedIndex];
			Hresult = Msidll.MsiPreviewDialog(preview_handle,v12);
		}

		private void btnCloseDialog_Click(object sender, System.EventArgs e)
		{
		   int Hresult = Msidll.MsiPreviewDialog(preview_handle,"");
		   Hresult = Msidll.MsiCloseHandle(preview_handle);
		}

		
		private void button1_Click(object sender, System.EventArgs e)
		{
		   MessageBox.Show((string) LBDialogs.Items[LBDialogs.SelectedIndex]);
		}

		private void btnListProducts_Click(object sender, System.EventArgs e)
		{			 
			IntPtr view_handle = IntPtr.Zero;
			IntPtr nil = IntPtr.Zero;
			IntPtr record_handle = IntPtr.Zero;
			int product_index = 0;
			int buffer_length = 255;
		    int Hresult  = 0;  
		           	
			LBProducts.BeginUpdate();
			while (0 == Hresult)
			{
				buffer_length = 39;
				byte[] product_buffer = new byte[buffer_length];
				Hresult = Msidll.MsiEnumProducts(product_index,product_buffer);
				if (0 == Hresult)
				  LBProducts.Items.Add(product_buffer);
				product_index++;
			}
			LBProducts.EndUpdate();
	
		}

		private void LBProducts_SelectedIndexChanged(object sender, System.EventArgs e)
		{
			int buffer_length= 64;
            StringBuilder productname_buffer = new StringBuilder();
			string product_guid = (string) LBProducts.Items[LBProducts.SelectedIndex];
            int Hresult = Msidll.MsiGetProductInfo(product_guid, Msidll.INSTALLPROPERTY_INSTALLEDPRODUCTNAME,
              productname_buffer, ref buffer_length);           
            lblProductName.Text = productname_buffer.ToString();
            productname_buffer = new StringBuilder();
            Hresult = Msidll.MsiGetProductInfo(product_guid, Msidll.INSTALLPROPERTY_VERSIONSTRING,
             productname_buffer, ref buffer_length);
            lblVersion.Text = productname_buffer.ToString();
		}

		private void btnSummaryInfo_Click(object sender, System.EventArgs e)
		{
		   int update_count = 11;
		   IntPtr summary_handle = IntPtr.Zero;
		   int Datatype =1;
		   int Valuetype;
		   Valuetype = 255;
		   System.Runtime.InteropServices.ComTypes.FILETIME file_time = new System.Runtime.InteropServices.ComTypes.FILETIME() ;
		   int ValueInt=255;
		   
		   
		   int Hresult = Msidll.MsiGetSummaryInformation(db_handle,"",update_count,ref summary_handle);
		   Hresult = Msidll.MsiSummaryInfoGetProperty(summary_handle,Msidll.PID_TITLE,ref Datatype,
                                                    ref Valuetype,ref file_time, null,ref ValueInt);
           StringBuilder Value = new StringBuilder(ValueInt+1);
           Hresult = Msidll.MsiSummaryInfoGetProperty(summary_handle, Msidll.PID_TITLE, ref Datatype,
                                                   ref Valuetype, ref file_time, Value, ref ValueInt); 
		   Hresult = Msidll.MsiSummaryInfoPersist(summary_handle);
		}

		
		private void button2_Click_1(object sender, System.EventArgs e)
		{
			string Q1 = "CREATE TABLE `XDirectory` (`Directory` CHAR(72) NOT NULL, `Directory_Parent` CHAR(72), `DefaultDir` CHAR(255) NOT NULL LOCALIZABLE PRIMARY KEY `Directory`)";
			string Q2 = "DROP TABLE `XDirectory`";
			IntPtr view_handle = IntPtr.Zero;

			if(rbCreate.Checked)
			{
				int Hresult = Msidll.MsiDatabaseOpenView (db_handle,Q2 , out view_handle);
				Hresult = Msidll.MsiViewExecute (view_handle, nil);
				Hresult = Msidll.MsiViewClose (view_handle);
				Hresult = Msidll.MsiDatabaseCommit(db_handle);

			}
			if(rbDrop.Checked)
			{
				int Hresult = Msidll.MsiDatabaseOpenView (db_handle,Q2 , out view_handle);
				Hresult = Msidll.MsiViewExecute (view_handle, nil);
				Hresult = Msidll.MsiViewClose (view_handle);
				Hresult = Msidll.MsiDatabaseCommit(db_handle);

			}
		}

        private void btnListTables_Click(object sender, EventArgs e)
        {
            IntPtr view_handle = IntPtr.Zero;
            IntPtr nil = IntPtr.Zero;
            IntPtr record_handle = IntPtr.Zero;
            int product_index = 0;
            int buffer_length = 255;
            int Hresult = 0;
            string Q2 = "Select `Name` from `_Tables`";

            Hresult = Msidll.MsiDatabaseOpenView(db_handle, Q2, out view_handle);
            Hresult = Msidll.MsiViewExecute(view_handle, nil);
            Hresult = Msidll.MsiViewFetch(view_handle, out record_handle);
            lbTables.BeginUpdate();
            while (0 == Hresult)
            {

                buffer_length = 1;
                StringBuilder dialog_buffer = new StringBuilder();
                //Now we get each individual field
                Hresult = Msidll.MsiRecordGetString(record_handle, 1, dialog_buffer, ref buffer_length);
                buffer_length = buffer_length + 1;
                dialog_buffer = new StringBuilder();
                Hresult = Msidll.MsiRecordGetString(record_handle, 1, dialog_buffer, ref buffer_length);
                 if (0 == Hresult)
                    lbTables.Items.Add(dialog_buffer.ToString().Trim('\0'));

                Hresult = Msidll.MsiViewFetch(view_handle, out record_handle);
               
            }             
            Hresult = Msidll.MsiViewClose(view_handle);                 
            lbTables.EndUpdate();
        }
	

    }
}
