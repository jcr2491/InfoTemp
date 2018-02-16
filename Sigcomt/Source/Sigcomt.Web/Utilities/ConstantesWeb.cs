using System.Configuration;

namespace Sigcomt.Web.Utilities
{
    public class ConstantesWeb
    {
        #region WebServices

        public static string BaseUrlApiService = ConfigurationManager.AppSettings["BaseUrlApiService"];
        public static string WS_Account_Login = ConfigurationManager.AppSettings["WS_Account_Login"];
        public static string WS_Usuario_GetAllPaging = ConfigurationManager.AppSettings["WS_Usuario_GetAllPaging"];

        public static string WS_TipoProducto_GetAllPaging = ConfigurationManager.AppSettings["WS_TipoProducto_GetAllPaging"];
        public static string WS_TipoProducto_GetById = ConfigurationManager.AppSettings["WS_TipoProducto_GetById"];
        public static string WS_TipoProducto_GetAll = ConfigurationManager.AppSettings["WS_TipoProducto_GetAll"];
        public static string WS_TipoProducto_Add = ConfigurationManager.AppSettings["WS_TipoProducto_Add"];
        public static string WS_TipoProducto_Update = ConfigurationManager.AppSettings["WS_TipoProducto_Update"];
        public static string WS_TipoProducto_Delete = ConfigurationManager.AppSettings["WS_TipoProducto_Delete"];

        public static string WS_Vale_GetAllPaging = ConfigurationManager.AppSettings["WS_Vale_GetAllPaging"];
        public static string WS_Vale_GetById = ConfigurationManager.AppSettings["WS_Vale_GetById"];
        public static string WS_Vale_GetAll = ConfigurationManager.AppSettings["WS_Vale_GetAll"];
        public static string WS_Vale_Add = ConfigurationManager.AppSettings["WS_Vale_Add"];
        public static string WS_Vale_Update = ConfigurationManager.AppSettings["WS_Vale_Update"];
        public static string WS_Vale_Delete = ConfigurationManager.AppSettings["WS_Vale_Delete"];

        public static string WS_Alerta_Update = ConfigurationManager.AppSettings["WS_Alerta_Update"];
        public static string WS_Alerta_GetCount = ConfigurationManager.AppSettings["WS_Alerta_GetCount"];
        public static string WS_Alerta_SendEmail = ConfigurationManager.AppSettings["WS_Alerta_SendEmail"];

        public static string WS_Carga_GetAllPaging = ConfigurationManager.AppSettings["WS_Carga_GetAllPaging"];
        public static string WS_Carga_GetById = ConfigurationManager.AppSettings["WS_Carga_GetById"];
        public static string WS_Carga_GetAll = ConfigurationManager.AppSettings["WS_Carga_GetAll"];
        public static string WS_Carga_Add = ConfigurationManager.AppSettings["WS_Carga_Add"];
        public static string WS_Carga_Update = ConfigurationManager.AppSettings["WS_Carga_Update"];
        public static string WS_Carga_Delete = ConfigurationManager.AppSettings["WS_Carga_Delete"];

        public static string WS_Canje_Add = ConfigurationManager.AppSettings["WS_Canje_Add"];

        public static string WS_Envio_GetAllPaging = ConfigurationManager.AppSettings["WS_Envio_GetAllPaging"];
        public static string WS_Envio_GetById = ConfigurationManager.AppSettings["WS_Envio_GetById"];
        public static string WS_Envio_GetAllPagingLog = ConfigurationManager.AppSettings["WS_Envio_GetAllPagingLog"];
        public static string WS_Envio_GetByIdLog = ConfigurationManager.AppSettings["WS_Envio_GetByIdLog"];
        public static string WS_Envio_GetAllExport = ConfigurationManager.AppSettings["WS_Envio_GetAllExport"];
    

        #endregion

        #region KeyString

        public const string UsuarioSesion = "UsuarioSesion";
        public const string NoUsuario = "NoUsuario";
        public const string FormulariosSesion = "FormulariosSesion";
        public const string FormularioActualSesion = "FormularioActualSesion";
        public const string TimeOutSession = "TimeOutSession";
        public const string EmailPattern = "EmailPattern";

        public const string LoginController = "Account";
        public const string LoginAction = "Login";        

        public const string HomeController = "Home";
        public const string HomeAction = "Index";

        public const string ErrorController = "Error";
        public const string NotFoundAction = "NotFound";
        public const string ServerErrorAction = "ServerError";

        public const string FormatoFechaPorDefecto = "dd/MM/yyyy";
        public const string FormatoFechaHoraPorDefecto = "dd/MM/yyyy hh:mm";
        public const string FormatoHoraPorDefecto = "HH:mm:ss";
        public const string FormatoMonedaPorDefecto = "N2";
        public const string FormatoDecimalesPorDefecto = "{0:N2}";

        public const int Unauthorized = 1;

        public const int Error2146233087 = -2146233087;

        #endregion

        #region MethodType

        public const string METHODPOST = "POST";
        public const string METHODGET = "GET";

        #endregion

        #region Mensajes

        public static string IntenteloMasTarde = "Hubo un error, inténtelo más tarde";
        public static string CredencialesDominioIncorrectas = "Las credenciales de dominio son incorrectas";
        public static string SeTerminoLaSession = "Se terminó la sesión";
        public static string SesionTerminada = "Sesión Terminada";

        #endregion

        #region Roles

        public const int RolAdministrador = 1;
        public const int RolOperador = 3;
        #endregion
    }
}