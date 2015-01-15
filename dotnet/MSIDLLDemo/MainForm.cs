// project created on 4/24/2003 at 12:46 PM
using System;
using System.Windows.Forms;
using System.Runtime.InteropServices;
using Youseful.Installer.Nativemsi;
//using Youseful.Installer.WindowsInstaller.Exceptions;


namespace MyFormProject 
{
	class MainForm : System.Windows.Forms.Form
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
		private System.Windows.Forms.TextBox txtMsidb;
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
	//	Youseful.Installer.WindowsInstaller.Exceptions.MsiDBCheck  MsiDBChec;
		//Youseful.Installer.WindowsInstaller.Exceptions.MsiCheck  MsiChec;

		//public System.Windows.Forms.MessageBox MSB;  
		public MainForm()
		{
			InitializeComponent();
			
			
		}
	
		// This method is used in the forms designer.
		
		void InitializeComponent() {
			this.tabControl1 = new System.Windows.Forms.TabControl();
			this.tabPage1 = new System.Windows.Forms.TabPage();
			this.btnCloseDialog = new System.Windows.Forms.Button();
			this.btnViewDialog = new System.Windows.Forms.Button();
			this.LBDialogs = new System.Windows.Forms.ListBox();
			this.btnQuery = new System.Windows.Forms.Button();
			this.tabPage2 = new System.Windows.Forms.TabPage();
			this.lblProductName = new System.Windows.Forms.Label();
			this.label1 = new System.Windows.Forms.Label();
			this.LBProducts = new System.Windows.Forms.ListBox();
			this.btnListProducts = new System.Windows.Forms.Button();
			this.tabPage3 = new System.Windows.Forms.TabPage();
			this.label3 = new System.Windows.Forms.Label();
			this.btnSummaryInfo = new System.Windows.Forms.Button();
			this.label2 = new System.Windows.Forms.Label();
			this.tabPage5 = new System.Windows.Forms.TabPage();
			this.txtQuery = new System.Windows.Forms.TextBox();
			this.btnCustomQuery = new System.Windows.Forms.Button();
			this.tabPage4 = new System.Windows.Forms.TabPage();
			this.panel1 = new System.Windows.Forms.Panel();
			this.rbDrop = new System.Windows.Forms.RadioButton();
			this.rbCreate = new System.Windows.Forms.RadioButton();
			this.label4 = new System.Windows.Forms.Label();
			this.button2 = new System.Windows.Forms.Button();
			this.btnOpenDatabase = new System.Windows.Forms.Button();
			this.txtMsidb = new System.Windows.Forms.TextBox();
			this.OFDmsi = new System.Windows.Forms.OpenFileDialog();
			this.tabControl1.SuspendLayout();
			this.tabPage1.SuspendLayout();
			this.tabPage2.SuspendLayout();
			this.tabPage3.SuspendLayout();
			this.tabPage5.SuspendLayout();
			this.tabPage4.SuspendLayout();
			this.panel1.SuspendLayout();
			this.SuspendLayout();
			// 
			// tabControl1
			// 
			this.tabControl1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.tabControl1.Controls.Add(this.tabPage1);
			this.tabControl1.Controls.Add(this.tabPage3);
			this.tabControl1.Controls.Add(this.tabPage2);
			this.tabControl1.Controls.Add(this.tabPage5);
			this.tabControl1.Controls.Add(this.tabPage4);
			this.tabControl1.Location = new System.Drawing.Point(0, 64);
			this.tabControl1.Name = "tabControl1";
			this.tabControl1.SelectedIndex = 0;
			this.tabControl1.Size = new System.Drawing.Size(568, 344);
			this.tabControl1.TabIndex = 3;
			// 
			// tabPage1
			// 
			this.tabPage1.Controls.Add(this.btnCloseDialog);
			this.tabPage1.Controls.Add(this.btnViewDialog);
			this.tabPage1.Controls.Add(this.LBDialogs);
			this.tabPage1.Controls.Add(this.btnQuery);
			this.tabPage1.Location = new System.Drawing.Point(4, 22);
			this.tabPage1.Name = "tabPage1";
			this.tabPage1.Size = new System.Drawing.Size(560, 318);
			this.tabPage1.TabIndex = 0;
			this.tabPage1.Text = "List Dialogs";
			// 
			// btnCloseDialog
			// 
			this.btnCloseDialog.Location = new System.Drawing.Point(272, 48);
			this.btnCloseDialog.Name = "btnCloseDialog";
			this.btnCloseDialog.Size = new System.Drawing.Size(80, 23);
			this.btnCloseDialog.TabIndex = 5;
			this.btnCloseDialog.Text = "Close Dialog";
			this.btnCloseDialog.Click += new System.EventHandler(this.btnCloseDialog_Click);
			// 
			// btnViewDialog
			// 
			this.btnViewDialog.Location = new System.Drawing.Point(176, 48);
			this.btnViewDialog.Name = "btnViewDialog";
			this.btnViewDialog.TabIndex = 4;
			this.btnViewDialog.Text = "View Dialog";
			this.btnViewDialog.Click += new System.EventHandler(this.btnViewDialog_Click);
			// 
			// LBDialogs
			// 
			this.LBDialogs.Location = new System.Drawing.Point(8, 8);
			this.LBDialogs.Name = "LBDialogs";
			this.LBDialogs.Size = new System.Drawing.Size(152, 290);
			this.LBDialogs.TabIndex = 3;
			// 
			// btnQuery
			// 
			this.btnQuery.Location = new System.Drawing.Point(176, 16);
			this.btnQuery.Name = "btnQuery";
			this.btnQuery.Size = new System.Drawing.Size(184, 23);
			this.btnQuery.TabIndex = 1;
			this.btnQuery.Text = "Run Query to Get Dialog List";
			this.btnQuery.Click += new System.EventHandler(this.btnQuery_Click);
			// 
			// tabPage2
			// 
			this.tabPage2.Controls.Add(this.lblProductName);
			this.tabPage2.Controls.Add(this.label1);
			this.tabPage2.Controls.Add(this.LBProducts);
			this.tabPage2.Controls.Add(this.btnListProducts);
			this.tabPage2.Location = new System.Drawing.Point(4, 22);
			this.tabPage2.Name = "tabPage2";
			this.tabPage2.Size = new System.Drawing.Size(552, 318);
			this.tabPage2.TabIndex = 1;
			this.tabPage2.Text = "List Products";
			// 
			// lblProductName
			// 
			this.lblProductName.Location = new System.Drawing.Point(312, 48);
			this.lblProductName.Name = "lblProductName";
			this.lblProductName.Size = new System.Drawing.Size(184, 40);
			this.lblProductName.TabIndex = 3;
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(352, 24);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(100, 16);
			this.label1.TabIndex = 2;
			this.label1.Text = "ProductName";
			// 
			// LBProducts
			// 
			this.LBProducts.Location = new System.Drawing.Point(8, 8);
			this.LBProducts.Name = "LBProducts";
			this.LBProducts.Size = new System.Drawing.Size(136, 303);
			this.LBProducts.TabIndex = 1;
			this.LBProducts.SelectedIndexChanged += new System.EventHandler(this.LBProducts_SelectedIndexChanged);
			// 
			// btnListProducts
			// 
			this.btnListProducts.Location = new System.Drawing.Point(152, 8);
			this.btnListProducts.Name = "btnListProducts";
			this.btnListProducts.Size = new System.Drawing.Size(128, 23);
			this.btnListProducts.TabIndex = 0;
			this.btnListProducts.Text = "List Installed Products";
			this.btnListProducts.Click += new System.EventHandler(this.btnListProducts_Click);
			// 
			// tabPage3
			// 
			this.tabPage3.Controls.Add(this.label3);
			this.tabPage3.Controls.Add(this.btnSummaryInfo);
			this.tabPage3.Controls.Add(this.label2);
			this.tabPage3.Location = new System.Drawing.Point(4, 22);
			this.tabPage3.Name = "tabPage3";
			this.tabPage3.Size = new System.Drawing.Size(552, 318);
			this.tabPage3.TabIndex = 2;
			this.tabPage3.Text = "Summary Info";
			// 
			// label3
			// 
			this.label3.Location = new System.Drawing.Point(24, 48);
			this.label3.Name = "label3";
			this.label3.TabIndex = 2;
			// 
			// btnSummaryInfo
			// 
			this.btnSummaryInfo.Location = new System.Drawing.Point(272, 40);
			this.btnSummaryInfo.Name = "btnSummaryInfo";
			this.btnSummaryInfo.Size = new System.Drawing.Size(200, 24);
			this.btnSummaryInfo.TabIndex = 1;
			this.btnSummaryInfo.Text = "Get Summary Information";
			this.btnSummaryInfo.Click += new System.EventHandler(this.btnSummaryInfo_Click);
			// 
			// label2
			// 
			this.label2.Location = new System.Drawing.Point(8, 8);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(488, 16);
			this.label2.TabIndex = 0;
			this.label2.Text = "This page illustrates retrieving Summary Information for the Database Chosen abov" +
				"e";
			// 
			// tabPage5
			// 
			this.tabPage5.Controls.Add(this.txtQuery);
			this.tabPage5.Controls.Add(this.btnCustomQuery);
			this.tabPage5.Location = new System.Drawing.Point(4, 22);
			this.tabPage5.Name = "tabPage5";
			this.tabPage5.Size = new System.Drawing.Size(552, 318);
			this.tabPage5.TabIndex = 4;
			this.tabPage5.Text = "Custom Queries";
			// 
			// txtQuery
			// 
			this.txtQuery.Location = new System.Drawing.Point(16, 16);
			this.txtQuery.Multiline = true;
			this.txtQuery.Name = "txtQuery";
			this.txtQuery.Size = new System.Drawing.Size(136, 136);
			this.txtQuery.TabIndex = 2;
			this.txtQuery.Text = "";
			// 
			// btnCustomQuery
			// 
			this.btnCustomQuery.Location = new System.Drawing.Point(16, 192);
			this.btnCustomQuery.Name = "btnCustomQuery";
			this.btnCustomQuery.Size = new System.Drawing.Size(136, 23);
			this.btnCustomQuery.TabIndex = 0;
			this.btnCustomQuery.Text = "Execute Custom Query";
			// 
			// tabPage4
			// 
			this.tabPage4.Controls.Add(this.panel1);
			this.tabPage4.Controls.Add(this.label4);
			this.tabPage4.Controls.Add(this.button2);
			this.tabPage4.Location = new System.Drawing.Point(4, 22);
			this.tabPage4.Name = "tabPage4";
			this.tabPage4.Size = new System.Drawing.Size(552, 318);
			this.tabPage4.TabIndex = 5;
			this.tabPage4.Text = "Prebuilt Queries";
			// 
			// panel1
			// 
			this.panel1.Controls.Add(this.rbDrop);
			this.panel1.Controls.Add(this.rbCreate);
			this.panel1.Location = new System.Drawing.Point(0, 40);
			this.panel1.Name = "panel1";
			this.panel1.Size = new System.Drawing.Size(552, 128);
			this.panel1.TabIndex = 8;
			// 
			// rbDrop
			// 
			this.rbDrop.Location = new System.Drawing.Point(8, 64);
			this.rbDrop.Name = "rbDrop";
			this.rbDrop.Size = new System.Drawing.Size(224, 48);
			this.rbDrop.TabIndex = 1;
			this.rbDrop.Text = "DROP TABLE `XDirectory`";
			// 
			// rbCreate
			// 
			this.rbCreate.Location = new System.Drawing.Point(8, 16);
			this.rbCreate.Name = "rbCreate";
			this.rbCreate.Size = new System.Drawing.Size(536, 32);
			this.rbCreate.TabIndex = 0;
			this.rbCreate.Text = "CREATE TABLE `XDirectory` (`Directory` CHAR(72) NOT NULL, `Directory_Parent` CHAR" +
				"(72), `DefaultDir` CHAR(255) NOT NULL LOCALIZABLE PRIMARY KEY `Directory`)";
			// 
			// label4
			// 
			this.label4.Location = new System.Drawing.Point(80, 8);
			this.label4.Name = "label4";
			this.label4.Size = new System.Drawing.Size(272, 16);
			this.label4.TabIndex = 7;
			this.label4.Text = "Select a query  to run";
			// 
			// button2
			// 
			this.button2.Location = new System.Drawing.Point(192, 216);
			this.button2.Name = "button2";
			this.button2.Size = new System.Drawing.Size(88, 24);
			this.button2.TabIndex = 4;
			this.button2.Text = "DDL";
			this.button2.Click += new System.EventHandler(this.button2_Click_1);
			// 
			// btnOpenDatabase
			// 
			this.btnOpenDatabase.Location = new System.Drawing.Point(296, 16);
			this.btnOpenDatabase.Name = "btnOpenDatabase";
			this.btnOpenDatabase.Size = new System.Drawing.Size(128, 24);
			this.btnOpenDatabase.TabIndex = 4;
			this.btnOpenDatabase.Text = "Open Database";
			this.btnOpenDatabase.Click += new System.EventHandler(this.btnOpenDatabase_Click);
			// 
			// txtMsidb
			// 
			this.txtMsidb.Location = new System.Drawing.Point(80, 16);
			this.txtMsidb.Name = "txtMsidb";
			this.txtMsidb.Size = new System.Drawing.Size(208, 20);
			this.txtMsidb.TabIndex = 5;
			this.txtMsidb.Text = "";
			// 
			// OFDmsi
			// 
			this.OFDmsi.DefaultExt = "*.msi";
			this.OFDmsi.Title = "Open Windows Installer Database";
			// 
			// MainForm
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(576, 414);
			this.Controls.Add(this.txtMsidb);
			this.Controls.Add(this.btnOpenDatabase);
			this.Controls.Add(this.tabControl1);
			this.Name = "MainForm";
			this.tabControl1.ResumeLayout(false);
			this.tabPage1.ResumeLayout(false);
			this.tabPage2.ResumeLayout(false);
			this.tabPage3.ResumeLayout(false);
			this.tabPage5.ResumeLayout(false);
			this.tabPage4.ResumeLayout(false);
			this.panel1.ResumeLayout(false);
			this.ResumeLayout(false);

		}
			
