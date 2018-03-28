using System;
using System.Linq;
using Falabella.Business;
using Falabella.CrossCutting;
using Falabella.CrossCutting.Enums;
using Falabella.Entity;

namespace Falabella.Consola
{
    public class UtilsLocal
    {
        public static string GetMessageError(bool fileError, string[] campos, int numLinea, string messageException)
        {
            if (!fileError || campos == null)
            {
                return $"Error: {messageException}";
            }

            string detalleLinea = campos.Aggregate(string.Empty, (current, t) => current + (t + ", "));

            return $"Error en archivo en la linea {numLinea}, {detalleLinea} \nError: {messageException}";
        }

        public static int AgregarCabecera(TipoArchivo tipoArchivo, EstadoCarga estado, DateTime fechaFile)
        {
            int cabeceraId = CabeceraCargaBL.GetInstance().Add(new CabeceraCarga
            {
                TipoArchivo = tipoArchivo.GetStringValue(),
                FechaCargaIni = DateTime.Now,
                FechaArchivo = fechaFile,
                EstadoCarga = estado.GetNumberValue()
            });

            return cabeceraId;
        }

        public static void ActualizarCabecera(int cabeceraId, EstadoCarga estado)
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
    }
}