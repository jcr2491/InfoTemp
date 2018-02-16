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
    public class CargoController : BaseController
    {

        [HttpPost]
        public JsonResponse GetAll(PaginationParameter<int> paginationParameters)
        {
            var jsonResponse = new JsonResponse { Success = true };

            try
            {
                var usuarioList = CargoBL.GetInstance().GetAll(paginationParameters);
                var usuarioDTOList = MapperHelper.Map<IEnumerable<Cargo>, IEnumerable<CargoDTO>>(usuarioList);
                jsonResponse.Data = usuarioDTOList;
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