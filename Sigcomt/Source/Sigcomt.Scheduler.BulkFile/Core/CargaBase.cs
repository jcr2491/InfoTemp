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
using Sigcomt.DataAccess;

namespace Sigcomt.Scheduler.BulkFile.Core
{
    public class CargaBase<T>
    {
        public Dictionary<string, PropiedadColumna> PropiedadCol { get; private set; }
        public Dictionary<string, Func<string, bool>> MetodoTipoDato { get; private set; }
        public List<ErrorCarga> ErrorCargaList;
        public Excel ExcelBd { get; }
        public ExcelHoja HojaBd { get; }
        public int CabeceraCargaId { get; private set; }
        private bool esErrorCarga;

        #region Método Constructor

        public CargaBase()
        {

        }

        public CargaBase(string tipoArchivo)
        {
            ExcelBd = UtilsLocal.ExcelList.First(p => p.HojasList.Any(q => q.TipoArchivo == tipoArchivo));
            HojaBd = ExcelBd.HojasList.First(p => p.TipoArchivo == tipoArchivo);
            ErrorCargaList = new List<ErrorCarga>();

            InicializarDiccionario();
        }

        #endregion

        #region Métodos Públicos

        public bool EsEntero(string valor)
        {
            string pattern = @"^[0-9]+$";
            return Regex.IsMatch(valor, pattern);
        }

        public bool EsDecimal(string valor)
        {
            string pattern = @"^[0-9]+([.,][0-9]+)?$";
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
            string pattern = @""; //TODO: poner patron
            return Regex.IsMatch(valor, pattern);
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
                propCol.Value.Valor = excel.GetCellToString(fila, propCol.Value.PosicionColumna);
                bool isValid = true;

                if (ValidarValor(propCol.Value))
                {
                    isValid = MetodoTipoDato[propCol.Value.TipoDato].Invoke(propCol.Value.Valor);
                }                

                if (!isValid)
                {
                    isAllValid = false;
                    ErrorCarga errorCarga = new ErrorCarga
                    {
                        CargaId = CabeceraCargaId,
                        Fila = numFila,
                        PosicionColumna = propCol.Value.PosicionColumna + 1,
                        NombreColumna = propCol.Key,
                        DetalleError = $"El valor es incorrecto: {propCol.Value.Valor}"
                    };
                    ErrorCargaList.Add(errorCarga);
                    UtilsLocal.ErrorCargaList.Add(errorCarga);
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
                dr[propCol.Key] = propCol.Value.Valor;
            }

            return dr;
        }

        public int AgregarCabecera(CabeceraCarga cabecera)
        {
            CabeceraCargaId = CabeceraCargaBL.GetInstance().Add(cabecera);

            return CabeceraCargaId;
        }

        public void ActualizarCabecera(int cabeceraId, EstadoCarga estado)
        {
            if (cabeceraId != 0)
            {
                CabeceraCargaBL.GetInstance().Update(new CabeceraCarga
                {
                    Id = cabeceraId,
                    FechaCargaFin = DateTime.Now,
                    EstadoCarga = estado.GetNumberValue()
                });
            }
        }

        public void ActualizarCabecera(EstadoCarga estado)
        {
            ActualizarCabecera(CabeceraCargaId, estado);
        }

        public void RegistrarCarga(DataTable dt, string nameTable)
        {
            if (!ErrorCargaList.Any())
            {
                CargaArchivoRepository.GetInstance().Add(dt, nameTable);
                esErrorCarga = false;
            }
        }

        /// <summary>
        /// Registra los errores en la base de datos
        /// </summary>
        public void RegistrarError()
        {
            if (ErrorCargaList.Any())
            {
                //Todo: Se debe registrar en la BD
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