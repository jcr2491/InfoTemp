﻿namespace Sigcomt.DTO
{
    public class UsuarioLoginDTO
    {
        public int Id { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public int RolId { get; set; }
        public string RolNombre { get; set; }
    }
}