		[STAThread]
		public static void Main(string[] args)
		{
			Application.Run(new MainForm());			
		}

		private void btnQuery_Click(object sender, System.EventArgs e)
		{
			
			IntPtr view_handle = IntPtr.Zero;
			
            IntPtr record_handle = IntPtr.Zero;
			int buffer_length = 255;
		           
			int Hresult = Msidb.MsiDatabaseOpenView (db_handle, "SELECT * FROM `Dialog`", ref view_handle);
			Hresult = Msidb.MsiViewExecute (view_handle, nil);
			Hresult = Msidb.MsiViewFetch (view_handle, ref record_handle);
			//int field_count = Msidb.MsiRecordGetFieldCount(record_handle);
			
			//Now we loop thru all the fields in a record in the Dialog table.
			//for(int i = 0; i < dialog_count; i++)
			//{
            //  
            //}
			//Hresult = Msidb.MsiRecordGetString (record_handle, 1,  dialog_buffer, ref buffer_length);
          //Loop thru and grab all the dialog names
			LBDialogs.BeginUpdate();
			while (IntPtr.Zero != record_handle)
			{
			  buffer_length = 255;
			  string dialog_buffer = new string (' ',  buffer_length);
              Hresult = Msidb.MsiRecordGetString (record_handle, 1,  dialog_buffer, ref buffer_length);
              LBDialogs.Items.Add(dialog_buffer);
		  	  Hresult = Msidb.MsiViewFetch (view_handle, ref record_handle);
		  	}
			LBDialogs.EndUpdate();
			Hresult = Msidb.MsiViewClose (view_handle);
			
			//return dialog_buffer.Substring(0, buffer_length); 
		}

