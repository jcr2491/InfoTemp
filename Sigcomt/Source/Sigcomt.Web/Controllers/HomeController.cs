using Sigcomt.Web.Core;
using System.Web.Mvc;

namespace Sigcomt.Web.Controllers
{
    public class HomeController : BaseController
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}