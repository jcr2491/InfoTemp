using System.Web.Mvc;

namespace Sigcomt.Web.Controllers
{
    public class ErrorController : Controller
    {
        public ActionResult Index()
        {
            return View("Error");
        }

        public ActionResult NotFound()
        {
            return View();
        }

        public ActionResult ServerError()
        {
            return View();
        }

        public ActionResult OperationError(string id)
        {
            ViewBag.ErrorMessage = id;
            return View("Error");
        }
    }
}