using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.IO;
using NPOI.SS.UserModel;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic;
using Sigcomt.Common;
using Sigcomt.Common.Enums;

namespace Sigcomt.Scheduler.BulkFile.Core
{
    public class CargaBase
    {
        public Dictionary<string, PropiedadColumna> PropiedadCol { get; private set; }
        public List<LogCarga> ErrorCargaList;
        public Excel ExcelBd { get; }
        public ExcelHoja HojaBd { get; private set; }
        public List<TablaColumna> ColumnaList { get; }
        public int CabeceraCargaId { get; private set; }
        public string TipoArchivo { get; private set; }
        private bool _errorAgregado;
        private string _nombreArchivo;

        #region Método Constructor

        public CargaBase(string tipoArchivo, string tabla)
        {
            ExcelBd = UtilsLocal.ExcelList.First(p => p.HojasList.Any(q => q.TipoArchivo == tipoArchivo));
            ErrorCargaList = new List<LogCarga>();
            TipoArchivo = tipoArchivo;
            ColumnaList = CargaArchivoBL.GetInstance().GetColumnasTabla(tabla);
            AsignarHojaBd(tipoArchivo);
        }

        #endregion

        #region Métodos Públicos

        /// <summary>
        /// Valida que todos los datos del excel estén correctos
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
                    isValid = UtilsLocal.MetodoTipoDatoList[propCol.Value.TipoDato].Invoke(propCol.Value.Valor);
                }

