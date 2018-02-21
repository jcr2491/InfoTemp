using Sigcomt.Common;

namespace Sigcomt.Cache.Core
{
    public abstract class CacheConfigurator
    {
        public static int Minutes = ConfigurationAppSettings.TimeOutCache();
    }
}
