namespace Anexo17
{
    partial class FrmAnexo172
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
            this.lblProceso = new System.Windows.Forms.Label();
            this.lblPorcentaje = new System.Windows.Forms.Label();
            this.rtxtLogAvance = new System.Windows.Forms.RichTextBox();
            this.lblFecha = new System.Windows.Forms.Label();
            this.dtpFechaCarga = new System.Windows.Forms.DateTimePicker();
            this.btnEjecutar = new System.Windows.Forms.Button();
            this.lblMondoFsd = new System.Windows.Forms.Label();
            this.txtMontoFsd = new System.Windows.Forms.TextBox();
            this.txtTipoCambio = new System.Windows.Forms.TextBox();
            this.lblTipoCambio = new System.Windows.Forms.Label();
            this.prgbAvance = new System.Windows.Forms.ProgressBar();
            this.bgWorkerAvance = new System.ComponentModel.BackgroundWorker();
            this.fbdUbicacion = new System.Windows.Forms.FolderBrowserDialog();
            this.lblUbicacion = new System.Windows.Forms.Label();
            this.txtUbicacion = new System.Windows.Forms.TextBox();
            this.btnUbicacion = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // lblProceso
            // 
            this.lblProceso.AutoSize = true;
            this.lblProceso.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblProceso.Location = new System.Drawing.Point(15, 163);
            this.lblProceso.Name = "lblProceso";
            this.lblProceso.Size = new System.Drawing.Size(78, 17);
            this.lblProceso.TabIndex = 20;
            this.lblProceso.Text = "Log Proceso:";
            // 
            // lblPorcentaje
            // 
            this.lblPorcentaje.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblPorcentaje.Location = new System.Drawing.Point(15, 466);
            this.lblPorcentaje.Name = "lblPorcentaje";
            this.lblPorcentaje.Size = new System.Drawing.Size(489, 17);
            this.lblPorcentaje.TabIndex = 19;
            this.lblPorcentaje.Text = "0% Completado";
            this.lblPorcentaje.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // rtxtLogAvance
            // 
            this.rtxtLogAvance.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Italic);
            this.rtxtLogAvance.Location = new System.Drawing.Point(15, 183);
            this.rtxtLogAvance.Name = "rtxtLogAvance";
            this.rtxtLogAvance.ReadOnly = true;
            this.rtxtLogAvance.Size = new System.Drawing.Size(489, 280);
            this.rtxtLogAvance.TabIndex = 18;
            this.rtxtLogAvance.Text = "";
            this.rtxtLogAvance.WordWrap = false;
            // 
            // lblFecha
            // 
            this.lblFecha.AutoSize = true;
            this.lblFecha.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblFecha.Location = new System.Drawing.Point(16, 9);
            this.lblFecha.Name = "lblFecha";
            this.lblFecha.Size = new System.Drawing.Size(81, 17);
            this.lblFecha.TabIndex = 17;
            this.lblFecha.Text = "Fecha Carga:";
            // 
            // dtpFechaCarga
            // 
            this.dtpFechaCarga.CustomFormat = "MM/yyyy";
            this.dtpFechaCarga.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Italic);
            this.dtpFechaCarga.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dtpFechaCarga.Location = new System.Drawing.Point(16, 29);
            this.dtpFechaCarga.Name = "dtpFechaCarga";
            this.dtpFechaCarga.Size = new System.Drawing.Size(217, 25);
            this.dtpFechaCarga.TabIndex = 16;
            // 
            // btnEjecutar
            // 
            this.btnEjecutar.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Italic);
            this.btnEjecutar.Location = new System.Drawing.Point(412, 119);
            this.btnEjecutar.Name = "btnEjecutar";
            this.btnEjecutar.Size = new System.Drawing.Size(92, 27);
            this.btnEjecutar.TabIndex = 21;
            this.btnEjecutar.Text = "Ejecutar";
            this.btnEjecutar.UseVisualStyleBackColor = true;
            this.btnEjecutar.Click += new System.EventHandler(this.btnEjecutar_Click);
            // 
            // lblMondoFsd
            // 
            this.lblMondoFsd.AutoSize = true;
            this.lblMondoFsd.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblMondoFsd.Location = new System.Drawing.Point(16, 106);
            this.lblMondoFsd.Name = "lblMondoFsd";
            this.lblMondoFsd.Size = new System.Drawing.Size(72, 17);
            this.lblMondoFsd.TabIndex = 22;
            this.lblMondoFsd.Text = "Monto FSD:";
            // 
            // txtMontoFsd
            // 
            this.txtMontoFsd.Location = new System.Drawing.Point(16, 126);
            this.txtMontoFsd.Name = "txtMontoFsd";
            this.txtMontoFsd.ReadOnly = true;
            this.txtMontoFsd.Size = new System.Drawing.Size(180, 20);
            this.txtMontoFsd.TabIndex = 23;
            // 
            // txtTipoCambio
            // 
            this.txtTipoCambio.Location = new System.Drawing.Point(202, 126);
            this.txtTipoCambio.Name = "txtTipoCambio";
            this.txtTipoCambio.ReadOnly = true;
            this.txtTipoCambio.Size = new System.Drawing.Size(180, 20);
            this.txtTipoCambio.TabIndex = 25;
            // 
            // lblTipoCambio
            // 
            this.lblTipoCambio.AutoSize = true;
            this.lblTipoCambio.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblTipoCambio.Location = new System.Drawing.Point(199, 106);
            this.lblTipoCambio.Name = "lblTipoCambio";
            this.lblTipoCambio.Size = new System.Drawing.Size(82, 17);
            this.lblTipoCambio.TabIndex = 24;
            this.lblTipoCambio.Text = "Tipo Cambio:";
            // 
            // prgbAvance
            // 
            this.prgbAvance.Location = new System.Drawing.Point(15, 486);
            this.prgbAvance.Name = "prgbAvance";
            this.prgbAvance.Size = new System.Drawing.Size(489, 23);
            this.prgbAvance.TabIndex = 26;
            // 
            // bgWorkerAvance
            // 
            this.bgWorkerAvance.WorkerReportsProgress = true;
            this.bgWorkerAvance.ProgressChanged += new System.ComponentModel.ProgressChangedEventHandler(this.bgWorkerAvance_ProgressChanged);
            // 
            // lblUbicacion
            // 
            this.lblUbicacion.AutoSize = true;
            this.lblUbicacion.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblUbicacion.Location = new System.Drawing.Point(16, 59);
            this.lblUbicacion.Name = "lblUbicacion";
            this.lblUbicacion.Size = new System.Drawing.Size(251, 17);
            this.lblUbicacion.TabIndex = 27;
            this.lblUbicacion.Text = "Ubicación donde se guardarán los archivos:";
            // 
            // txtUbicacion
            // 
            this.txtUbicacion.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Italic);
            this.txtUbicacion.Location = new System.Drawing.Point(16, 79);
            this.txtUbicacion.Name = "txtUbicacion";
            this.txtUbicacion.ReadOnly = true;
            this.txtUbicacion.Size = new System.Drawing.Size(452, 25);
            this.txtUbicacion.TabIndex = 28;
            // 
            // btnUbicacion
            // 
            this.btnUbicacion.Location = new System.Drawing.Point(474, 74);
            this.btnUbicacion.Name = "btnUbicacion";
            this.btnUbicacion.Size = new System.Drawing.Size(31, 29);
            this.btnUbicacion.TabIndex = 29;
            this.btnUbicacion.Text = "...";
            this.btnUbicacion.UseVisualStyleBackColor = true;
            this.btnUbicacion.Click += new System.EventHandler(this.btnUbicacion_Click);
            // 
            // FrmAnexo172
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(519, 514);
            this.Controls.Add(this.btnUbicacion);
            this.Controls.Add(this.txtUbicacion);
            this.Controls.Add(this.lblUbicacion);
            this.Controls.Add(this.prgbAvance);
            this.Controls.Add(this.txtTipoCambio);
            this.Controls.Add(this.lblTipoCambio);
            this.Controls.Add(this.txtMontoFsd);
            this.Controls.Add(this.lblMondoFsd);
            this.Controls.Add(this.btnEjecutar);
            this.Controls.Add(this.lblProceso);
            this.Controls.Add(this.lblPorcentaje);
            this.Controls.Add(this.rtxtLogAvance);
            this.Controls.Add(this.lblFecha);
            this.Controls.Add(this.dtpFechaCarga);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.Name = "FrmAnexo172";
            this.Text = "Monto Fondo de Seguro Depósito";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblProceso;
        private System.Windows.Forms.Label lblPorcentaje;
        private System.Windows.Forms.RichTextBox rtxtLogAvance;
        private System.Windows.Forms.Label lblFecha;
        private System.Windows.Forms.DateTimePicker dtpFechaCarga;
        private System.Windows.Forms.Button btnEjecutar;
        private System.Windows.Forms.Label lblMondoFsd;
        private System.Windows.Forms.TextBox txtMontoFsd;
        private System.Windows.Forms.TextBox txtTipoCambio;
        private System.Windows.Forms.Label lblTipoCambio;
        private System.Windows.Forms.ProgressBar prgbAvance;
        private System.ComponentModel.BackgroundWorker bgWorkerAvance;
        private System.Windows.Forms.FolderBrowserDialog fbdUbicacion;
        private System.Windows.Forms.Label lblUbicacion;
        private System.Windows.Forms.TextBox txtUbicacion;
        private System.Windows.Forms.Button btnUbicacion;
    }
}