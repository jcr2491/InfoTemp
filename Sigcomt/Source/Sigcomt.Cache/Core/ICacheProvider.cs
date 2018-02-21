namespace Sigcomt.Cache.Core
{
    public interface ICacheProvider
    {
        /// <summary>
        /// Insert value into the cache using
        /// appropriate name/value pairs
        /// </summary>
        /// <typeparam name="T">Type of cached item</typeparam>
        /// <param name="value">Item to be cached</param>
        /// <param name="key">Name of item</param>
        void AddItem<T>(T value, string key) where T : class;

        /// <summary>
        /// Remove item from cache
        /// </summary>
        /// <param name="key">Name of cached item</param>
        void RemoveItem(string key);

        /// <summary>
        /// Remove items from cache by start string
        /// </summary>
        /// <param name="startKey">String of cached items</param>
        void RemoveItems(string startKey);

        /// <summary>
        /// Check for item in cache
        /// </summary>
        /// <param name="key">Name of cached item</param>
        /// <returns></returns>
        bool ExistsItem(string key);

        /// <summary>
        /// Retrieve cached item
        /// </summary>
        /// <typeparam name="T">Type of cached item</typeparam>
        /// <param name="key">Name of cached item</param>
        /// <returns>Cached item as type</returns>
        T GetItem<T>(string key) where T : class;

        /// <summary>
        /// Remove all items from cache
        /// </summary>
        void RemoveAll();
    }
}
