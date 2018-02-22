using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.IO;
using NPOI.SS.UserModel;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic;
using Sigcomt.Common;
using Sigcomt.Common.Enums;


namespace Sigcomt.Scheduler.BulkFile.Core
{
    public class CargaBase<T>
    {
        public Dictionary<string, PropiedadColumna> PropiedadCol { get; private set; }
        public Dictionary<string, Func<string, bool>> MetodoTipoDato { get; private set; }
        public List<LogCarga> ErrorCargaList;
        public Excel ExcelBd { get; }
        public ExcelHoja HojaBd { get; }
        public int CabeceraCargaId { get; private set; }
        public string TipoArchivo { get; private set; }
        private bool errorAgregado = false;
        private string nombreArchivo;

        #region Método Constructor

        public CargaBase()
        {

        }

        public CargaBase(string tipoArchivo)
        {
            ExcelBd = UtilsLocal.ExcelList.First(p => p.HojasList.Any(q => q.TipoArchivo == tipoArchivo));
            HojaBd = ExcelBd.HojasList.First(p => p.TipoArchivo == tipoArchivo);
            ErrorCargaList = new List<LogCarga>();
            TipoArchivo = tipoArchivo;

            InicializarDiccionario();
        }

        #endregion

        #region Métodos Públicos

        /// <summary>
        /// Valida que todos los datos estén correctos
        /// </summary>
        /// <param name="excel"></param>
        /// <param name="fila"></param>
        /// <returns>Devuelve True si todos los datos son correctos, caso contrario False</returns>
        public bool ValidarDatos(GenericExcel excel, IRow fila)
        {
            bool isAllValid = true;
            int numFila = fila.RowNum + 1;

            foreach (var propCol in PropiedadCol)
            {
                bool isValid = true;
                propCol.Value.Valor = excel.GetCellToString(fila, propCol.Value.PosicionColumna);

                if (ValidarValor(propCol.Value))
                {
                    isValid = MetodoTipoDato[propCol.Value.TipoDato].Invoke(propCol.Value.Valor);
                }

                if (!isValid)
                {
                    isAllValid = false;
                    var errorCarga = new LogCarga
                    {
                        TipoLog = TipoLogCarga.ValidacionDatos.GetStringValue(),
                        CargaId = CabeceraCargaId,
                        NumFila = numFila,
                        PosicionColumna = propCol.Value.LetraColumna ?? Convert.ToString(propCol.Value.PosicionColumna + 1),
                        ExcelHojaCampoId = propCol.Value.ExcelHojaCampoId,
                        DetalleLog = $"El valor es incorrecto: {propCol.Value.Valor}"
                    };
                    ErrorCargaList.Add(errorCarga);
                    UtilsLocal.LogCargaList.Add(errorCarga);
                }
            }

            return isAllValid;
        }

        public string[] GetNombreArchivos()
        {
            try
            {
                var filesNames = Directory.GetFiles(ExcelBd.Ruta, $"*{ExcelBd.Nombre}");

                if (!filesNames.Any())
                {
                    var logCarga = new LogCarga
                    {
                        TipoLog = TipoLogCarga.NoExisteArchivo.GetStringValue(),
                        TipoArchivo = TipoArchivo,
                        DetalleLog = $"No existen archivos para cargar"
                    };

                    UtilsLocal.LogCargaList.Add(logCarga);
                }

                return filesNames;
            }
            catch (Exception ex)
            {
                var logCarga = new LogCarga
                {
                    TipoLog = TipoLogCarga.NoExisteArchivo.GetStringValue(),
                    TipoArchivo = TipoArchivo,
                    DetalleLog = $"Error al intentar leer el archivo: {ex.Message}"
                };

                UtilsLocal.LogCargaList.Add(logCarga);
                errorAgregado = true;
                throw new Exception(ex.Message, ex);
            }
        }

        public DateTime GetFechaArchivo(string fileName)
        {
            try
            {
                var split = fileName.Split('\\');
                string onlyName = split[split.Length - 1];
                nombreArchivo = onlyName;

                int dia = 1;
                int mes = Convert.ToInt32(onlyName.Substring(0, 2));
                int año = Convert.ToInt32(onlyName.Substring(2, 4));
                DateTime fechaFile = new DateTime(año, mes, dia);

                return fechaFile;
            }
            catch (Exception ex)
            {
                var logCarga = new LogCarga
                {
                    TipoLog = TipoLogCarga.NombreArchivoInvalido.GetStringValue(),
                    TipoArchivo = TipoArchivo,
                    DetalleLog = $"El formato del nombre del archivo a cargar es incorrecto, " +
                        $"se espera mes y año (mmyyyy) delante del archivo. Archivo: {nombreArchivo}"
                };

                UtilsLocal.LogCargaList.Add(logCarga);
                errorAgregado = true;
                throw new Exception(ex.Message, ex);
            }
        }

