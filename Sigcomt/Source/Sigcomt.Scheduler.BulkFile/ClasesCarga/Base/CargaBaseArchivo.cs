namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.Base
{
    public class CargaBaseArchivo
    {
        public static bool CargaArchivos()
        {
            bool result = true;
            if (CargaEmpleadoCCFF.CargarArchivo() && CargaRICCFF.CargarArchivo())
            {
                CargaHomologacionCCFF.CargarArchivo();
            }
            else
            {
                result = false;
            }
            return result;
        }
    }
}
