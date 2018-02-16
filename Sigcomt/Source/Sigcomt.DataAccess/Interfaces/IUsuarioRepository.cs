﻿using Sigcomt.DataAccess.Core;

namespace Sigcomt.DataAccess.Interfaces
{
    public interface IUsuarioRepository<T, Q> : IRepository<T, Q> 
        where T : class
    {
        bool Exists(T entity);
        T GetByUsername(string username);
    }
}
