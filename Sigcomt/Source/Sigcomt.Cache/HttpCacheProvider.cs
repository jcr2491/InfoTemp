using Sigcomt.Cache.Core;
using System;
using System.Collections;
using System.Linq;
using System.Web;

namespace Sigcomt.Cache
{
    public class HttpCacheProvider : BaseCacheProvider
    {
        //protected override void AddItem(string key, object value)
        //{
        //    HttpContext.Current.Cache.Insert(
        //        key,
        //        value,
        //        null,
        //        DateTime.UtcNow.AddMinutes(CacheConfigurator.Minutes),
        //        System.Web.Caching.Cache.NoSlidingExpiration
        //    );
        //}

        protected override object GetItem(string key)
        {
            if (ExistsItem(key))
            {
                return HttpContext.Current.Cache[key];
            }
            return null;
        }

        protected override void RemoveItem(string key)
        {
            HttpContext.Current.Cache.Remove(key);
        }

        protected override void RemoveItems(string startKey)
        {
            var keysToClear = (from DictionaryEntry obj in HttpContext.Current.Cache
                               let key = obj.Key.ToString()
                               where key.StartsWith(startKey)
                               select key).ToList();

            foreach (var key in keysToClear)
            {
                HttpContext.Current.Cache.Remove(key);
            }
        }

        protected override void RemoveAll()
        {
            var keysToClear = (from DictionaryEntry obj in HttpContext.Current.Cache
                               let key = obj.Key.ToString()
                               select key).ToList();

            foreach (var key in keysToClear)
            {
                HttpContext.Current.Cache.Remove(key);
            }
        }

        protected override bool ExistsItem(string key)
        {
            return HttpContext.Current.Cache[key] != null;
        }
    }
}
