using System;
using System.Net;
using System.Web.Mvc;
using Falabella.Web.Filters;
using log4net;

namespace Falabella.Web.Core
{
    [Authorize]
    [HandleError]
    [WebSessionFilter]
    public abstract class BaseController : Controller
    {
        #region Propiedades

        private static readonly ILog Logger = LogManager.GetLogger(string.Empty);

        #endregion

        #region Overrides

        protected override void OnException(ExceptionContext filterContext)
        {
            Response.StatusCode = (int)HttpStatusCode.InternalServerError;

            var controllerName = filterContext.RouteData.Values["controller"];
            var actionName = filterContext.RouteData.Values["action"];

            Logger.Error(string.Format("Controlador:{0}  Action:{1}  Mensaje:{2}", controllerName, actionName, WebUtils.GetExceptionMessage(filterContext.Exception)));

            filterContext.Result = View("Error");
        }

        protected override void HandleUnknownAction(string actionName)
        {
            RedirectToAction("Index").ExecuteResult(ControllerContext);
        }

        #endregion

        #region Métodos

        protected new ViewResult View(object model)
        {
            var actionName = ControllerContext.Controller.ValueProvider.GetValue("action").RawValue.ToString();

            return View(actionName, model);
        }

        protected void LogError(Exception exception)
        {
            Logger.Error(string.Format("Mensaje: {0} Trace: {1}", exception.Message, exception.StackTrace));
        }

        #endregion
    }
}