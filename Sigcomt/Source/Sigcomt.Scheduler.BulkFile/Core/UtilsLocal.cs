using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using NPOI.SS.Util;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic;
using Sigcomt.Common;

namespace Sigcomt.Scheduler.BulkFile.Core
{
    public class UtilsLocal
    {
        public static List<Excel> ExcelList;
        public static List<LogCarga> LogCargaList;

        public static void CargarDatosIniciales()
        {
           ExcelList = ExcelBL.GetInstance().GetExcel();
           LogCargaList = new List<LogCarga>();
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
                        LetraColumna = Utils.EsEntero(campo.PosicionColumna)
                            ? null
                            : campo.PosicionColumna,
                        PosicionColumna = Utils.EsEntero(campo.PosicionColumna)
                            ? Convert.ToInt32(campo.PosicionColumna)
                            : CellReference.ConvertColStringToIndex(campo.PosicionColumna)
                    });
                }
            }

            return columnas;
        }

        public static List<DetalleLogCarga> RegistrarLogCarga()
        {            
            int secuencia = 0;
            DataTable dt = Utils.CrearCabeceraDataTable<LogCarga>();
            DateTime fecha = DateTime.Now;

            foreach (var log in LogCargaList)
            {
                secuencia++;

                DataRow dr = dt.NewRow();
                dr["FechaLog"] = fecha;
                dr["Secuencia"] = secuencia;
                dr["TipoLog"] = log.TipoLog;                
                dr["PosicionColumna"] = log.PosicionColumna;                
                dr["DetalleLog"] = log.DetalleLog;

                if (log.CargaId != null)
                    dr["CargaId"] = log.CargaId;

                if (log.TipoArchivo != null)
                    dr["TipoArchivo"] = log.TipoArchivo;

                if (log.NumFila != null)
                    dr["NumFila"] = log.NumFila;

                if (log.ExcelHojaCampoId != null)
                    dr["ExcelHojaCampoId"] = log.ExcelHojaCampoId;

                dt.Rows.Add(dr);
            }

            CargaArchivoBL.GetInstance().Add(dt, "LogCarga");

            // Obtenemos los errores
            return CargaArchivoBL.GetInstance().GetLogCarga(fecha);
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