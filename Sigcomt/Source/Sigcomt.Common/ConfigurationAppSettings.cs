using System.Configuration;

namespace Sigcomt.Common
{
    public class ConfigurationAppSettings
    {
        public static string ConnectionAd => ConfigurationManager.ConnectionStrings["ConnectionActiveDirectory"].ConnectionString;

        public static bool ValidarAd => ConfigurationManager.AppSettings.Get("ValidarAD") == "1";
    }
}