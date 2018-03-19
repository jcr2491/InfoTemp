using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Core.Singleton;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Sigcomt.Business.Entity;
using Sigcomt.DataAccess.Core;
using Sigcomt.DataAccess.Interfaces;

namespace Sigcomt.DataAccess
{
    public class CargaArchivoRepository : Singleton<CargaArchivoRepository>, ICargaArchivoRepository
    {
        #region Attributos

        private readonly Database _database = new DatabaseProviderFactory().Create(ConectionStringRepository.ConnectionStringNameSQL);

        #endregion

        #region Métodos Públicos

        public void Add(DataTable dt, string nameTable)
        {
            using (var conexionBulkCopy = new SqlConnection(_database.ConnectionString))
            {
                conexionBulkCopy.Open();
                using (SqlBulkCopy bulkCopy = new SqlBulkCopy(_database.ConnectionString))
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
            using (var comando = _database.GetStoredProcCommand($"{ConectionStringRepository.EsquemaName}.AgregarEmpleadoId"))
            {
                _database.AddInParameter(comando, "@NombreTabla", DbType.String, nombreTabla);
                _database.AddInParameter(comando, "@CampoComparar", DbType.String, campoComparar);
                _database.AddInParameter(comando, "@CampoActualizar", DbType.String, campoActualizar);

                _database.ExecuteNonQuery(comando);
            }
        }

        public void AddGrupoId(string nombreTabla)
        {
            using (var comando = _database.GetStoredProcCommand($"{ConectionStringRepository.EsquemaName}.AgregarGrupoId"))
            {
                _database.AddInParameter(comando, "@NombreTabla", DbType.String, nombreTabla);

                _database.ExecuteNonQuery(comando);
            }
        }

        public void AddSucursalId(string nombreTabla, string campoComparar, string campoActualizar)
        {
            using (var comando = _database.GetStoredProcCommand($"{ConectionStringRepository.EsquemaName}.AgregaSucursalId"))
            {
                _database.AddInParameter(comando, "@NombreTabla", DbType.String, nombreTabla);
                _database.AddInParameter(comando, "@CampoComparar", DbType.String, campoComparar);
                _database.AddInParameter(comando, "@CampoActualizar", DbType.String, campoActualizar);

                _database.ExecuteNonQuery(comando);
            }
        }

        public void AddCCFFSucursal(string nombreTabla, string campoComparar, string campoActualizar)
        {
            using (var comando = _database.GetStoredProcCommand($"{ConectionStringRepository.EsquemaName}.AgregaCCFFSucursal"))
            {
                _database.AddInParameter(comando, "@NombreTabla", DbType.String, nombreTabla);
                _database.AddInParameter(comando, "@CampoComparar", DbType.String, campoComparar);
                _database.AddInParameter(comando, "@CampoActualizar", DbType.String, campoActualizar);

                _database.ExecuteNonQuery(comando);
            }
        }

        public List<DetalleLogCarga> GetLogCarga(DateTime fecha)
        {
            var list = new List<DetalleLogCarga>();

            using (var comando = _database.GetStoredProcCommand($"{ConectionStringRepository.EsquemaName}.GetLogCarga"))
            {
                _database.AddInParameter(comando, "@FechaLog", DbType.DateTime, fecha);

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(new DetalleLogCarga
                        {
                            TipoArchivo = lector.IsDBNull(lector.GetOrdinal("TipoArchivo")) ? default(string) : lector.GetString(lector.GetOrdinal("TipoArchivo")),
                            FechaLog = lector.IsDBNull(lector.GetOrdinal("FechaLog")) ? default(DateTime) : lector.GetDateTime(lector.GetOrdinal("FechaLog")),
                            DetalleLog = lector.IsDBNull(lector.GetOrdinal("DetalleLog")) ? default(string) : lector.GetString(lector.GetOrdinal("DetalleLog")),
                            NumFila = lector.IsDBNull(lector.GetOrdinal("NumFila")) ? default(int) : lector.GetInt32(lector.GetOrdinal("NumFila")),
                            PosicionColumna = lector.IsDBNull(lector.GetOrdinal("PosicionColumna")) ? default(string) : lector.GetString(lector.GetOrdinal("PosicionColumna")),
                            TipoLog = lector.IsDBNull(lector.GetOrdinal("TipoLog")) ? default(string) : lector.GetString(lector.GetOrdinal("TipoLog")),
                            TipoArchivoId = lector.IsDBNull(lector.GetOrdinal("TipoArchivoId")) ? default(string) : lector.GetString(lector.GetOrdinal("TipoArchivoId")),
                            TipoComision = lector.IsDBNull(lector.GetOrdinal("TipoComision")) ? default(string) : lector.GetString(lector.GetOrdinal("TipoComision")),
                            TipoComisionId = lector.IsDBNull(lector.GetOrdinal("TipoComisionId")) ? default(int) : lector.GetInt32(lector.GetOrdinal("TipoComisionId")),
                            Archivo = lector.IsDBNull(lector.GetOrdinal("Archivo")) ? default(string) : lector.GetString(lector.GetOrdinal("Archivo")),
                            NombreCampo = lector.IsDBNull(lector.GetOrdinal("NombreCampo")) ? default(string) : lector.GetString(lector.GetOrdinal("NombreCampo")),
                            NombreArchivo = lector.IsDBNull(lector.GetOrdinal("NombreArchivo")) ? default(string) : lector.GetString(lector.GetOrdinal("NombreArchivo")),
                            NombreHoja = lector.IsDBNull(lector.GetOrdinal("NombreHoja")) ? default(string) : lector.GetString(lector.GetOrdinal("NombreHoja")),
                            NombreResponsable = lector.IsDBNull(lector.GetOrdinal("NombreResponsable")) ? default(string) : lector.GetString(lector.GetOrdinal("NombreResponsable"))
                        });
                    }
                }
            }

            return list;
        }

        public List<TablaColumna> GetColumnasTabla(string tabla)
        {
            var list = new List<TablaColumna>();

            using (var comando = _database.GetStoredProcCommand($"{ConectionStringRepository.EsquemaName}.GetColumnasTabla"))
            {
                _database.AddInParameter(comando, "@Tabla", DbType.String, tabla);
                _database.AddInParameter(comando, "@Esquema", DbType.String, ConectionStringRepository.EsquemaName);

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(new TablaColumna
                        {
                            Columna = lector.GetString(lector.GetOrdinal("Columna")),
                            Tipo = lector.GetString(lector.GetOrdinal("Tipo"))
                        });
                    }
                }
            }

            return list;
        }

        public List<Archivo> GetArchivosEstado(DateTime fecha)
        {
            var list = new List<Archivo>();

            using (var comando = _database.GetStoredProcCommand($"{ConectionStringRepository.EsquemaName}.GetArchivosEstado"))
            {
                _database.AddInParameter(comando, "@FechaLog", DbType.DateTime, fecha);

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(new Archivo
                        {
                            NombreArchivo = lector.IsDBNull(lector.GetOrdinal("Nombre")) ? default(string) : lector.GetString(lector.GetOrdinal("Nombre")),
                            TipoArchivo = lector.IsDBNull(lector.GetOrdinal("TipoArchivo")) ? default(string) : lector.GetString(lector.GetOrdinal("TipoArchivo")),
                            Estado = lector.IsDBNull(lector.GetOrdinal("EstadoCarga")) ? default(int) : lector.GetInt32(lector.GetOrdinal("EstadoCarga")),
                        });
                    }
                }
            }
            return list;
        }

        #endregion
    }
}