using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using Dapper;
using System.Collections.Generic;
using Anexo17.Clases;
using System;
using Anexo17.Core;

namespace Anexo17.DataAccess
{
    public class AccesoDatos
    {
        #region Attributos
        private static string ConnectionMis => ConfigurationManager.ConnectionStrings["MIS"].ConnectionString;
        private static string ConnectionCnt => ConfigurationManager.ConnectionStrings["CNT"].ConnectionString;
        private readonly IDbConnection _databaseMis = new SqlConnection(ConnectionMis);
        private readonly IDbConnection _databaseCnt = new SqlConnection(ConnectionCnt);

        #endregion

        #region Métodos Públicos

        public decimal GetMontoFsd()
        {
            var monto = _databaseMis.Query<decimal>("Select cConVar From .dbo.systvar Where cNomVar='pnMaxCobFsd'").SingleOrDefault();

            return monto;
        }

        public List<ClienteCuenta> GetClasificaCuentasFSDXRangoFechas(DateTime fechaIni, DateTime fechaFin)
        {
            var list = _databaseMis.Query<ClienteCuenta>("PROC_S_FSDDCTA_ClasificaCuentasFSDXRangoFechas", 
                new {
                    tdFecIni = fechaIni,
                    tdFecFin = fechaFin
                }, commandTimeout: int.MaxValue, commandType: CommandType.StoredProcedure).ToList();

            return list;
        }

        public List<SaldoAcumulado> GetClientes(DateTime fechaIni, DateTime fechaFin)
        {
            var list = _databaseMis.Query<SaldoAcumulado>("PROC_S_DatosClienteCuenta",
                new
                {
                    tdFecIni = fechaIni,
                    tdFecFin = fechaFin
                }, commandTimeout: int.MaxValue, commandType: CommandType.StoredProcedure).ToList();

            return list;
        }

        public TipoCambio GetTipoCambio(DateTime fecha)
        {
            var tipo = _databaseCnt.Query<TipoCambio>("PROC_S_TipoCambio",
                new
                {
                    ttFecSis = fecha,
                    tcTipMon = "2"
                }, commandTimeout: int.MaxValue, commandType: CommandType.StoredProcedure).Single();

            return tipo;
        }

        public List<ClienteSaldo> GetMontoCoberturaFsd(ParametroCobertura parametro)
        {
            var list = _databaseMis.Query<ClienteSaldo>("PROC_S_MontoCoberturaFSD", new
            {
                tnTipCam = parametro.TipoCambio,
                tcTipCta = parametro.TipoCta,
                tdFecIni = parametro.FechaIni,
                tdFecFin = parametro.FechaFin,
                tcCondic = parametro.Condicion,
                tnMonFsd = parametro.MontoFsd
            }, commandTimeout: int.MaxValue, commandType: CommandType.StoredProcedure).ToList();

            return list;
        }

        public void UpdateCuentas(List<ClienteCuenta> cuentaList)
        {
            var dt = Utils.ConvertToDataTable(cuentaList);

            using (SqlConnection _connection = new SqlConnection(ConnectionMis))
            {
                _connection.Open();

                _connection.Execute("CREATE TABLE #TmpCuentas(nidFsd int, cAplFsd char(1))");

                using (SqlBulkCopy bulkCopy = new SqlBulkCopy(_connection))
                {
                    bulkCopy.BulkCopyTimeout = int.MaxValue;
                    bulkCopy.DestinationTableName = "#TmpCuentas";
                    bulkCopy.WriteToServer(dt);
                    bulkCopy.Close();
                }

                _connection.Execute("UPDATE A SET A.cAplFsd = CASE WHEN B.cAplFsd = 'D' THEN 'A' ELSE B.cAplFsd END FROM dbo.FSDDCTA A INNER JOIN dbo.#TmpCuentas B ON A.nidFsd = B.nidFsd; DROP TABLE dbo.#TmpCuentas;",
                    commandTimeout: int.MaxValue);
            }
        }

        #endregion
    }
}