                if (!isValid)
                {
                    isAllValid = false;
                    AgregarLogValidacionDatos(propCol, numFila,
                        $"El valor es incorrecto: {propCol.Value.Valor} (tipo de dato esperado: {TipoDato(propCol.Value.TipoDato)})");
                }
            }

            return isAllValid;
        }

        /// <summary>
        /// Valida que todos los datos de un arreglo de valores (archivos csv)
        /// </summary>
        /// <param name="campos"></param>
        /// <param name="numFila"></param>
        /// <returns></returns>
        public bool ValidarDatos(string[] campos, int numFila)
        {
            bool isAllValid = true;

            foreach (var propCol in PropiedadCol)
            {
                bool isValid = true;
                propCol.Value.Valor = campos[propCol.Value.PosicionColumna].Trim();

                if (ValidarValor(propCol.Value))
                {
                    isValid = UtilsLocal.MetodoTipoDatoList[propCol.Value.TipoDato].Invoke(propCol.Value.Valor);
                }

                if (!isValid)
                {
                    isAllValid = false;
                    AgregarLogValidacionDatos(propCol, numFila + 1, $"El valor es incorrecto: {propCol.Value.Valor}");
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
                        DetalleLog = "No existen archivos para cargar"
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
                _errorAgregado = true;
                throw new Exception(ex.Message, ex);
            }
        }

        public void ValidarExisteDirectorio()
        {
            if (!Directory.Exists(ExcelBd.Ruta))
            {
                var logCarga = new LogCarga
                {
                    TipoLog = TipoLogCarga.NoExisteDirectorio.GetStringValue(),
                    TipoArchivo = TipoArchivo,
                    DetalleLog = $"No existe el directorio del archivo a cargar (Se espera la ruta {ExcelBd.Ruta})."
                };

                UtilsLocal.LogCargaList.Add(logCarga);
                _errorAgregado = true;
                throw new Exception(logCarga.DetalleLog);
            }
        }

        public DateTime GetFechaArchivo(string fileName)
        {
            try
            {
                var split = fileName.Split('\\');
                string onlyName = split[split.Length - 1];
                _nombreArchivo = onlyName;

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
                    DetalleLog = "El formato del nombre del archivo a cargar es incorrecto, " +
                        $"se espera mes y año (mmyyyy) delante del archivo. Archivo: {_nombreArchivo}"
                };

                UtilsLocal.LogCargaList.Add(logCarga);
                _errorAgregado = true;
                throw new Exception(ex.Message, ex);
            }
        }

        public GenericExcel GetHojaExcel(string rutaArchivo)
        {
            FileStream file = new FileStream(rutaArchivo, FileMode.Open, FileAccess.Read);
            GenericExcel excel = new GenericExcel(file, HojaBd.NombreHoja);

            if (excel.Sheet == null)
            {
                var logCarga = new LogCarga
                {
                    TipoLog = TipoLogCarga.HojaExcelNoExiste.GetStringValue(),
                    TipoArchivo = TipoArchivo,
                    DetalleLog = $"La hoja \"{HojaBd.NombreHoja}\" del archivo \"{_nombreArchivo}\" no existe"
                };

                UtilsLocal.LogCargaList.Add(logCarga);
                _errorAgregado = true;
                throw new Exception(logCarga.DetalleLog);
            }

            return excel;
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
                if(propCol.Value.OmitirPropiedad) continue;

                if (!string.IsNullOrWhiteSpace(propCol.Value.Valor))
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

        public int AgregarCabeceraCarga(CabeceraCarga cabecera)
        {
            CabeceraCargaId = CabeceraCargaBL.GetInstance().Add(cabecera);

            return CabeceraCargaId;
        }

        public void ActualizarCabeceraCarga(EstadoCarga estado)
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
                    ActualizarCabeceraCarga(EstadoCarga.Procesado);

                    var logCarga = new LogCarga
                    {
                        TipoLog = TipoLogCarga.ArchivoCargaOk.GetStringValue(),
                        CargaId = CabeceraCargaId,
                        TipoArchivo = TipoArchivo,
                        DetalleLog = $"Archivo Cargado Correctamente. Archivo: {_nombreArchivo}"
                    };

                    UtilsLocal.LogCargaList.Add(logCarga);
                }
                else
                {
                    ActualizarCabeceraCarga(EstadoCarga.Fallido);
                }
            }
            catch (Exception ex)
            {
                ActualizarCabeceraCarga(EstadoCarga.Fallido);
                var logCarga = new LogCarga
                {
                    TipoLog = TipoLogCarga.CargaDatos.GetStringValue(),
                    CargaId = CabeceraCargaId,
                    TipoArchivo = TipoArchivo,
                    DetalleLog = $"Error al cargar los datos: {ex.Message}"
                };

                UtilsLocal.LogCargaList.Add(logCarga);
                _errorAgregado = true;
                throw new Exception(ex.Message, ex);
            }
        }

        public void AgregarErrorGeneral(Exception ex)
        {
            if (!_errorAgregado)
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

        public DataTable CrearCabeceraDataTable()
        {
            DataTable datatable = new DataTable();

            foreach (var column in ColumnaList)
            {
                Type type = Utils.TipoColumna(column.Tipo);
                datatable.Columns.Add(new DataColumn(column.Columna,
                    Nullable.GetUnderlyingType(type) ?? type));
            }

            return datatable;
        }

        /// <summary>
        /// Permite agregar nuevos elementos a la lista de propiedades
        /// </summary>
        /// <param name="nombreCol"></param>
        /// <param name="propCol"></param>
        public void AgregarPropiedadCol(string nombreCol, PropiedadColumna propCol)
        {
            PropiedadCol.Add(nombreCol, propCol);
        }

        /// <summary>
        /// Permite asignar el valor de la hoja excel segun el tipo de archivo
        /// </summary>
        /// <param name="tipoArchivo"></param>
        public void AsignarHojaBd(string tipoArchivo)
        {
            TipoArchivo = tipoArchivo;
            HojaBd = ExcelBd.HojasList.First(p => p.TipoArchivo == tipoArchivo);
            PropiedadCol = UtilsLocal.GetPropiedadesColumna(HojaBd, ColumnaList);
        }

        public void AgregarLogValidacionDatos(KeyValuePair<string, PropiedadColumna> propCol, int numFila, string mensaje)
        {
            var logCarga = new LogCarga
            {
                TipoLog = TipoLogCarga.ValidacionDatos.GetStringValue(),
                CargaId = CabeceraCargaId,
                NumFila = numFila,
                TipoArchivo = TipoArchivo,
                PosicionColumna =
                    propCol.Value.LetraColumna ?? Convert.ToString(propCol.Value.PosicionColumna + 1),
                ExcelHojaCampoId = propCol.Value.ExcelHojaCampoId,
                NombreCampo = propCol.Key,
                DetalleLog = mensaje
            };

            ErrorCargaList.Add(logCarga);
            UtilsLocal.LogCargaList.Add(logCarga);
        }

        #endregion

        #region Métodos Privados

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

        private string TipoDato(string tipodato)
        {
            string respuesta;

            switch (tipodato)
            {
                case "1":
                    respuesta = "Entero";
                    break;
                case "2":
                    respuesta = "Letras";
                    break;
                case "3":
                    respuesta = "Numero y Letras";
                    break;
                case "4":
                    respuesta = "Fecha";
                    break;
                case "5":
                    respuesta = "Decimal";
                    break;
                default:
                    respuesta = "por defecto";
                    break;
            }

            return respuesta;
        }

        #endregion
    }
}