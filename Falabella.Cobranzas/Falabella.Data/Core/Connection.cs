using System.Configuration;

namespace Falabella.Data.Core
{
    public static class Connection
    {
        public static string ConnectionStringSql => ConfigurationManager.ConnectionStrings["ConnectionStringSQL"].ConnectionString;

        public static string ConnectionStrinName => "DefaultConnection";

        public static string EsquemaName => ConfigurationManager.AppSettings["Esquema"];
    }
}