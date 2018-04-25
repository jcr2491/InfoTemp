using Anexo17.Clases;
using Anexo17.Core;
using Anexo17.DataAccess;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Anexo17
{
    public partial class FrmAnexo172 : Form
    {
        private List<SaldoAcumulado> _acumuladoList = new List<SaldoAcumulado>();
        private int _numLinea;
        private int _progresoTotal;
        private TipoCambio _tipoCambio;
        private decimal _montoFsd;

        public FrmAnexo172()
        {
            InitializeComponent();
        }

        #region Eventos

        private void btnEjecutar_Click(object sender, EventArgs e)
        {
            Procesar();
        }

        private void bgWorkerAvance_ProgressChanged(object sender, System.ComponentModel.ProgressChangedEventArgs e)
        {
            var estado = (MensajeEstado)e.UserState;
            _numLinea++;

            rtxtLogAvance.SelectionColor = estado.ColorMensaje;
            rtxtLogAvance.AppendText($"{_numLinea}>---{estado.Mensaje}\r\n");
            rtxtLogAvance.ScrollToCaret();
            rtxtLogAvance.Refresh();

            prgbAvance.Value = e.ProgressPercentage;
            lblPorcentaje.Text = $"{e.ProgressPercentage}% Completado";
            lblPorcentaje.Refresh();

            txtMontoFsd.Refresh();
            txtTipoCambio.Refresh();
        }

        private void btnUbicacion_Click(object sender, EventArgs e)
        {
            DialogResult dialog = fbdUbicacion.ShowDialog();

            if (dialog == DialogResult.OK)
            {
                txtUbicacion.Text = fbdUbicacion.SelectedPath;
            }
        }

        #endregion

        #region Métodos

        private void Procesar()
        {
            LimpiarDatos();

            if (txtUbicacion.Text.Trim() == string.Empty)
            {
                MessageBox.Show("Seleccione la ubicación donde se guardarán los archivos", "Advertencia", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            var confirm = MessageBox.Show("Esta seguro que desea realizar el proceso?", "Confirmación", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (confirm == DialogResult.No) return;

            var csv = new StringBuilder();
            var access = new AccesoDatos();

            try
            {
                var fechaIni = new DateTime(dtpFechaCarga.Value.Year, dtpFechaCarga.Value.Month, 1);
                var fechaFin = fechaIni.AddMonths(1).AddDays(-1);

                AsignarEstado(new MensajeEstado
                {
                    Progreso = 0,
                    Mensaje = "Se inició el proceso de monto sujeto a cobertura",
                    ColorMensaje = Color.Green
                });

                AsignarEstado(new MensajeEstado
                {
                    Progreso = 2,
                    Mensaje = "Obteniendo Tipo Cambio y Monto FSD",
                    ColorMensaje = Color.Black
                });

                _tipoCambio = access.GetTipoCambio(fechaFin);
                _montoFsd = access.GetMontoFsd();

                txtMontoFsd.Text = _montoFsd.ToString();
                txtTipoCambio.Text = _tipoCambio.nTCFijo.ToString();

                var productos = new List<ParametroCobertura>
                {
                    new ParametroCobertura
                    {
                        Nombre = "Depósitos de Ahorros Activos",
                        TipoCambio = _tipoCambio.nTCFijo,
                        TipoCta = "51",
                        FechaIni = fechaIni,
                        FechaFin = fechaFin,
                        Condicion = "_A_N_",
                        MontoFsd = _montoFsd
                    },
                    new ParametroCobertura
                    {
                        Nombre = "Depósitos de Ahorros Inactivos",
                        TipoCambio = _tipoCambio.nTCFijo,
                        TipoCta = "51",
                        FechaIni = fechaIni,
                        FechaFin = fechaFin,
                        Condicion = "_I_",
                        MontoFsd = _montoFsd
                    },
                    new ParametroCobertura
                    {
                        Nombre = "Cuentas a Plazo",
                        TipoCambio = _tipoCambio.nTCFijo,
                        TipoCta = "50",
                        FechaIni = fechaIni,
                        FechaFin = fechaFin,
                        Condicion = "_A_N_",
                        MontoFsd = _montoFsd
                    }
                };

                AsignarEstado(new MensajeEstado
                {
                    Progreso = 2,
                    Mensaje = "Obteniendo clientes",
                    ColorMensaje = Color.Black
                });

                _acumuladoList = access.GetClientes(fechaIni, fechaFin);

                AsignarEstado(new MensajeEstado
                {
                    Progreso = 15,
                    Mensaje = "Ejecutando el procedimiento PROC_S_FSDDCTA_ClasificaCuentasFSDXRangoFechas",
                    ColorMensaje = Color.Black
                });

                var list = access.GetClasificaCuentasFSDXRangoFechas(fechaIni, fechaFin);

                AsignarEstado(new MensajeEstado
                {
                    Progreso = 30,
                    Mensaje = "Actualizando el campo \"cAplFsd\" de la tabla \"FSDDCTA\"",
                    ColorMensaje = Color.Black
                });

                access.UpdateCuentas(list);

                foreach (var producto in productos)
                {
                    ProcesarInformacion(producto);
                }

                AsignarEstado(new MensajeEstado
                {
                    Progreso = 100 - _progresoTotal,
                    Mensaje = "Proceso terminado correctamente",
                    ColorMensaje = Color.Green
                });

                MessageBox.Show("Proceso terminado correctamente", "Notificación", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                AsignarEstado(new MensajeEstado
                {
                    Progreso = 100 - _progresoTotal,
                    Mensaje = $"Error: {ex.Message}",
                    ColorMensaje = Color.Red
                });
                MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void ProcesarInformacion(ParametroCobertura parametro)
        {
            decimal montoSujetoCoberturaSoles = 0;
            decimal montoSujetoCoberturaDolares = 0;
            var access = new AccesoDatos();

            AsignarEstado(new MensajeEstado
            {
                Progreso = 0,
                Mensaje = $"Se procesará {parametro.Nombre}",
                ColorMensaje = Color.Green
            });            

            AsignarEstado(new MensajeEstado
            {
                Progreso = 5,
                Mensaje = "Ejecutando el procedimiento PROC_S_MontoCoberturaFSD",
                ColorMensaje = Color.Black
            });

            var clienteSaldoList = access.GetMontoCoberturaFsd(parametro);

            var csv = new StringBuilder();
            csv.AppendLine("cCodCli,nSalMN,nSalME,nNroSol,nNroDol");

            AsignarEstado(new MensajeEstado
            {
                Progreso = 10,
                Mensaje = $"Procesando el monto sujeto a cobertura de {parametro.Nombre}",
                ColorMensaje = Color.Black
            });

            foreach (var clienteSaldo in clienteSaldoList)
            {
                var montoControlSoles = decimal.Zero;
                var montoControlDolares = decimal.Zero;

                var saldoAcumulado = _acumuladoList.FirstOrDefault(p => p.CCodCli == clienteSaldo.CCodCli);

                if (saldoAcumulado != null && saldoAcumulado.Saldo < _montoFsd)
                {
                    if (clienteSaldo.NSalMN != decimal.Zero)
                    {
                        if (clienteSaldo.NSalMN < _montoFsd)
                        {
                            montoControlSoles = clienteSaldo.NSalMN;
                            montoSujetoCoberturaSoles = montoSujetoCoberturaSoles + clienteSaldo.NSalMN;
                            if (clienteSaldo.NSalME != decimal.Zero)
                            {
                                decimal montoTemporal = _montoFsd - (clienteSaldo.NSalMN + saldoAcumulado.Saldo);
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
                            montoControlSoles = _montoFsd - saldoAcumulado.Saldo;
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
                            clienteSaldo.NSalME < _montoFsd - saldoAcumulado.Saldo
                                ? clienteSaldo.NSalME
                                : _montoFsd - saldoAcumulado.Saldo;
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

            AsignarEstado(new MensajeEstado
            {
                Progreso = 2,
                Mensaje = $"Generando el archivo de {parametro.Nombre}",
                ColorMensaje = Color.Black
            });

            File.WriteAllText($"{txtUbicacion.Text}/{parametro.FechaIni.Month}-{parametro.FechaIni.Year}_{parametro.Nombre}.csv", csv.ToString());

            AsignarEstado(new MensajeEstado
            {
                Progreso = 0,
                Mensaje = $"Se terminó el proceso de {parametro.Nombre}",
                ColorMensaje = Color.Green
            });
        }

        private void AsignarEstado(MensajeEstado estado)
        {
            _progresoTotal += estado.Progreso;
            bgWorkerAvance.ReportProgress(_progresoTotal, estado);
        }

        private void LimpiarDatos()
        {
            _progresoTotal = 0;
            prgbAvance.Value = 0;
            rtxtLogAvance.Text = string.Empty;
            lblPorcentaje.Text = "0% Completado";
            txtMontoFsd.Text = string.Empty;
            txtTipoCambio.Text = string.Empty;
        }

        #endregion        
    }
}