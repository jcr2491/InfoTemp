using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Anexo17.Clases;
using Anexo17.DataAccess;

namespace Anexo17
{
    public partial class FrmAnexo17 : Form
    {
        private readonly List<SaldoAcumulado> _acumuladoList = new List<SaldoAcumulado>();

        public FrmAnexo17()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            OpenFileDialog loDialog = new OpenFileDialog {Multiselect = false};

            if (loDialog.ShowDialog() == DialogResult.OK)
            {
                txcUbiArchivo.Text = loDialog.FileName;
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            OpenFileDialog loDialog = new OpenFileDialog { Multiselect = false };

            if (loDialog.ShowDialog() == DialogResult.OK)
            {
                txtRutaClientes.Text = loDialog.FileName;
                CargarClientes();
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Procesar();
        }

        private void CargarClientes()
        {
            try
            {
                StreamReader file = new StreamReader(txtRutaClientes.Text, Encoding.GetEncoding("iso-8859-1"));

                //Leemos la cabecera del archivo
                //file.ReadLine();

                string line;

                while ((line = file.ReadLine()) != null)
                {
                    var saldoAcumulado = new SaldoAcumulado
                    {
                        CCodCli = line.Trim(),
                        Saldo = 0
                    };
                    _acumuladoList.Add(saldoAcumulado);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void Procesar()
        {
            if (txtRutaClientes.Text.Trim() == string.Empty)
            {
                MessageBox.Show("Seleccione el archivo de clientes", "Advertencia", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            if (txcUbiArchivo.Text.Trim() == string.Empty)
            {
                MessageBox.Show("Seleccione el archivo de montos", "Advertencia", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            txtMontoFsd.Text = new AccesoDatos().GetMontoFsd().ToString();

            if (txtMontoFsd.Text.Trim() == string.Empty)
            {
                MessageBox.Show("Ingrese el valor del Monto de Fondo de Seguro", "Advertencia", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            decimal montoFsd = Convert.ToDecimal(txtMontoFsd.Text.Trim());
            decimal montoSujetoCoberturaSoles = 0;
            decimal montoSujetoCoberturaDolares = 0;
            var csv = new StringBuilder();
            int cont = 0;

            try
            {
                const char separador = ','; //'\t';
                StreamReader file = new StreamReader(txcUbiArchivo.Text, Encoding.GetEncoding("iso-8859-1"));
                csv.AppendLine("cCodCli,nSalMN,nSalME,nNroSol,nNroDol");

                //Leemos la cabecera del archivo
                //file.ReadLine();

                string line;

                while ((line = file.ReadLine()) != null)
                {
                    var campos = line.Split(separador);
                    var montoControlSoles = decimal.Zero;
                    var montoControlDolares = decimal.Zero;

                    var clienteSaldo = new ClienteSaldo
                    {
                        CCodCli = campos[0].Trim(),
                        NSalMN = Convert.ToDecimal(campos[1]),
                        NSalME = Convert.ToDecimal(campos[2]),
                        NNroSol = Convert.ToInt32(campos[3]),
                        NNroDol = Convert.ToInt32(campos[4])
                    };

                    var saldoAcumulado = _acumuladoList.FirstOrDefault(p => p.CCodCli == clienteSaldo.CCodCli);

                    if (saldoAcumulado == null) cont++;

                    if (saldoAcumulado != null && saldoAcumulado.Saldo < montoFsd)
                    {
                        if (clienteSaldo.NSalMN != decimal.Zero)
                        {
                            if (clienteSaldo.NSalMN < montoFsd)
                            {
                                montoControlSoles = clienteSaldo.NSalMN;
                                montoSujetoCoberturaSoles = montoSujetoCoberturaSoles + clienteSaldo.NSalMN;
                                if (clienteSaldo.NSalME != decimal.Zero)
                                {
                                    decimal montoTemporal = montoFsd - (clienteSaldo.NSalMN + saldoAcumulado.Saldo);
                                    montoControlDolares = clienteSaldo.NSalME < montoTemporal
                                        ? clienteSaldo.NSalME
                                        : montoTemporal;
                                    clienteSaldo.NSalME = montoControlDolares;
                                    montoSujetoCoberturaDolares = montoSujetoCoberturaDolares + montoControlDolares;
                                }
                                else
                                {
                                    clienteSaldo.NSalME = 0;
                                    clienteSaldo.NNroDol = 0;
                                }

                                csv.AppendLine(
                                    $"{clienteSaldo.CCodCli},{clienteSaldo.NSalMN},{clienteSaldo.NSalME},{clienteSaldo.NNroSol},{clienteSaldo.NNroDol}");
                            }
                            else
                            {
                                montoControlSoles = montoFsd - saldoAcumulado.Saldo;
                                clienteSaldo.NSalMN = montoControlSoles;
                                clienteSaldo.NSalME = 0;
                                clienteSaldo.NNroDol = 0;

                                csv.AppendLine(
                                    $"{clienteSaldo.CCodCli},{clienteSaldo.NSalMN},{clienteSaldo.NSalME},{clienteSaldo.NNroSol},{clienteSaldo.NNroDol}");
                                montoSujetoCoberturaSoles = montoSujetoCoberturaSoles + montoControlSoles;
                            }
                        }
                        else if (clienteSaldo.NSalME != decimal.Zero)
                        {
                            montoControlDolares =
                                clienteSaldo.NSalME < montoFsd - saldoAcumulado.Saldo
                                    ? clienteSaldo.NSalME
                                    : montoFsd - saldoAcumulado.Saldo;
                            clienteSaldo.NSalME = montoControlDolares;
                            clienteSaldo.NSalMN = 0;
                            clienteSaldo.NNroSol = 0;

                            csv.AppendLine(
                                $"{clienteSaldo.CCodCli},{clienteSaldo.NSalMN},{clienteSaldo.NSalME},{clienteSaldo.NNroSol},{clienteSaldo.NNroDol}");
                            montoSujetoCoberturaDolares = montoSujetoCoberturaDolares + montoControlDolares;
                        }

                        saldoAcumulado.Saldo = saldoAcumulado.Saldo + montoControlSoles + montoControlDolares;
                    }
                }

                var dialog = new SaveFileDialog { Filter = "|*.csv" };

                if (dialog.ShowDialog() == DialogResult.OK)
                {
                    File.WriteAllText(dialog.FileName, csv.ToString());
                }

                MessageBox.Show("Archivo Generado correctamente", "Notificación", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}