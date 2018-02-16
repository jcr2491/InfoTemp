using Microsoft.Practices.EnterpriseLibrary.Data;
using Sigcomt.Business.Entity;
using Sigcomt.DataAccess.Core;
using Sigcomt.DataAccess.Interfaces;
using System;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.OleDb;
using System.Data.SqlClient;
using Core.Singleton;

namespace Sigcomt.DataAccess
{
    public class LoteRepository : Singleton<LoteRepository>, ILoteRepository<Lote, int>
    {
        #region Attributos

        private readonly Database _database = new DatabaseProviderFactory().Create(ConectionStringRepository.ConnectionStringNameSQL);

        #endregion

        #region Métodos Públicos

        public int AddWithMonitoreo(Lote entity, string ruta)
        {
            int response;

            using (DbConnection conexion = _database.CreateConnection())
            {
                conexion.Open();
                using (var transaction = conexion.BeginTransaction(IsolationLevel.Serializable))
                {
                    try
                    {
                        #region Crear Lote

                        int loteId = 0;
                        using (var comando = _database.GetStoredProcCommand(string.Format("{0}{1}", ConectionStringRepository.EsquemaName, "LoteInsert")))
                        {
                            _database.AddInParameter(comando, "@Nombre", DbType.String, entity.Nombre);
                            _database.AddInParameter(comando, "@Tipo", DbType.Int32, entity.Tipo);
                            loteId = Convert.ToInt32(_database.ExecuteScalar(comando, transaction));
                        }

                        #endregion                        

                        #region BulkCopy 

                        DataTable dataTableExcel = GetDataExcel(ruta);

                        using (SqlBulkCopy copy = new SqlBulkCopy((SqlConnection)conexion, SqlBulkCopyOptions.Default, (SqlTransaction)transaction))
                        {
                            copy.DestinationTableName = string.Format("{0}{1}", ConectionStringRepository.EsquemaName, "Canjes");
                            copy.ColumnMappings.Add("REP_FECCANJE", "FechaCanje");
                            copy.ColumnMappings.Add("REP_IDCLIE", "NumeroDocumento");
                            copy.ColumnMappings.Add("REP_LOCAL", "LocalId");
                            copy.ColumnMappings.Add("REP_PUNTDISP", "PuntosDisponibles");
                            copy.ColumnMappings.Add("REP_PUNTOTPR", "PuntosUsados");
                            copy.ColumnMappings.Add("REP_TIPID", "TipoDocumento");
                            copy.ColumnMappings.Add("Cliente", "TipoCliente");
                            copy.BulkCopyTimeout = int.MaxValue;
                            copy.WriteToServer(dataTableExcel);
                        }

                        #endregion

                        #region ActualizarCanje

                        using (var comando = _database.GetStoredProcCommand(string.Format("{0}{1}", ConectionStringRepository.EsquemaName, "CanjesUpdate")))
                        {
                            comando.CommandTimeout = int.MaxValue;
                            _database.AddInParameter(comando, "@LoteId", DbType.Int32, loteId);
                            response = Convert.ToInt32(_database.ExecuteScalar(comando, transaction));
                        }

                        #endregion

                        transaction.Commit();
                    }
                    catch (Exception)
                    {
                        transaction.Rollback();
                        response = 0;
                    }
                }
            }

            return response;
        }        

        public bool Exists(Lote entity)
        {
            bool existe = false;
            using (var comando = _database.GetStoredProcCommand(string.Format("{0}{1}", ConectionStringRepository.EsquemaName, "LoteVerifyExists")))
            {
                _database.AddInParameter(comando, "@Nombre", DbType.String, entity.Nombre);
                _database.AddInParameter(comando, "@Tipo", DbType.Int32, entity.Tipo);

                using (var lector = _database.ExecuteReader(comando))
                {
                    if (lector.Read())
                    {
                        existe = Convert.ToBoolean(lector.GetInt32(0));
                    }
                }
            }

            return existe;
        }

        private DataTable GetDataExcel(string ruta)
        {
            DataTable excelDataTable = new DataTable();
            string excelConexionString = string.Format(ConfigurationManager.AppSettings[ConectionStringRepository.ConexionExcel], ruta);
            using (OleDbConnection excelConexion = new OleDbConnection(excelConexionString))
            {
                excelConexion.Open();
                string hoja = excelConexion.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null).Rows[0]["TABLE_NAME"].ToString();
                excelDataTable.Columns.AddRange(new DataColumn[7]
                {
                    new DataColumn("REP_FECCANJE", typeof(string)),
                    new DataColumn("REP_IDCLIE", typeof(string)),
                    new DataColumn("REP_LOCAL", typeof(string)),
                    new DataColumn("REP_PUNTDISP", typeof(string)),
                    new DataColumn("REP_PUNTOTPR", typeof(string)),
                    new DataColumn("REP_TIPID", typeof(string)),
                    new DataColumn("Cliente", typeof(string))
                });

                using (OleDbDataAdapter excelDataAdapter = new OleDbDataAdapter("SELECT * FROM [" + hoja + "]", excelConexion))
                {
                    excelDataAdapter.Fill(excelDataTable);
                }
            }

            return excelDataTable;
        }

        #endregion
    }
}
