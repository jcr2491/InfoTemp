using Sigcomt.Web.Models;
using Sigcomt.Web.Utilities;
using System.Collections.Generic;
using System.Web;

namespace Sigcomt.Web.Core
{
    public static class WebSession
    {
        public static UsuarioModel Usuario
        {
            get { return HttpContext.Current.Session[ConstantesWeb.UsuarioSesion] as UsuarioModel; }
            set { HttpContext.Current.Session.Add(ConstantesWeb.UsuarioSesion, value); }
        }

        public static IEnumerable<FormularioModel> Formularios
        {
            get { return HttpContext.Current.Session[ConstantesWeb.FormulariosSesion] as IEnumerable<FormularioModel>; }
            set { HttpContext.Current.Session.Add(ConstantesWeb.FormulariosSesion, value); }
        }

        public static FormularioModel FormularioActual
        {
            get { return HttpContext.Current.Session[ConstantesWeb.FormularioActualSesion] as FormularioModel; }
            set { HttpContext.Current.Session.Add(ConstantesWeb.FormularioActualSesion, value); }
        }
    }
}