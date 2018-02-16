using System.Data;

namespace Sigcomt.DataAccess.Interfaces
{
    public interface ICargaArchivoRepository
    {
        void Add(DataTable dt, string nameTable);
        void AddEmpleadoId(string nombreTabla, string campoComparar, string campoActualizar);
        void AddGrupoId(string nombreTabla);
    }
}