		private void btnOpenDatabase_Click(object sender, System.EventArgs e)
		{
          DialogResult return_value = OFDmsi.ShowDialog();
          dbpath = OFDmsi.FileName;//"C:\\DevTools\\Sample.msi";
		  txtMsidb.Text = dbpath;//Msidb.MSIDBOPEN_DIRECT
		  int Hresult =  Msidb.MsiOpenDatabase (dbpath,Msidb.MSIDBOPEN.TRANSACT, ref db_handle);
		}

		private void btnViewDialog_Click(object sender, System.EventArgs e)
		{   //"WelcomeDlg"
			int Hresult = Msidb.MsiEnableUIPreview(db_handle,ref preview_handle);
			if( -1 == LBDialogs.SelectedIndex)
                return;
			string v12 = (string) LBDialogs.Items[LBDialogs.SelectedIndex];
			Hresult = Msidb.MsiPreviewDialog(preview_handle,v12);
		}

		private void btnCloseDialog_Click(object sender, System.EventArgs e)
		{
		   int Hresult = Msidb.MsiPreviewDialog(preview_handle,"");
		   Hresult = Msidb.MsiCloseHandle(preview_handle);
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
				string product_buffer = new string (' ',buffer_length);
				Hresult = MsiState.MsiEnumProducts(product_index,product_buffer);
				if (0 == Hresult)
				  LBProducts.Items.Add(product_buffer);
				product_index++;
			}
			LBProducts.EndUpdate();
	
		}

		private void LBProducts_SelectedIndexChanged(object sender, System.EventArgs e)
		{
			int buffer_length = 63;
			string productname_buffer = new string (' ',63);
			string product_guid = (string) LBProducts.Items[LBProducts.SelectedIndex];
			int Hresult = Msidb.MsiGetProductInfo(product_guid,"ProductName",productname_buffer,ref buffer_length);
            lblProductName.Text = productname_buffer;
		}

		private void btnSummaryInfo_Click(object sender, System.EventArgs e)
		{
		   int update_count = 11;
		   IntPtr summary_handle = IntPtr.Zero;
		   int Datatype = new int();
		   int Valuetype = new int();
		   Valuetype = 255;
		   FILETIME file_time = new FILETIME() ;
		   int ValueInt=255;
		   
		   string Value=new string (' ',ValueInt);
		  

		   int Hresult = MsiState.MsiGetSummaryInformation(db_handle,"",update_count,ref summary_handle);
		   Hresult = MsiState.MsiSummaryInfoGetProperty(summary_handle,MsiState.PID_TITLE,ref Datatype,ref Valuetype,ref file_time, Value,ref ValueInt);
		  // MsiDBChec = new MsiDBCheck(Hresult);
		  // MsiChec = new MsiCheck(Hresult);
		   Hresult = MsiState.MsiSummaryInfoPersist(summary_handle);
		}

		
		private void button2_Click_1(object sender, System.EventArgs e)
		{
			string Q1 = "CREATE TABLE `XDirectory` (`Directory` CHAR(72) NOT NULL, `Directory_Parent` CHAR(72), `DefaultDir` CHAR(255) NOT NULL LOCALIZABLE PRIMARY KEY `Directory`)";
			string Q2 = "DROP TABLE `XDirectory`";
			IntPtr view_handle = IntPtr.Zero;

			if(rbCreate.Checked)
			{
				int Hresult = Msidb.MsiDatabaseOpenView (db_handle,Q2 , ref view_handle);
				Hresult = Msidb.MsiViewExecute (view_handle, nil);
				Hresult = Msidb.MsiViewClose (view_handle);
				Hresult = Msidb.MsiDatabaseCommit(db_handle);

			}
			if(rbDrop.Checked)
			{
				int Hresult = Msidb.MsiDatabaseOpenView (db_handle,Q2 , ref view_handle);
				Hresult = Msidb.MsiViewExecute (view_handle, nil);
				Hresult = Msidb.MsiViewClose (view_handle);
				Hresult = Msidb.MsiDatabaseCommit(db_handle);

			}
		}
	}

		
	}	


	
  
	

		

