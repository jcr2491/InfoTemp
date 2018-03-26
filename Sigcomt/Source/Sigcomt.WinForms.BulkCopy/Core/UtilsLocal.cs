using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using NPOI.SS.Util;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic;
using Sigcomt.Common;

namespace Sigcomt.WinForms.BulkCopy.Core
{
    public class UtilsLocal
    {
        public static List<Excel> ExcelList;
        public static List<LogCarga> LogCargaList;
        public static List<string> TipoArchivoList;
        public static List<TipoComisionArchivo> TipoComisionArchivoList;
        public static Dictionary<string, Func<string, bool>> MetodoTipoDatoList;
        public static DateTime Fecha;
        public static DateTime FechaCarga;
        public static BackgroundWorker Worker;
        public static int FactorIncremento;
        public static int ProgresoTotal;

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

        public static Dictionary<string, PropiedadColumna> GetPropiedadesColumna(ExcelHoja excelHoja, List<TablaColumna> columnaList)
        {
            var columnas = new Dictionary<string, PropiedadColumna>();

            foreach (var column in columnaList)
            {
                var campo = excelHoja.CampoList.FirstOrDefault(p =>
                    string.Equals(p.NombreCampo, column.Columna, StringComparison.CurrentCultureIgnoreCase));

                if (campo != null)
                {
                    columnas.Add(column.Columna, new PropiedadColumna
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
            Fecha = fecha;

            foreach (var log in LogCargaList)
            {
                secuencia++;

                DataRow dr = dt.NewRow();
                dr["FechaLog"] = fecha;
                dr["Secuencia"] = secuencia;
                dr["TipoLog"] = log.TipoLog;
                dr["PosicionColumna"] = log.PosicionColumna;
                dr["NombreCampo"] = log.NombreCampo;
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

        public static List<Archivo> GetArchivoEstadoCarga()
        {
            return CargaArchivoBL.GetInstance().GetArchivosEstado(Fecha);
        }

        /// <summary>
        /// Permite determinar si se inicia la carga del archivo
        /// </summary>
        /// <param name="tipoArchivo"></param>
        /// <returns></returns>
        public static bool PermitirCargaArchivo(string tipoArchivo)
        {
            return TipoArchivoList.Any(p => p == tipoArchivo);
        }

        public static void AsignarEstado(MensajeEstado estado)
        {
            ProgresoTotal += estado.Progreso;
            Worker.ReportProgress(ProgresoTotal, estado);
        }

        public static void AsignarEstadoInicioCarga(string tipoArchivo)
        {
            AsignarEstado(new MensajeEstado
            {
                Progreso = 0,
                Mensaje = string.Format(Constantes.InicioCarga, GetNombreArchivo(tipoArchivo)),
                ColorMensaje = Color.Black
            });
        }

        public static void AsignarEstadoFinCarga(string tipoArchivo)
        {
            AsignarEstado(new MensajeEstado
            {
                Progreso = FactorIncremento,
                Mensaje = string.Format(Constantes.FinCarga, GetNombreArchivo(tipoArchivo)),
                ColorMensaje = Color.Black
            });
        }

        public static void AsignarEstado(string mensaje)
        {
            AsignarEstado(new MensajeEstado
            {
                Progreso = 0,
                Mensaje = mensaje,
                ColorMensaje = Color.Black
            });
        }

        public static void AsignarEstadoError(string mensaje)
        {
            AsignarEstado(new MensajeEstado
            {
                Progreso = 0,
                Mensaje = mensaje,
                ColorMensaje = Color.DarkRed
            });
        }

        public static void AsignarEstadoError(int progreso, string mensaje)
        {
            AsignarEstado(new MensajeEstado
            {
                Progreso = progreso,
                Mensaje = mensaje,
                ColorMensaje = Color.DarkRed
            });
        }

        public static void AsignarEstadoCorrecto(string mensaje)
        {
            AsignarEstado(new MensajeEstado
            {
                Progreso = 0,
                Mensaje = mensaje,
                ColorMensaje = Color.DarkGreen
            });
        }

        /// <summary>
        /// Retorna el nombre del archivo
        /// </summary>
        /// <param name="tipoArchivo"></param>
        /// <returns></returns>
        public static string GetNombreArchivo(string tipoArchivo)
        {
            var archivo = TipoComisionArchivoList.FirstOrDefault(p => p.TipoArchivoId == tipoArchivo);
            return archivo != null ? archivo.TipoArchivoNombre : string.Empty;
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