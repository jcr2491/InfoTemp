using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Windows.Forms;
using MetroFramework;
using MetroFramework.Forms;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic;
using Sigcomt.Common;
using Sigcomt.WinForms.BulkCopy.ClasesCarga.Automotriz;
using Sigcomt.WinForms.BulkCopy.ClasesCarga.Base;
using Sigcomt.WinForms.BulkCopy.ClasesCarga.EjecutivosPromotores;
using Sigcomt.WinForms.BulkCopy.ClasesCarga.JefeComercial;
using Sigcomt.WinForms.BulkCopy.ClasesCarga.MatenimientoIndicador;
using Sigcomt.WinForms.BulkCopy.ClasesCarga.Rapicash;
using Sigcomt.WinForms.BulkCopy.ClasesCarga.Referido;
using Sigcomt.WinForms.BulkCopy.ClasesCarga.RelacionistaCoordinador;
using Sigcomt.WinForms.BulkCopy.ClasesCarga.ReporteRI;
using Sigcomt.WinForms.BulkCopy.ClasesCarga.UAC;
using Sigcomt.WinForms.BulkCopy.Core;

namespace Sigcomt.WinForms.BulkCopy.Forms
{
    public partial class FormCarga : MetroForm
    {
        private int _totalArchivos;
        private int _numLinea;

        public FormCarga()
        {
            InitializeComponent();
        }

        #region Eventos

        private void mbtnCancelar_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void FormCarga_Load(object sender, EventArgs e)
        {
            CargarDatosIniciales();
        }

        private void treeArchivos_AfterCheck(object sender, TreeViewEventArgs e)
        {
            if (e.Action != TreeViewAction.Unknown)
            {
                if (e.Node.Nodes.Count > 0)
                {
                    CheckAllChildNodes(e.Node, e.Node.Checked);
                }
            }
        }

        private void mbtnCargar_Click(object sender, EventArgs e)
        {
            IniciarCarga();
        }

        private void bgWorkerAvance_ProgressChanged(object sender, ProgressChangedEventArgs e)
        {
            var estado = (MensajeEstado) e.UserState;
            _numLinea++;

            rtxtLogAvance.SelectionColor = estado.ColorMensaje;
            rtxtLogAvance.AppendText($"{_numLinea}>---{estado.Mensaje}\r\n");
            rtxtLogAvance.ScrollToCaret();

            mprgbAvance.Value = e.ProgressPercentage;
            lblPorcentaje.Text = string.Format(Constantes.PorcentajeCompletado, e.ProgressPercentage);
            lblPorcentaje.Refresh();
        }

        private void FormCarga_FormClosed(object sender, FormClosedEventArgs e)
        {
            Application.Exit();
        }

        #endregion

        #region Métodos

        private void CheckAllChildNodes(TreeNode treeNode, bool nodeChecked)
        {
            foreach (TreeNode node in treeNode.Nodes)
            {
                node.Checked = nodeChecked;
                if (node.Nodes.Count > 0)
                {
                    CheckAllChildNodes(node, nodeChecked);
                }
            }
        }

        private void GetChildNodesChecked(TreeNode treeNode, List<string> tipoArchivoList)
        {
            foreach (TreeNode node in treeNode.Nodes)
            {
                if (node.Level == 2)
                {
                    if (node.Checked)
                    {
                        tipoArchivoList.Add(node.Name);
                    }
                }
                else
                {
                    GetChildNodesChecked(node, tipoArchivoList);
                }
            }
        }

        private void IniciarCarga()
        {
            List<string> tipoArchivoList = new List<string>();
            GetChildNodesChecked(treeArchivos.Nodes[0], tipoArchivoList);
            
            mprgbAvance.Value = 0;
            rtxtLogAvance.Text = string.Empty;
            lblPorcentaje.Text = string.Format(Constantes.PorcentajeCompletado, 0);

            if (tipoArchivoList.Any())
            {
                _totalArchivos = tipoArchivoList.Count;
                _numLinea = 0;
                UtilsLocal.TipoArchivoList = tipoArchivoList;
                UtilsLocal.FechaCarga = dtpFechaCarga.Value;
                UtilsLocal.FactorIncremento = 100 / _totalArchivos;
                UtilsLocal.Worker = bgWorkerAvance;
                UtilsLocal.ProgresoTotal = 0;

                mprgbAvance.Visible = true;
                rtxtLogAvance.Visible = true;
                lblPorcentaje.Visible = true;
                lblCarga.Visible = true;

                CargarArchivos();
            }
            else
            {
                MetroMessageBox.Show(this, Constantes.SeleccioneElemento, Constantes.Error, MessageBoxButtons.OK,
                    MessageBoxIcon.Error);
            }
        }

