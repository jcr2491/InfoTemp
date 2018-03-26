using Sigcomt.Business.Entity;

namespace Sigcomt.WinForms.BulkCopy.Core
{
    public static class Constantes
    {
        public static string ArchivoCargadoSatisfactoriamente = "Archivo {0} cargado satisfactoriamente";
        public static string HuboUnErrorAlCargar = "Hubo un error al cargar {0}";

        public static string Todos = "Todos";
        public static string Error = "Error";
        public static Usuario Usuario = null;
        public static string UsuarioRequerido = "Usuario es requerido";
        public static string ClaveRequerida = "Clave es requerida";
        public static string CredencialesIncorrectas = "Las credenciales especificadas son incorrectas o el usuario no está registrado";
        public static string SeleccioneElemento = "Seleccione al menos un elemento";
        public static string TituloCargaTerminada = "Proceso de carga culminada";
        public static string PorcentajeCompletado = "{0}% Completado";
        public static string ProcesandoArchivo = "Se está procesando el archivo: \"{0}\" Hoja: \"{1}\"";
        public static string InicioCarga = "Se inició la carga del archivo \"{0}\"";
        public static string FinCarga = "Se terminó la carga del archivo \"{0}\"";
        public static string FinLectura = "Se terminó la lectura del archivo \"{0}\" Hoja \"{1}\"";
        public static string CargaCompleta = "Se completó la carga de todos los archivos inputs.";
        public static string FilasDiferente = "Número de filas de la hoja \"{0}\" es diferente a las demás";
        public static string FaltaCentroFinanciero = "Falta el Centro Financiero \"{0}\" en la hoja \"{1}\"";
        public static string CargaTerminada =
            "Se terminó la ejecución de la carga de archivos. Se envió por correo el detalle de la carga.";
        public static string ErrorCargaIndicadores =
            "Ocurrió un error al cargar los archivos Base Mantenimiento Indicadores, por favor verifique su correo para mas detalle.";
        public static string ErrorCargaFundamentales =
            "Ocurrió un error al cargar los archivos Base fundamentales, por favor verifique su correo para mas detalle.";
    }
}