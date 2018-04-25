namespace Anexo17
{
    partial class FrmAnexo17
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
            this.cntArchivo = new System.Windows.Forms.GroupBox();
            this.lblMontoFsd = new System.Windows.Forms.Label();
            this.txtMontoFsd = new System.Windows.Forms.TextBox();
            this.button1 = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.txcUbiArchivo = new System.Windows.Forms.TextBox();
            this.button2 = new System.Windows.Forms.Button();
            this.button3 = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.txtRutaClientes = new System.Windows.Forms.TextBox();
            this.cntArchivo.SuspendLayout();
            this.SuspendLayout();
            // 
            // cntArchivo
            // 
            this.cntArchivo.Controls.Add(this.button3);
            this.cntArchivo.Controls.Add(this.label2);
            this.cntArchivo.Controls.Add(this.txtRutaClientes);
            this.cntArchivo.Controls.Add(this.lblMontoFsd);
            this.cntArchivo.Controls.Add(this.txtMontoFsd);
            this.cntArchivo.Controls.Add(this.button1);
            this.cntArchivo.Controls.Add(this.label1);
            this.cntArchivo.Controls.Add(this.txcUbiArchivo);
            this.cntArchivo.Location = new System.Drawing.Point(12, 12);
            this.cntArchivo.Name = "cntArchivo";
            this.cntArchivo.Size = new System.Drawing.Size(441, 176);
            this.cntArchivo.TabIndex = 2;
            this.cntArchivo.TabStop = false;
            this.cntArchivo.Text = "Archivo";
            // 
            // lblMontoFsd
            // 
            this.lblMontoFsd.AutoSize = true;
            this.lblMontoFsd.Location = new System.Drawing.Point(6, 138);
            this.lblMontoFsd.Name = "lblMontoFsd";
            this.lblMontoFsd.Size = new System.Drawing.Size(61, 13);
            this.lblMontoFsd.TabIndex = 5;
            this.lblMontoFsd.Text = "Monto FSD";
            // 
            // txtMontoFsd
            // 
            this.txtMontoFsd.Location = new System.Drawing.Point(69, 135);
            this.txtMontoFsd.Name = "txtMontoFsd";
            this.txtMontoFsd.Size = new System.Drawing.Size(122, 20);
            this.txtMontoFsd.TabIndex = 4;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(402, 72);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(33, 27);
            this.button1.TabIndex = 3;
            this.button1.Text = "...";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(12, 79);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(42, 13);
            this.label1.TabIndex = 2;
            this.label1.Text = "Montos";
            // 
            // txcUbiArchivo
            // 
            this.txcUbiArchivo.Location = new System.Drawing.Point(69, 76);
            this.txcUbiArchivo.Name = "txcUbiArchivo";
            this.txcUbiArchivo.ReadOnly = true;
            this.txcUbiArchivo.Size = new System.Drawing.Size(332, 20);
            this.txcUbiArchivo.TabIndex = 1;
            this.txcUbiArchivo.TabStop = false;
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(372, 208);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(75, 52);
            this.button2.TabIndex = 3;
            this.button2.Text = "Ejecutar";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // button3
            // 
            this.button3.Location = new System.Drawing.Point(402, 36);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(33, 27);
            this.button3.TabIndex = 8;
            this.button3.Text = "...";
            this.button3.UseVisualStyleBackColor = true;
            this.button3.Click += new System.EventHandler(this.button3_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(12, 43);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(44, 13);
            this.label2.TabIndex = 7;
            this.label2.Text = "Clientes";
            // 
            // txtRutaClientes
            // 
            this.txtRutaClientes.Location = new System.Drawing.Point(69, 40);
            this.txtRutaClientes.Name = "txtRutaClientes";
            this.txtRutaClientes.ReadOnly = true;
            this.txtRutaClientes.Size = new System.Drawing.Size(332, 20);
            this.txtRutaClientes.TabIndex = 6;
            this.txtRutaClientes.TabStop = false;
            // 
            // FrmAnexo17
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(465, 272);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.cntArchivo);
            this.Name = "FrmAnexo17";
            this.Text = "Procesar Anexo 17 - C";
            this.cntArchivo.ResumeLayout(false);
            this.cntArchivo.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox cntArchivo;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txcUbiArchivo;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Label lblMontoFsd;
        private System.Windows.Forms.TextBox txtMontoFsd;
        private System.Windows.Forms.Button button3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txtRutaClientes;
    }
}

