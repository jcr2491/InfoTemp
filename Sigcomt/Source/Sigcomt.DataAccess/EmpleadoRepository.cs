using Microsoft.Practices.EnterpriseLibrary.Data;
using Sigcomt.Business.Entity;
using Sigcomt.DataAccess.Core;
using Sigcomt.DataAccess.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Core.Singleton;
using Sigcomt.Common;

namespace Sigcomt.DataAccess
{
    public class EmpleadoRepository : Singleton<EmpleadoRepository>, IEmpleadoRepository<Empleado, int>
    {
        private readonly Database _database =
            new DatabaseProviderFactory().Create(ConectionStringRepository.ConnectionStringNameSQL);

        public IList<Empleado> GetAll(PaginationParameter<int> paginationParameter)
        {
            List<Empleado> empleado = new List<Empleado>();
            using (var comando =
                _database.GetStoredProcCommand(string.Format("{0}{1}", ConectionStringRepository.EsquemaName,
                    "CargoGetAllFilter")))
            {
                _database.AddInParameter(comando, "@WhereFilters", DbType.String, paginationParameter.WhereFilter);
                using (var lector = _database.ExecuteReader(comando))
                {
                    if (lector != null)
                    {
                        while (lector.Read())
                        {
                            empleado.Add(new Empleado
                            {
                                Id = lector.IsDBNull(lector.GetOrdinal("Id"))
                                    ? default(int)
                                    : lector.GetInt32(lector.GetOrdinal("Id")),
                                Nombres = lector.IsDBNull(lector.GetOrdinal("Nombres"))
                                    ? default(string)
                                    : lector.GetString(lector.GetOrdinal("Nombres")),
                                Apellidos = lector.IsDBNull(lector.GetOrdinal("Apellidos"))
                                    ? default(string)
                                    : lector.GetString(lector.GetOrdinal("Apellidos")),
                                NomCalidar = lector.IsDBNull(lector.GetOrdinal("NomCalidar"))
                                    ? default(string)
                                    : lector.GetString(lector.GetOrdinal("NomCalidar")),
                                NomData = lector.IsDBNull(lector.GetOrdinal("NomData"))
                                    ? default(string)
                                    : lector.GetString(lector.GetOrdinal("NomData")),
                                NomGesco = lector.IsDBNull(lector.GetOrdinal("NomGesco"))
                                    ? default(string)
                                    : lector.GetString(lector.GetOrdinal("NomGesco")),
                                CargoId = lector.IsDBNull(lector.GetOrdinal("CargoId"))
                                    ? default(int)
                                    : lector.GetInt32(lector.GetOrdinal("CargoId")),
                                Cargo = lector.IsDBNull(lector.GetOrdinal("Cargo"))
                                    ? default(string)
                                    : lector.GetString(lector.GetOrdinal("Cargo"))
                            });
                        }
                    }
                }
                return empleado;
            }
        }

        public IList<Empleado> GetById(int Id)
        {
            List<Empleado> empleado = new List<Empleado>();
            using (var comando = _database.GetStoredProcCommand(string.Format("{0}{1}"),
                ConectionStringRepository.EsquemaName, "CargoGetById"))
            {
                _database.AddInParameter(comando, "@Id", DbType.Int32, Id);
                using (var lector = _database.ExecuteReader(comando))
                {
                    if (lector != null)
                    {
                        while (lector.Read())
                        {
                            empleado.Add(new Empleado
                            {
                                Id = lector.IsDBNull(lector.GetOrdinal("Id"))
                                    ? default(Int32)
                                    : lector.GetInt32(lector.GetOrdinal("Id")),
                                Nombres = lector.IsDBNull(lector.GetOrdinal("Nombres"))
                                    ? default(string)
                                    : lector.GetString(lector.GetOrdinal("Nombres")),
                                Apellidos = lector.IsDBNull(lector.GetOrdinal("Apellidos"))
                                    ? default(string)
                                    : lector.GetString(lector.GetOrdinal("Apellidos")),
                                NomCalidar = lector.IsDBNull(lector.GetOrdinal("NomCalidar"))
                                    ? default(string)
                                    : lector.GetString(lector.GetOrdinal("NomCalidar")),
                                NomData = lector.IsDBNull(lector.GetOrdinal("NomData"))
                                    ? default(string)
                                    : lector.GetString(lector.GetOrdinal("NomData")),
                                NomGesco = lector.IsDBNull(lector.GetOrdinal("NomGesco"))
                                    ? default(string)
                                    : lector.GetString(lector.GetOrdinal("NomGesco")),
                                CargoId = lector.IsDBNull(lector.GetOrdinal("CargoId"))
                                    ? default(int)
                                    : lector.GetInt32(lector.GetOrdinal("CargoId")),
                                Cargo = lector.IsDBNull(lector.GetOrdinal("Cargo"))
                                    ? default(string)
                                    : lector.GetString(lector.GetOrdinal("Cargo"))
                            });
                        }
                    }
                }
            }
            return empleado;
        }
    }
}