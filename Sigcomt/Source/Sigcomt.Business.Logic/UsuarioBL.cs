using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic.Interfaces;
using Sigcomt.Common;
using Sigcomt.DataAccess;
using System;
using System.Collections.Generic;
using Core.Singleton;

namespace Sigcomt.Business.Logic
{
    public class UsuarioBL : Singleton<UsuarioBL>, IUsuarioBL<Usuario, int>
    {
        public int Add(Usuario entity)
        {
            return UsuarioRepository.GetInstance().Add(entity);
        }

        public int Delete(Usuario entity)
        {
            return UsuarioRepository.GetInstance().Delete(entity);
        }

        public bool Exists(Usuario entity)
        {
            return UsuarioRepository.GetInstance().Exists(entity);
        }

        public IList<Usuario> GetAll(string whereFilters)
        {
            throw new NotImplementedException();
        }

        public IList<Usuario> GetAllPaging(PaginationParameter<int> paginationParameters)
        {
            return UsuarioRepository.GetInstance().GetAllPaging(paginationParameters);
        }

        public Usuario GetById(Usuario entity)
        {
            return UsuarioRepository.GetInstance().GetByIdGetById(entity);
        }

        public Usuario GetByUsername(string username)
        {
            return UsuarioRepository.GetInstance().GetByUsername(username);
        }

        public int Update(Usuario entity)
        {
            return UsuarioRepository.GetInstance().Update(entity);
        }
    }
}
