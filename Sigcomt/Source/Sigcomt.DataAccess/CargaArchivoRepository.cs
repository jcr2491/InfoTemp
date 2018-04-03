using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using Core.Singleton;
using Dapper;
using Sigcomt.Business.Entity;
using Sigcomt.DataAccess.Core;
using Sigcomt.DataAccess.Interfaces;

namespace Sigcomt.DataAccess
{
    public class CargaArchivoRepository : Singleton<CargaArchivoRepository>, ICargaArchivoRepository
    {
        #region Attributos

        private readonly IDbConnection _database = new SqlConnection(ConectionStringRepository.ConnectionStringSql);

        #endregion

        #region Métodos Públicos

        public void Add(DataTable dt, string nameTable)
        {
            using (var conexionBulkCopy = new SqlConnection(ConectionStringRepository.ConnectionStringSql))
            {
                conexionBulkCopy.Open();
                using (SqlBulkCopy bulkCopy = new SqlBulkCopy(ConectionStringRepository.ConnectionStringSql))
                {
                    bulkCopy.BulkCopyTimeout = int.MaxValue;
                    bulkCopy.DestinationTableName = $"{ConectionStringRepository.EsquemaName}.{nameTable}";

                    foreach (var column in dt.Columns)
                    {
                        bulkCopy.ColumnMappings.Add(column.ToString(), column.ToString());
                    }

                    bulkCopy.WriteToServer(dt);
                }
            }
        }

        public void AddEmpleadoId(string nombreTabla, string campoComparar, string campoActualizar)
        {
            _database.Query($"{ConectionStringRepository.EsquemaName}.AgregarEmpleadoId",
                new
                {
                    NombreTabla = nombreTabla,
                    CampoComparar = campoComparar,
                    CampoActualizar = campoActualizar
                },
                commandType: CommandType.StoredProcedure);
        }

        public void AddGrupoId(string nombreTabla)
        {
            _database.Query($"{ConectionStringRepository.EsquemaName}.AgregarGrupoId",
                new
                {
                    NombreTabla = nombreTabla
                },
                commandType: CommandType.StoredProcedure);
        }

        public void AddSucursalId(string nombreTabla, string campoComparar, string campoActualizar)
        {
            _database.Query($"{ConectionStringRepository.EsquemaName}.AgregaSucursalId",
                new
                {
                    NombreTabla = nombreTabla,
                    CampoComparar = campoComparar,
                    CampoActualizar = campoActualizar
                },
                commandType: CommandType.StoredProcedure);
        }

        public void AddCCFFSucursal(string nombreTabla, string campoComparar, string campoActualizar)
        {
            _database.Query($"{ConectionStringRepository.EsquemaName}.AgregaCCFFSucursal",
                new
                {
                    NombreTabla = nombreTabla,
                    CampoComparar = campoComparar,
                    CampoActualizar = campoActualizar
                },
                commandType: CommandType.StoredProcedure);
        }

        public List<DetalleLogCarga> GetLogCarga(DateTime fecha)
        {
            var list = _database.Query<DetalleLogCarga>(
                $"{ConectionStringRepository.EsquemaName}.GetLogCarga",
                new {FechaLog = fecha}, commandType: CommandType.StoredProcedure).ToList();

            return list;
        }

        public List<TablaColumna> GetColumnasTabla(string tabla)
        {
            var list = _database.Query<TablaColumna>(
                $"{ConectionStringRepository.EsquemaName}.GetColumnasTabla",
                new
                {
                    Tabla = tabla,
                    Esquema = ConectionStringRepository.EsquemaName
                }, commandType: CommandType.StoredProcedure).ToList();

            return list;
        }

        public List<Archivo> GetArchivosEstado(DateTime fecha)
        {
            var list = new List<Archivo>();
            using (var lector = _database.ExecuteReader($"{ConectionStringRepository.EsquemaName}.GetArchivosEstado",
                new
                {
                    FechaLog = fecha
                }, commandType: CommandType.StoredProcedure))
            {
                while (lector.Read())
                {
                    list.Add(new Archivo
                    {
                        NombreArchivo = lector.IsDBNull(lector.GetOrdinal("Archivo"))
                            ? default(string)
                            : lector.GetString(lector.GetOrdinal("Archivo")),
                        TipoArchivo = lector.IsDBNull(lector.GetOrdinal("TipoArchivo"))
                            ? default(string)
                            : lector.GetString(lector.GetOrdinal("TipoArchivo")),
                        Estado = lector.IsDBNull(lector.GetOrdinal("EstadoCarga"))
                            ? default(int)
                            : lector.GetInt32(lector.GetOrdinal("EstadoCarga")),
                        Input = lector.IsDBNull(lector.GetOrdinal("Input"))
                            ? default(string)
                            : lector.GetString(lector.GetOrdinal("Input"))
                    });
                }
            }
            
            return list;
        }

        public List<TipoComisionArchivo> GetTipoComisionArchivo()
        {
            var list = _database.Query<TipoComisionArchivo>($"{ConectionStringRepository.EsquemaName}.GetTipoComisionArchivo", null,
                commandType: CommandType.StoredProcedure).ToList();

            return list;
        }

        public List<HomologacionEmpleado> GetHomologacionEmpleado(DateTime fecha)
        {
            var list = _database.Query<HomologacionEmpleado>($"{ConectionStringRepository.EsquemaName}.GetHomologacionEmpleado",
                new {FechaArchivo = fecha}, commandType: CommandType.StoredProcedure).ToList();

            return list;
        }

        public List<HomologacionEmpleado> GetGrupo(DateTime fecha)
        {
            var list = _database.Query<HomologacionEmpleado>($"{ConectionStringRepository.EsquemaName}.GetHomologacionEmpleado",
                new { FechaArchivo = fecha }, commandType: CommandType.StoredProcedure).ToList();

            return list;
        }

        public bool AddReporte(string nombreReport, DateTime fecha, int userId)
        {
            bool resp = _database.Query<bool>($"{ConectionStringRepository.EsquemaName}.{nombreReport}",
                new
                {
                    FechaArchivo = fecha,
                    UsuarioId = userId
                }, commandType: CommandType.StoredProcedure).SingleOrDefault();

            return resp;
        }

        #endregion
    }
}