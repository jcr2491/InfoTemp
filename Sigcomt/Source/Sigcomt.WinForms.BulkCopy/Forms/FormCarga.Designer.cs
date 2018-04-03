namespace Sigcomt.WinForms.BulkCopy.Forms
{
    partial class FormCarga
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
            this.mbtnCancelar = new MetroFramework.Controls.MetroButton();
            this.mbtnCargar = new MetroFramework.Controls.MetroButton();
            this.lblUsuario = new System.Windows.Forms.Label();
            this.lblNombreUsuario = new System.Windows.Forms.Label();
            this.treeArchivos = new System.Windows.Forms.TreeView();
            this.dtpFechaCarga = new System.Windows.Forms.DateTimePicker();
            this.lblFecha = new System.Windows.Forms.Label();
            this.mprgbAvance = new MetroFramework.Controls.MetroProgressBar();
            this.bgWorkerAvance = new System.ComponentModel.BackgroundWorker();
            this.rtxtLogAvance = new System.Windows.Forms.RichTextBox();
            this.lblPorcentaje = new System.Windows.Forms.Label();
            this.lblCarga = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // mbtnCancelar
            // 
            this.mbtnCancelar.Anchor = System.Windows.Forms.AnchorStyles.None;
            this.mbtnCancelar.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.mbtnCancelar.Location = new System.Drawing.Point(822, 68);
            this.mbtnCancelar.Name = "mbtnCancelar";
            this.mbtnCancelar.Size = new System.Drawing.Size(111, 31);
            this.mbtnCancelar.TabIndex = 5;
            this.mbtnCancelar.Text = "Cancelar";
            this.mbtnCancelar.UseSelectable = true;
            this.mbtnCancelar.Click += new System.EventHandler(this.mbtnCancelar_Click);
            // 
            // mbtnCargar
            // 
            this.mbtnCargar.Anchor = System.Windows.Forms.AnchorStyles.None;
            this.mbtnCargar.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.mbtnCargar.Location = new System.Drawing.Point(692, 68);
            this.mbtnCargar.Name = "mbtnCargar";
            this.mbtnCargar.Size = new System.Drawing.Size(111, 31);
            this.mbtnCargar.TabIndex = 4;
            this.mbtnCargar.Text = "Iniciar Carga";
            this.mbtnCargar.UseSelectable = true;
            this.mbtnCargar.Click += new System.EventHandler(this.mbtnCargar_Click);
            // 
            // lblUsuario
            // 
            this.lblUsuario.AutoSize = true;
            this.lblUsuario.Font = new System.Drawing.Font("Segoe UI", 8.25F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblUsuario.Location = new System.Drawing.Point(491, 13);
            this.lblUsuario.Name = "lblUsuario";
            this.lblUsuario.Size = new System.Drawing.Size(46, 13);
            this.lblUsuario.TabIndex = 6;
            this.lblUsuario.Text = "Usuario:";
            // 
            // lblNombreUsuario
            // 
            this.lblNombreUsuario.AutoSize = true;
            this.lblNombreUsuario.Font = new System.Drawing.Font("Segoe UI", 8.25F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblNombreUsuario.ForeColor = System.Drawing.SystemColors.HotTrack;
            this.lblNombreUsuario.Location = new System.Drawing.Point(543, 13);
            this.lblNombreUsuario.Name = "lblNombreUsuario";
            this.lblNombreUsuario.Size = new System.Drawing.Size(0, 13);
            this.lblNombreUsuario.TabIndex = 7;
            // 
            // treeArchivos
            // 
            this.treeArchivos.CheckBoxes = true;
            this.treeArchivos.Font = new System.Drawing.Font("Segoe UI", 8.25F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.treeArchivos.Location = new System.Drawing.Point(23, 63);
            this.treeArchivos.Name = "treeArchivos";
            this.treeArchivos.Size = new System.Drawing.Size(397, 484);
            this.treeArchivos.TabIndex = 8;
            this.treeArchivos.AfterCheck += new System.Windows.Forms.TreeViewEventHandler(this.treeArchivos_AfterCheck);
            // 
            // dtpFechaCarga
            // 
            this.dtpFechaCarga.CustomFormat = "MM/yyyy";
            this.dtpFechaCarga.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dtpFechaCarga.Location = new System.Drawing.Point(443, 77);
            this.dtpFechaCarga.Name = "dtpFechaCarga";
            this.dtpFechaCarga.Size = new System.Drawing.Size(183, 22);
            this.dtpFechaCarga.TabIndex = 9;
            // 
            // lblFecha
            // 
            this.lblFecha.AutoSize = true;
            this.lblFecha.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblFecha.Location = new System.Drawing.Point(440, 57);
            this.lblFecha.Name = "lblFecha";
            this.lblFecha.Size = new System.Drawing.Size(81, 17);
            this.lblFecha.TabIndex = 10;
            this.lblFecha.Text = "Fecha Carga:";
            // 
            // mprgbAvance
            // 
            this.mprgbAvance.Location = new System.Drawing.Point(443, 524);
            this.mprgbAvance.Name = "mprgbAvance";
            this.mprgbAvance.Size = new System.Drawing.Size(490, 23);
            this.mprgbAvance.Style = MetroFramework.MetroColorStyle.Green;
            this.mprgbAvance.TabIndex = 11;
            this.mprgbAvance.Visible = false;
            // 
            // bgWorkerAvance
            // 
            this.bgWorkerAvance.WorkerReportsProgress = true;
            this.bgWorkerAvance.ProgressChanged += new System.ComponentModel.ProgressChangedEventHandler(this.bgWorkerAvance_ProgressChanged);
            // 
            // rtxtLogAvance
            // 
            this.rtxtLogAvance.Location = new System.Drawing.Point(443, 136);
            this.rtxtLogAvance.Name = "rtxtLogAvance";
            this.rtxtLogAvance.ReadOnly = true;
            this.rtxtLogAvance.Size = new System.Drawing.Size(489, 365);
            this.rtxtLogAvance.TabIndex = 13;
            this.rtxtLogAvance.Text = "";
            this.rtxtLogAvance.Visible = false;
            this.rtxtLogAvance.WordWrap = false;
            // 
            // lblPorcentaje
            // 
            this.lblPorcentaje.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblPorcentaje.Location = new System.Drawing.Point(443, 504);
            this.lblPorcentaje.Name = "lblPorcentaje";
            this.lblPorcentaje.Size = new System.Drawing.Size(489, 17);
            this.lblPorcentaje.TabIndex = 14;
            this.lblPorcentaje.Text = "0% Completado";
            this.lblPorcentaje.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            this.lblPorcentaje.Visible = false;
            // 
            // lblCarga
            // 
            this.lblCarga.AutoSize = true;
            this.lblCarga.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblCarga.Location = new System.Drawing.Point(443, 116);
            this.lblCarga.Name = "lblCarga";
            this.lblCarga.Size = new System.Drawing.Size(69, 17);
            this.lblCarga.TabIndex = 15;
            this.lblCarga.Text = "Log Carga:";
            this.lblCarga.Visible = false;
            // 
            // FormCarga
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.mbtnCancelar;
            this.ClientSize = new System.Drawing.Size(951, 558);
            this.Controls.Add(this.lblCarga);
            this.Controls.Add(this.lblPorcentaje);
            this.Controls.Add(this.rtxtLogAvance);
            this.Controls.Add(this.mprgbAvance);
            this.Controls.Add(this.lblFecha);
            this.Controls.Add(this.dtpFechaCarga);
            this.Controls.Add(this.treeArchivos);
            this.Controls.Add(this.lblNombreUsuario);
            this.Controls.Add(this.lblUsuario);
            this.Controls.Add(this.mbtnCancelar);
            this.Controls.Add(this.mbtnCargar);
            this.Font = new System.Drawing.Font("Segoe UI", 8.25F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.MaximizeBox = false;
            this.Name = "FormCarga";
            this.Resizable = false;
            this.Style = MetroFramework.MetroColorStyle.Green;
            this.Text = "Carga de Archivos - Reporte Comisiones";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.FormCarga_FormClosing);
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.FormCarga_FormClosed);
            this.Load += new System.EventHandler(this.FormCarga_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private MetroFramework.Controls.MetroButton mbtnCancelar;
        private MetroFramework.Controls.MetroButton mbtnCargar;
        private System.Windows.Forms.Label lblUsuario;
        private System.Windows.Forms.Label lblNombreUsuario;
        private System.Windows.Forms.TreeView treeArchivos;
        private System.Windows.Forms.DateTimePicker dtpFechaCarga;
        private System.Windows.Forms.Label lblFecha;
        private MetroFramework.Controls.MetroProgressBar mprgbAvance;
        private System.ComponentModel.BackgroundWorker bgWorkerAvance;
        private System.Windows.Forms.RichTextBox rtxtLogAvance;
        private System.Windows.Forms.Label lblPorcentaje;
        private System.Windows.Forms.Label lblCarga;
    }
}