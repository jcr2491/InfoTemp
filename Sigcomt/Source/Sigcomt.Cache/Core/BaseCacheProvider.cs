namespace Sigcomt.Cache.Core
{
    public abstract class BaseCacheProvider : ICacheProvider
    {
        #region ICacheProvider

        //void ICacheProvider.AddItem<T>(T value, string key)
        //{
        //    AddItem(key, value);
        //}

        T ICacheProvider.GetItem<T>(string key)
        {
            try
            {
                return (T)GetItem(key);
            }
            catch
            {
                return null;
            }
        }

        void ICacheProvider.RemoveItem(string key)
        {
            RemoveItem(key);
        }

        void ICacheProvider.RemoveAll()
        {
            RemoveAll();
        }

        void ICacheProvider.RemoveItems(string startKey)
        {
            RemoveItems(startKey);
        }

        bool ICacheProvider.ExistsItem(string key)
        {
            return ExistsItem(key);
        }

        #endregion

        #region Abstracts

        //protected abstract void AddItem(string key, object value);

        protected abstract object GetItem(string key);

        protected abstract void RemoveItem(string key);

        protected abstract void RemoveItems(string startKey);

        protected abstract void RemoveAll();

        protected abstract bool ExistsItem(string key);

        #endregion
    }
}