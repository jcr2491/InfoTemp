using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using NPOI.SS.Util;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic;
using Sigcomt.Common;
using Sigcomt.DataAccess;

namespace Sigcomt.Scheduler.BulkFile.Core
{
    public class UtilsLocal
    {
        public static List<Excel> ExcelList;
        public static List<ErrorCarga> ErrorCargaList;

        public static void CargarDatosIniciales()
        {
           ExcelList = ExcelBL.GetInstance().GetExcel();
           ErrorCargaList = new List<ErrorCarga>();
        }

        public static Dictionary<string, PropiedadColumna> GetPropiedadesColumna<T>(ExcelHoja excelHoja)
        {
            var columnas = new Dictionary<string, PropiedadColumna>();
            var propiedades = typeof(T).GetProperties();

            foreach (var prop in propiedades)
            {
                var campo = excelHoja.CampoList.FirstOrDefault(p =>
                    string.Equals(p.NombreCampo, prop.Name, StringComparison.CurrentCultureIgnoreCase));

                if (campo != null)
                {
                    columnas.Add(prop.Name, new PropiedadColumna
                    {
                        ExcelHojaCampoId = campo.Id,
                        TipoDato = campo.TipoDato,
                        PermiteNulo = campo.PermiteNulo,
                        ValorDefecto = campo.ValorDefecto,
                        ValorIgnorar = campo.ValorIgnorar,
                        LetraColumna = Utils.IsNumber(campo.PosicionColumna)
                            ? null
                            : campo.PosicionColumna,
                        PosicionColumna = Utils.IsNumber(campo.PosicionColumna)
                            ? Convert.ToInt32(campo.PosicionColumna)
                            : CellReference.ConvertColStringToIndex(campo.PosicionColumna)
                    });
                }
            }

            return columnas;
        }

        public static List<DetalleErrorCarga> RegistrarErrorCarga()
        {            
            int secuencia = 0;
            DataTable dt = Utils.CrearCabeceraDataTable<ErrorCarga>();
            DateTime fecha = DateTime.Now;

            foreach (var error in ErrorCargaList)
            {
                secuencia++;

                DataRow dr = dt.NewRow();
                dr["FechaError"] = fecha;
                dr["Secuencia"] = secuencia;
                dr["TipoError"] = error.TipoError;                
                dr["PosicionColumna"] = error.PosicionColumna;                
                dr["DetalleError"] = error.DetalleError;

                if (error.CargaId != null)
                    dr["CargaId"] = error.CargaId;

                if (error.NumFila != null)
                    dr["NumFila"] = error.NumFila;

                if (error.ExcelHojaCampoId != null)
                    dr["ExcelHojaCampoId"] = error.ExcelHojaCampoId;

                dt.Rows.Add(dr);
            }

            CargaArchivoRepository.GetInstance().Add(dt, "ErrorCarga");

            // Obtenemos los errores
            return CargaArchivoRepository.GetInstance().GetUltimaCargaPorArchivo(fecha);
        }

        public static string GetMessageError(bool fileError, string[] campos, int numLinea, string messageException)
        {
            if (!fileError || campos == null)
            {
                return $"Error: {messageException}";
            }

            string detalleLinea = campos.Aggregate(string.Empty, (current, t) => current + (t + ", "));

            return $"Error en archivo en la linea {numLinea}, {detalleLinea} \nError: {messageException}";
        }

        public static string GetMessageError(string messageException)
        {
            return $"Error: {messageException}";
        }
    }
}