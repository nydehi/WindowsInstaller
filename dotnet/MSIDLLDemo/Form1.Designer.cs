namespace MSIDLLDemo
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.btnCloseDialog = new System.Windows.Forms.Button();
            this.btnViewDialog = new System.Windows.Forms.Button();
            this.LBDialogs = new System.Windows.Forms.ListBox();
            this.btnQuery = new System.Windows.Forms.Button();
            this.tabPage3 = new System.Windows.Forms.TabPage();
            this.label3 = new System.Windows.Forms.Label();
            this.btnSummaryInfo = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.tabPage2 = new System.Windows.Forms.TabPage();
            this.lblProductName = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.LBProducts = new System.Windows.Forms.ListBox();
            this.btnListProducts = new System.Windows.Forms.Button();
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
            this.txtMsidll = new System.Windows.Forms.TextBox();
            this.OFDmsi = new System.Windows.Forms.OpenFileDialog();
            this.label5 = new System.Windows.Forms.Label();
            this.lblVersion = new System.Windows.Forms.Label();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.tabPage6 = new System.Windows.Forms.TabPage();
            this.lbTables = new System.Windows.Forms.ListBox();
            this.btnListTables = new System.Windows.Forms.Button();
            this.tabPage7 = new System.Windows.Forms.TabPage();
            this.tabControl1.SuspendLayout();
            this.tabPage1.SuspendLayout();
            this.tabPage3.SuspendLayout();
            this.tabPage2.SuspendLayout();
            this.tabPage5.SuspendLayout();
            this.tabPage4.SuspendLayout();
            this.panel1.SuspendLayout();
            this.tabPage6.SuspendLayout();
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
            this.tabControl1.Controls.Add(this.tabPage6);
            this.tabControl1.Controls.Add(this.tabPage7);
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
            this.btnViewDialog.Size = new System.Drawing.Size(75, 23);
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
            // tabPage3
            // 
            this.tabPage3.Controls.Add(this.textBox1);
            this.tabPage3.Controls.Add(this.label3);
            this.tabPage3.Controls.Add(this.btnSummaryInfo);
            this.tabPage3.Controls.Add(this.label2);
            this.tabPage3.Location = new System.Drawing.Point(4, 22);
            this.tabPage3.Name = "tabPage3";
            this.tabPage3.Size = new System.Drawing.Size(560, 318);
            this.tabPage3.TabIndex = 2;
            this.tabPage3.Text = "Summary Info";
            // 
            // label3
            // 
            this.label3.Location = new System.Drawing.Point(24, 48);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(100, 23);
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
            // tabPage2
            // 
            this.tabPage2.Controls.Add(this.lblVersion);
            this.tabPage2.Controls.Add(this.label5);
            this.tabPage2.Controls.Add(this.lblProductName);
            this.tabPage2.Controls.Add(this.label1);
            this.tabPage2.Controls.Add(this.LBProducts);
            this.tabPage2.Controls.Add(this.btnListProducts);
            this.tabPage2.Location = new System.Drawing.Point(4, 22);
            this.tabPage2.Name = "tabPage2";
            this.tabPage2.Size = new System.Drawing.Size(560, 318);
            this.tabPage2.TabIndex = 1;
            this.tabPage2.Text = "List Products";
            // 
            // lblProductName
            // 
            this.lblProductName.Location = new System.Drawing.Point(281, 53);
            this.lblProductName.Name = "lblProductName";
            this.lblProductName.Size = new System.Drawing.Size(215, 40);
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
            // tabPage5
            // 
            this.tabPage5.Controls.Add(this.txtQuery);
            this.tabPage5.Controls.Add(this.btnCustomQuery);
            this.tabPage5.Location = new System.Drawing.Point(4, 22);
            this.tabPage5.Name = "tabPage5";
            this.tabPage5.Size = new System.Drawing.Size(560, 318);
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
            this.tabPage4.Size = new System.Drawing.Size(560, 318);
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
            // txtMsidll
            // 
            this.txtMsidll.Location = new System.Drawing.Point(80, 16);
            this.txtMsidll.Name = "txtMsidll";
            this.txtMsidll.Size = new System.Drawing.Size(208, 20);
            this.txtMsidll.TabIndex = 5;
            // 
            // OFDmsi
            // 
            this.OFDmsi.DefaultExt = "*.msi";
            this.OFDmsi.Title = "Open Windows Installer Database";
            // 
            // label5
            // 
            this.label5.Location = new System.Drawing.Point(352, 93);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(100, 15);
            this.label5.TabIndex = 4;
            this.label5.Text = "Version";
            // 
            // lblVersion
            // 
            this.lblVersion.Location = new System.Drawing.Point(281, 108);
            this.lblVersion.Name = "lblVersion";
            this.lblVersion.Size = new System.Drawing.Size(207, 40);
            this.lblVersion.TabIndex = 5;
            // 
            // textBox1
            // 
            this.textBox1.Location = new System.Drawing.Point(8, 27);
            this.textBox1.Multiline = true;
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new System.Drawing.Size(233, 288);
            this.textBox1.TabIndex = 3;
            // 
            // tabPage6
            // 
            this.tabPage6.BackColor = System.Drawing.SystemColors.Control;
            this.tabPage6.Controls.Add(this.btnListTables);
            this.tabPage6.Controls.Add(this.lbTables);
            this.tabPage6.Location = new System.Drawing.Point(4, 22);
            this.tabPage6.Name = "tabPage6";
            this.tabPage6.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage6.Size = new System.Drawing.Size(560, 318);
            this.tabPage6.TabIndex = 6;
            this.tabPage6.Text = "List Tables";
            // 
            // lbTables
            // 
            this.lbTables.Location = new System.Drawing.Point(3, 0);
            this.lbTables.Name = "lbTables";
            this.lbTables.Size = new System.Drawing.Size(136, 303);
            this.lbTables.TabIndex = 2;
            // 
            // btnListTables
            // 
            this.btnListTables.Location = new System.Drawing.Point(156, 16);
            this.btnListTables.Name = "btnListTables";
            this.btnListTables.Size = new System.Drawing.Size(128, 23);
            this.btnListTables.TabIndex = 3;
            this.btnListTables.Text = "List Tables";
            this.btnListTables.Click += new System.EventHandler(this.btnListTables_Click);
            // 
            // tabPage7
            // 
            this.tabPage7.BackColor = System.Drawing.SystemColors.Control;
            this.tabPage7.Location = new System.Drawing.Point(4, 22);
            this.tabPage7.Name = "tabPage7";
            this.tabPage7.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage7.Size = new System.Drawing.Size(560, 318);
            this.tabPage7.TabIndex = 7;
            this.tabPage7.Text = "tabPage7";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(576, 414);
            this.Controls.Add(this.txtMsidll);
            this.Controls.Add(this.btnOpenDatabase);
            this.Controls.Add(this.tabControl1);
            this.Name = "Form1";
            this.Text = "Form1";
            this.tabControl1.ResumeLayout(false);
            this.tabPage1.ResumeLayout(false);
            this.tabPage3.ResumeLayout(false);
            this.tabPage3.PerformLayout();
            this.tabPage2.ResumeLayout(false);
            this.tabPage5.ResumeLayout(false);
            this.tabPage5.PerformLayout();
            this.tabPage4.ResumeLayout(false);
            this.panel1.ResumeLayout(false);
            this.tabPage6.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label lblVersion;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.TabPage tabPage6;
        private System.Windows.Forms.ListBox lbTables;
        private System.Windows.Forms.Button btnListTables;
        private System.Windows.Forms.TabPage tabPage7;
    }
}

