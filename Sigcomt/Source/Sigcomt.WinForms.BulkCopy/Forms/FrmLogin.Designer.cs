namespace Sigcomt.WinForms.BulkCopy.Forms
{
    partial class FrmLogin
    {
        /// <summary>
        /// Variable del diseñador necesaria.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Limpiar los recursos que se estén usando.
        /// </summary>
        /// <param name="disposing">true si los recursos administrados se deben desechar; false en caso contrario.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Código generado por el Diseñador de Windows Forms

        /// <summary>
        /// Método necesario para admitir el Diseñador. No se puede modificar
        /// el contenido de este método con el editor de código.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FrmLogin));
            this.mbtnCancelar = new MetroFramework.Controls.MetroButton();
            this.mbtnEntrar = new MetroFramework.Controls.MetroButton();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.mtxtClave = new MetroFramework.Controls.MetroTextBox();
            this.mtxtUsuario = new MetroFramework.Controls.MetroTextBox();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // mbtnCancelar
            // 
            this.mbtnCancelar.Anchor = System.Windows.Forms.AnchorStyles.None;
            this.mbtnCancelar.Location = new System.Drawing.Point(191, 176);
            this.mbtnCancelar.Name = "mbtnCancelar";
            this.mbtnCancelar.Size = new System.Drawing.Size(111, 40);
            this.mbtnCancelar.TabIndex = 3;
            this.mbtnCancelar.Text = "Cancelar";
            this.mbtnCancelar.UseSelectable = true;
            this.mbtnCancelar.Click += new System.EventHandler(this.mbtnCancelar_Click);
            // 
            // mbtnEntrar
            // 
            this.mbtnEntrar.Anchor = System.Windows.Forms.AnchorStyles.None;
            this.mbtnEntrar.Location = new System.Drawing.Point(23, 176);
            this.mbtnEntrar.Name = "mbtnEntrar";
            this.mbtnEntrar.Size = new System.Drawing.Size(111, 40);
            this.mbtnEntrar.TabIndex = 2;
            this.mbtnEntrar.Text = "Entrar";
            this.mbtnEntrar.UseSelectable = true;
            this.mbtnEntrar.Click += new System.EventHandler(this.mbtnEntrar_Click);
            // 
            // pictureBox1
            // 
            this.pictureBox1.Anchor = System.Windows.Forms.AnchorStyles.None;
            this.pictureBox1.Image = global::Sigcomt.WinForms.BulkCopy.Properties.Resources.BancoFalabella;
            this.pictureBox1.Location = new System.Drawing.Point(318, 97);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(131, 96);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pictureBox1.TabIndex = 14;
            this.pictureBox1.TabStop = false;
            // 
            // mtxtClave
            // 
            this.mtxtClave.Anchor = System.Windows.Forms.AnchorStyles.None;
            // 
            // 
            // 
            this.mtxtClave.CustomButton.Image = null;
            this.mtxtClave.CustomButton.Location = new System.Drawing.Point(253, 2);
            this.mtxtClave.CustomButton.Name = "";
            this.mtxtClave.CustomButton.Size = new System.Drawing.Size(23, 23);
            this.mtxtClave.CustomButton.Style = MetroFramework.MetroColorStyle.Blue;
            this.mtxtClave.CustomButton.TabIndex = 1;
            this.mtxtClave.CustomButton.Theme = MetroFramework.MetroThemeStyle.Light;
            this.mtxtClave.CustomButton.UseSelectable = true;
            this.mtxtClave.CustomButton.Visible = false;
            this.mtxtClave.DisplayIcon = true;
            this.mtxtClave.Icon = ((System.Drawing.Image)(resources.GetObject("mtxtClave.Icon")));
            this.mtxtClave.Lines = new string[0];
            this.mtxtClave.Location = new System.Drawing.Point(23, 131);
            this.mtxtClave.MaxLength = 32767;
            this.mtxtClave.Name = "mtxtClave";
            this.mtxtClave.PasswordChar = '●';
            this.mtxtClave.WaterMark = "Clave";
            this.mtxtClave.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.mtxtClave.SelectedText = "";
            this.mtxtClave.SelectionLength = 0;
            this.mtxtClave.SelectionStart = 0;
            this.mtxtClave.ShortcutsEnabled = true;
            this.mtxtClave.Size = new System.Drawing.Size(279, 28);
            this.mtxtClave.Style = MetroFramework.MetroColorStyle.Green;
            this.mtxtClave.TabIndex = 1;
            this.mtxtClave.UseSelectable = true;
            this.mtxtClave.UseSystemPasswordChar = true;
            this.mtxtClave.WaterMark = "Clave";
            this.mtxtClave.WaterMarkColor = System.Drawing.Color.FromArgb(((int)(((byte)(109)))), ((int)(((byte)(109)))), ((int)(((byte)(109)))));
            this.mtxtClave.WaterMarkFont = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Pixel);
            this.mtxtClave.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.mtxtClave_KeyPress);
            // 
            // mtxtUsuario
            // 
            this.mtxtUsuario.Anchor = System.Windows.Forms.AnchorStyles.None;
            // 
            // 
            // 
            this.mtxtUsuario.CustomButton.Image = null;
            this.mtxtUsuario.CustomButton.Location = new System.Drawing.Point(253, 2);
            this.mtxtUsuario.CustomButton.Name = "";
            this.mtxtUsuario.CustomButton.Size = new System.Drawing.Size(23, 23);
            this.mtxtUsuario.CustomButton.Style = MetroFramework.MetroColorStyle.Blue;
            this.mtxtUsuario.CustomButton.TabIndex = 1;
            this.mtxtUsuario.CustomButton.Theme = MetroFramework.MetroThemeStyle.Light;
            this.mtxtUsuario.CustomButton.UseSelectable = true;
            this.mtxtUsuario.CustomButton.Visible = false;
            this.mtxtUsuario.DisplayIcon = true;
            this.mtxtUsuario.Icon = ((System.Drawing.Image)(resources.GetObject("mtxtUsuario.Icon")));
            this.mtxtUsuario.Lines = new string[0];
            this.mtxtUsuario.Location = new System.Drawing.Point(23, 97);
            this.mtxtUsuario.MaxLength = 32767;
            this.mtxtUsuario.Name = "mtxtUsuario";
            this.mtxtUsuario.PasswordChar = '\0';
            this.mtxtUsuario.WaterMark = "Usuario";
            this.mtxtUsuario.ScrollBars = System.Windows.Forms.ScrollBars.None;
            this.mtxtUsuario.SelectedText = "";
            this.mtxtUsuario.SelectionLength = 0;
            this.mtxtUsuario.SelectionStart = 0;
            this.mtxtUsuario.ShortcutsEnabled = true;
            this.mtxtUsuario.Size = new System.Drawing.Size(279, 28);
            this.mtxtUsuario.Style = MetroFramework.MetroColorStyle.Green;
            this.mtxtUsuario.TabIndex = 0;
            this.mtxtUsuario.UseSelectable = true;
            this.mtxtUsuario.WaterMark = "Usuario";
            this.mtxtUsuario.WaterMarkColor = System.Drawing.Color.FromArgb(((int)(((byte)(109)))), ((int)(((byte)(109)))), ((int)(((byte)(109)))));
            this.mtxtUsuario.WaterMarkFont = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Pixel);
            // 
            // FrmLogin
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(462, 251);
            this.Controls.Add(this.mtxtUsuario);
            this.Controls.Add(this.mbtnCancelar);
            this.Controls.Add(this.mtxtClave);
            this.Controls.Add(this.mbtnEntrar);
            this.Controls.Add(this.pictureBox1);
            this.Font = new System.Drawing.Font("Segoe UI", 8.25F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.MaximizeBox = false;
            this.Name = "FrmLogin";
            this.Resizable = false;
            this.Style = MetroFramework.MetroColorStyle.Green;
            this.Text = "Login - Reporte Comisiones";
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion
        private MetroFramework.Controls.MetroButton mbtnCancelar;
        private MetroFramework.Controls.MetroButton mbtnEntrar;
        private System.Windows.Forms.PictureBox pictureBox1;
        private MetroFramework.Controls.MetroTextBox mtxtClave;
        private MetroFramework.Controls.MetroTextBox mtxtUsuario;
    }
}

