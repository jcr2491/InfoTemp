using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic.Interfaces;
using Sigcomt.Cache;
using Sigcomt.Cache.Core;
using Sigcomt.DataAccess;
using System.Collections.Generic;
using System.Linq;
using Core.Singleton;

namespace Sigcomt.Business.Logic
{
    public class ItemTablaBL : Singleton<ItemTablaBL>, IItemTablaBL<ItemTabla,int>
    {
        private static readonly ICacheProvider CacheProvider = new HttpCacheProvider();

        public IList<ItemTabla> GetAllByTablaId(int tablaId)
        {
            var keyCache = string.Format("{0}.{1}", CacheTypes.ItemTabla, tablaId);

            if (!CacheProvider.ExistsItem(keyCache))
            {
                var cacheValue = ItemTablaRepository.GetInstance().GetAllByTablaId(tablaId).OrderBy(p => p.Nombre).ToList();
                CacheProvider.AddItem(cacheValue, keyCache);
            }
            return CacheProvider.GetItem<List<ItemTabla>>(keyCache).OrderBy(p => p.Nombre).ToList();
        }
    }
}