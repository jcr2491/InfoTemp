using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic.Interfaces;
using Sigcomt.DataAccess;
using System.Collections.Generic;
using Core.Singleton;

namespace Sigcomt.Business.Logic
{
    public class RolBL : Singleton<RolBL>, IRolBL<Rol>
    {
        public IList<Rol> GetAllActives()
        {
            return RolRepository.GetInstance().GetAllActives();
        }
    }
}
