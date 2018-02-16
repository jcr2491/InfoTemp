using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic.Interfaces;
using Sigcomt.Common;
using Sigcomt.DataAccess;
using System.Collections.Generic;
using Core.Singleton;

namespace Sigcomt.Business.Logic
{
    public class CargoBL:Singleton<CargoBL>, ICargoBL<Cargo, int>
    {
        public IList<Cargo> GetAll(PaginationParameter<int> paginationParameter)
        {
            return CargoRepository.GetInstance().GetAll(paginationParameter);
        }
         public IList<Cargo> GetById(int id)
        {
            return CargoRepository.GetInstance().GetById(id);
        }
    }
}
