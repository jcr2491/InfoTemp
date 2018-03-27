using System;
using System.Net;
using System.Web;

namespace Falabella.Web.Core
{
    public class WebUtils
    {
        #region Manejo de URLs

        private static string _relativeWebRoot;

        /// <summary>
        ///     Retorna la ruta relativa al sitio
        /// </summary>
        public static string RelativeWebRoot => _relativeWebRoot ?? (_relativeWebRoot = VirtualPathUtility.ToAbsolute("~/"));

        /// <summary>
        ///     Retorna la ruta absoluta al sitio
        /// </summary>
        public static Uri AbsoluteWebRoot
        {
            get
            {
                HttpContext context = HttpContext.Current;
                if (context == null)
                    throw new WebException("El actual HttpContext es nulo");

                if (context.Items["absoluteurl"] == null)
                    context.Items["absoluteurl"] = new Uri(context.Request.Url.GetLeftPart(UriPartial.Authority) + RelativeWebRoot);

                return context.Items["absoluteurl"] as Uri;
            }
        }

        #endregion

        #region Manejo de Excepciones

        public static string GetExceptionMessage(Exception ex)
        {
            if (ex.InnerException == null)
                return ex.Message;
            string errorMessage = string.Format("{0}<br/>{1}", ex.Message, GetExceptionMessage(ex.InnerException));

            return errorMessage;
        }

        #endregion

        #region Debuging

        public static bool IsDebug()
        {
            #if DEBUG
                return true;
            #else
                return false;
            #endif
        }

        #endregion
    }
}