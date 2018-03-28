using System.Configuration;

namespace Sigcomt.Common
{
    public class ConfigurationAppSettings
    {
        public static bool ValidarAd => ConfigurationManager.AppSettings.Get("ValidacionAD") == "1";

        public static string CultureNameDefault()
        {
            var cultureNameDefault = ConfigurationManager.AppSettings.Get("CultureNameDefault");

            if (string.IsNullOrEmpty(cultureNameDefault))
            {
                return "es-PE";
            }
            return cultureNameDefault;
        }

        public static string DominiosAD()
        {
            return ConfigurationManager.AppSettings.Get("DominiosAD");
        }

        public static string ConnectionActiveDirectory()
        {
            return ConfigurationManager.AppSettings.Get("ConnectionActiveDirectory");
        }

        public static int TimeOutCache()
        {
            var timeOutCache = ConfigurationManager.AppSettings.Get("TimeOutCache");

            if (string.IsNullOrEmpty(timeOutCache))
            {
                return 1440;
            }
            return int.Parse(timeOutCache);
        }
    }
}