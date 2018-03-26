using Sigcomt.WinForms.BulkCopy.ClasesCarga.Automotriz;

namespace Sigcomt.WinForms.BulkCopy.ClasesCarga.Automotriz
{
    public class CargaAutomotriz
    {
        #region Métodos Públicos

        public static void CargarArchivos()
        {
            if (CargaMantenimientoAutomotriz.CargarArchivo() && CargaMetaEmpleadoAutomotriz.CargarArchivo() &&
                 CargaMetaEmpleadoCCFFAutomotriz.CargarArchivo())
            {
                CargaDataAutomotriz.CargarArchivo();
            }

        }
        #endregion
    }
}
