using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic;
using Sigcomt.Common;
using Sigcomt.DTO;
using Sigcomt.DTO.AutoMapper;
using Sigcomt.WebApi.Core;
using System;
using System.Collections.Generic;
using System.Web.Http;

namespace Sigcomt.WebApi.Controllers
{
    public class RolController : BaseController
    {
        [HttpPost]
        public JsonResponse GetAllActives()
        {
            var jsonResponse = new JsonResponse { Success = true };

            try
            {
                var rolList = RolBL.GetInstance().GetAllActives();
                var rolDTOList = MapperHelper.Map<IEnumerable<Rol>, IEnumerable<RolDTO>>(rolList);
                jsonResponse.Data = rolDTOList;
            }
            catch (Exception ex)
            {
                LogError(ex);
                jsonResponse.Success = false;
                jsonResponse.Message = Mensajes.IntenteloMasTarde;
            }

            return jsonResponse;
        }
    }
}