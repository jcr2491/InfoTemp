namespace Sigcomt.WinForms.BulkCopy.ClasesCarga.MatenimientoIndicador
{
    public class CargaMantenimientoIndicador
    {
        public static bool CargarArchivos()
        {
            bool result = false;
            if (CargaKPIIndicador.CargarArchivo() && CargaIndicador.CargarArchivo() && CargaHomologacionIndicador.CargarArchivo() &&
                CargaPesoKPI.CargarArchivo() && CargaTarifarioIndicador.CargarArchivo() && CargaEscalaFormatoCCFF.CargarArchivo() &&
                CargaPotenciarKPI.CargarArchivo())
            {
                result = true;
            }
            return result;
        } 

    }
}