        private void CargarDatosIniciales()
        {
            UtilsLocal.ExcelList = ExcelBL.GetInstance().GetExcel();
            UtilsLocal.LogCargaList = new List<LogCarga>();
            UtilsLocal.TipoComisionArchivoList = CargaArchivoBL.GetInstance().GetTipoComisionArchivo();
            UtilsLocal.MetodoTipoDatoList = new Dictionary<string, Func<string, bool>>
            {
                {Common.Enums.TipoDato.Entero.GetStringValue(), Utils.EsEntero},
                {Common.Enums.TipoDato.Letras.GetStringValue(), Utils.EsSoloLetras},
                {Common.Enums.TipoDato.NumeroYLetras.GetStringValue(), Utils.EsNumeroYLetras},
                {Common.Enums.TipoDato.Fecha.GetStringValue(), Utils.EsFecha},
                {Common.Enums.TipoDato.Decimal.GetStringValue(), Utils.EsDecimal},
                {Common.Enums.TipoDato._default.GetStringValue(), Utils.EsDefault}//TODO: refactorizar
            };

            lblNombreUsuario.Text = Constantes.Usuario.NombreCompleto;
            var tipoComisionList = UtilsLocal.TipoComisionArchivoList.GroupBy(p => p.TipoComisionId,
                (key, group) => new { Id = key, Nombre = group.First().TipoComisionNombre });

            TreeNode node = new TreeNode(Constantes.Todos);

            foreach (var comision in tipoComisionList)
            {
                TreeNode nodeComision = new TreeNode(comision.Nombre);

                var tipoArchivoList = UtilsLocal.TipoComisionArchivoList.Where(p => p.TipoComisionId == comision.Id);

                foreach (var archivo in tipoArchivoList)
                {
                    nodeComision.Nodes.Add(archivo.TipoArchivoId, archivo.TipoArchivoNombre);
                }

                node.Nodes.Add(nodeComision);
            }

            treeArchivos.Nodes.Add(node);
            treeArchivos.ExpandAll();
            treeArchivos.TopNode = node;
        }

        private void CargarArchivos()
        {
            try
            {
                if (CargaBaseArchivo.CargaArchivos())
                {
                    CargaUAC.CargarArchivos();
                    CargaAutomotriz.CargarArchivos();                   
                    CargaSagaTottus.CargasArchivos();
                    CargaSodimacMaestro.CargarArchivos();

                    if (CargaMantenimientoIndicador.CargarArchivos())
                    {
                        //Jefe Comercial
                        CargaCierrePlanningJefeComercial.CargarArchivo();
                        //CargaPesoCCFF.CargarArchivo();

                        //Ejecutivo Promotores
                        CargaEjecutivoPromotor.CargaArchivos();

                        //Relacionista y Coordinador
                        CargaRelacionistaCoordinador.CargarArchivo();

                        //Reporte RI
                        CargaRI.CargasArchivos();

                        //Referido
                        CargaReferidoCCFF.CargarArchivo();

                        UtilsLocal.AsignarEstado(Constantes.CargaCompleta);
                    }
                    else
                    {
                        UtilsLocal.AsignarEstadoError(Constantes.ErrorCargaIndicadores);
                    }
                }
                else
                {
                    UtilsLocal.AsignarEstadoError(Constantes.ErrorCargaFundamentales);
                }

                var errorList = UtilsLocal.RegistrarLogCarga();
                var archivoEstadocarga = UtilsLocal.GetArchivoEstadoCarga();

                //Envio Correo
                EnvioEmail.EnvioCorreo(errorList, archivoEstadocarga);

                UtilsLocal.AsignarEstado(new MensajeEstado
                {
                    Progreso = 100 - UtilsLocal.ProgresoTotal,
                    Mensaje = Constantes.CargaTerminada
                });

                MetroMessageBox.Show(this, Constantes.CargaTerminada, Constantes.TituloCargaTerminada,
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                UtilsLocal.AsignarEstadoError(100 - UtilsLocal.ProgresoTotal, UtilsLocal.GetMessageError(ex.Message));
                MetroMessageBox.Show(this, ex.Message, Constantes.Error, MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        #endregion
    }
}