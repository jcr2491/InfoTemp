namespace Sigcomt.WinForms.BulkCopy.ClasesCarga.Base
{
    public class CargaBaseArchivo
    {
        public static bool CargaArchivos()
        {
            if (CargaEmpleado.CargarArchivo() && CargaRICCFF.CargarArchivo())
            {
                CargaHomologacionEmpleado.CargarArchivo();
                CargaHomologacionCCFF.CargarArchivo();
                return true;
            }

            return false;
        }
    }
}