using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
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

        public bool EsEntero(string valor)
        {
            string pattern = @"^-?[0-9]+$";
            return Regex.IsMatch(valor, pattern);
        }

        public bool EsDecimal(string valor)
        {
            string pattern = @"^-?[0-9]+([.,][0-9]+)?$";
            return Regex.IsMatch(valor, pattern);
        }

        public bool EsSoloLetras(string valor)
        {
            string pattern = @"^[a-zA-ZñÑ\s]";
            return Regex.IsMatch(valor, pattern);
        }

        public bool EsNumeroYLetras(string valor)
        {
            string pattern = @"[A-Z0-9 a-z]*$";
            return Regex.IsMatch(valor, pattern);
        }

        public bool EsFecha(string valor)
        {
            // dd/mm/yyyy o dd-mm-yyyy
            string pattern = @"^(?:(?:0?[1-9]|1\d|2[0-8])(\/|-)(?:0?[1-9]|1[0-2]))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(?:(?:31(\/|-)(?:0?[13578]|1[02]))|(?:(?:29|30)(\/|-)(?:0?[1,3-9]|1[0-2])))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(29(\/|-)0?2)(\/|-)(?:(?:0[48]00|[13579][26]00|[2468][048]00)|(?:\d\d)?(?:0[48]|[2468][048]|[13579][26]))$";
            if (Regex.IsMatch(valor, pattern)) return true;

            // mm/dd/yyyy o mm-dd-yyyy
            pattern = @"^(?:(?:(?:0?[13578]|1[02])(\/|-)31)|(?:(?:0?[1,3-9]|1[0-2])(\/|-)(?:29|30)))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(?:(?:0?[1-9]|1[0-2])(\/|-)(?:0?[1-9]|1\d|2[0-8]))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(0?2(\/|-)29)(\/|-)(?:(?:0[48]00|[13579][26]00|[2468][048]00)|(?:\d\d)?(?:0[48]|[2468][048]|[13579][26]))$";
            if (Regex.IsMatch(valor, pattern)) return true;

            return false;
        }

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

                throw new Exception(ex.Message, ex);
            }
        }

        #endregion

        #region Métodos Privados

        private void InicializarDiccionario()
        {
            PropiedadCol = UtilsLocal.GetPropiedadesColumna<T>(HojaBd);
            MetodoTipoDato = new Dictionary<string, Func<string, bool>>
            {
                {TipoDato.Entero.GetStringValue(), EsEntero},
                {TipoDato.Letras.GetStringValue(), EsSoloLetras},
                {TipoDato.NumeroYLetras.GetStringValue(), EsNumeroYLetras},
                {TipoDato.Fecha.GetStringValue(), EsFecha},
                {TipoDato.Decimal.GetStringValue(), EsDecimal}
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