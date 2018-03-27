using System.ComponentModel.DataAnnotations;

namespace Falabella.Dto
{
    public class LogInDto
    {
        [Display(Name = "Username", ResourceType = typeof(Resources.Usuario))]
        [Required(ErrorMessageResourceName = "UsernameRequerido", ErrorMessageResourceType = typeof(Resources.Usuario))]
        public string UserName { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Clave", ResourceType = typeof(Resources.Usuario))]
        [Required(ErrorMessageResourceName = "ClaveRequerido", ErrorMessageResourceType = typeof(Resources.Usuario))]
        public string Password { get; set; }
    }
}