﻿namespace Sigcomt.WinForms.BulkCopy.ClasesCarga.Rapicash
{
    public class CargaRapicashSodimac
    {
        #region Métodos Públicos
        public static void CargarArchivos()
        {
            CargaMetaSodimacRapicash.CargarArchivo();
            CargaGanadoresSodimacRapicash.CargarArchivo();
        }
        #endregion
    }
}