        /// <summary>
        /// Asigna los datos de cada propiedad a un Datarow
        /// </summary>
        /// <param name="dt"></param>
        /// <returns></returns>
        public DataRow AsignarDatos(DataTable dt)
        {
            DataRow dr = dt.NewRow();
            dr["CargaId"] = CabeceraCargaId;

            foreach (var propCol in PropiedadCol)
            {
                if (propCol.Value.Valor != null)
                {
                    dr[propCol.Key] = propCol.Value.Valor;
                }
                else
                {
                    dr[propCol.Key] = DBNull.Value;
                }
            }

            return dr;
        }

        public int AgregarCabecera(CabeceraCarga cabecera)
        {
            CabeceraCargaId = CabeceraCargaBL.GetInstance().Add(cabecera);

            return CabeceraCargaId;
        }

        public void ActualizarCabecera(EstadoCarga estado)
        {
            if (CabeceraCargaId != 0)
            {
                CabeceraCargaBL.GetInstance().Update(new CabeceraCarga
                {
                    Id = CabeceraCargaId,
                    FechaCargaFin = DateTime.Now,
                    EstadoCarga = estado.GetNumberValue()
                });
            }
        }

        public void RegistrarCarga(DataTable dt, string nameTable)
        {
            try
            {
                if (!ErrorCargaList.Any())
                {
                    CargaArchivoBL.GetInstance().Add(dt, nameTable);
                    ActualizarCabecera(EstadoCarga.Procesado);

                    var logCarga = new LogCarga
                    {
                        TipoLog = TipoLogCarga.ArchivoCargaOk.GetStringValue(),
                        CargaId = CabeceraCargaId,
                        TipoArchivo = TipoArchivo,
                        DetalleLog = $"Archivo Cargado Correctamente. Archivo: {nombreArchivo}"
                    };

                    UtilsLocal.LogCargaList.Add(logCarga);
                }
                else
                {
                    ActualizarCabecera(EstadoCarga.Fallido);
                }
            }
            catch (Exception ex)
            {
                ActualizarCabecera(EstadoCarga.Fallido);
                var logCarga = new LogCarga
                {
                    TipoLog = TipoLogCarga.CargaDatos.GetStringValue(),
                    CargaId = CabeceraCargaId,
                    TipoArchivo = TipoArchivo,
                    DetalleLog = $"Error al cargar los datos: {ex.Message}"
                };

                UtilsLocal.LogCargaList.Add(logCarga);
                errorAgregado = true;
                throw new Exception(ex.Message, ex);
            }
        }

        public void AgregarErrorGeneral(Exception ex)
        {
            if (!errorAgregado)
            {
                var logCarga = new LogCarga
                {
                    TipoLog = TipoLogCarga.ErrorGeneral.GetStringValue(),
                    TipoArchivo = TipoArchivo,
                    DetalleLog = $"Error General: {ex.Message}"
                };

                UtilsLocal.LogCargaList.Add(logCarga);
            }
        }

        #endregion

        #region Métodos Privados

        private void InicializarDiccionario()
        {
            PropiedadCol = UtilsLocal.GetPropiedadesColumna<T>(HojaBd);
            MetodoTipoDato = new Dictionary<string, Func<string, bool>>
            {
                {TipoDato.Entero.GetStringValue(), Utils.EsEntero},
                {TipoDato.Letras.GetStringValue(), Utils.EsSoloLetras},
                {TipoDato.NumeroYLetras.GetStringValue(), Utils.EsNumeroYLetras},
                {TipoDato.Fecha.GetStringValue(), Utils.EsFecha},
                {TipoDato.Decimal.GetStringValue(), Utils.EsDecimal}
            };
        }

        /// <summary>
        /// Permite evaluar si el valor de la propiedad se valida o no
        /// </summary>
        /// <param name="prop"></param>
        /// <returns></returns>
        private bool ValidarValor(PropiedadColumna prop)
        {
            if ((prop.Valor == string.Empty && prop.PermiteNulo)
                || (prop.ValorIgnorar != null && prop.ValorIgnorar.Contains(prop.Valor)))
            {
                prop.Valor = prop.ValorDefecto;
                return false;
            }

            return true;
        }

        #endregion
    }
}