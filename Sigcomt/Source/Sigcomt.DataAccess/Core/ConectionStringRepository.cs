using System.Configuration;

namespace Sigcomt.DataAccess.Core
{
    public static class ConectionStringRepository
    {
        #region Propiedades

        #region ConnectionString

        public static string ConnectionStringSQL => ConfigurationManager.ConnectionStrings["ConnectionStringSQL"].ConnectionString;

        #endregion

        #region ConnectionStringName

        public static string ConnectionStringNameSQL => "ConnectionStringSQL";

        #endregion


        #region AppSettings

        public static string ConexionExcel => "ConexionExcel";

        #endregion

        public static string EsquemaName => "Comisiones";

        #endregion
    }
}
