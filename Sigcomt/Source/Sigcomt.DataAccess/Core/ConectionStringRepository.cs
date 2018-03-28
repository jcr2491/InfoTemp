using System.Configuration;

namespace Sigcomt.DataAccess.Core
{
    public static class ConectionStringRepository
    {
        #region Propiedades

        public static string ConnectionStringSql => ConfigurationManager.ConnectionStrings["ConnectionStringSQL"].ConnectionString;

        public static string ConnectionStringNameSql => "ConnectionStringSQL";

        public static string EsquemaName => "Comisiones";

        #endregion
    }
}