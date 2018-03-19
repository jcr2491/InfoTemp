using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sigcomt.Business.Entity
{
    public class GrupoSupervisorUAC
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int GrupoId { get; set; }
        public string Grupo { get; set; }
        public int SupervisorId { get; set; }
    }
}
