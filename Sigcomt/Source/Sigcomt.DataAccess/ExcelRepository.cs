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
    public class ExcelRepository : Singleton<ExcelRepository>, IExcelRepository
    {
        #region Attributos

        private readonly IDbConnection _database = new SqlConnection(ConectionStringRepository.ConnectionStringSql);

        #endregion

        #region Métodos Públicos

        public List<Excel> GetExcel()
        {
            var list = new List<Excel>();

            using (var lector = _database.ExecuteReader($"{ConectionStringRepository.EsquemaName}.GetExcel",
                commandType: CommandType.StoredProcedure))
            {
                while (lector.Read())
                {
                    int id = lector.GetInt32(lector.GetOrdinal("Id"));
                    string tipoArchivo = lector.GetString(lector.GetOrdinal("TipoArchivo"));
                    Excel excel = list.FirstOrDefault(p => p.Id == id);

                    if (excel == null)
                    {
                        excel = new Excel
                        {
                            Id = id,
                            Nombre = lector.GetString(lector.GetOrdinal("NombreExcel")),
                            Ruta = lector.GetString(lector.GetOrdinal("Ruta")),
                            HojasList = new List<ExcelHoja>()
                        };
                        list.Add(excel);
                    }

                    ExcelHoja excelHoja = excel.HojasList.FirstOrDefault(p => p.TipoArchivo == tipoArchivo);

                    if (excelHoja == null)
                    {
                        excelHoja = new ExcelHoja
                        {
                            Id = lector.GetInt32(lector.GetOrdinal("ExcelHojaId")),
                            ExcelId = id,
                            NombreHoja = lector.GetString(lector.GetOrdinal("NombreHoja")),
                            TipoArchivo = tipoArchivo,
                            FilaIni = lector.GetInt32(lector.GetOrdinal("FilaIni")),
                            CampoList = new List<ExcelHojaCampo>()
                        };
                        excel.HojasList.Add(excelHoja);
                    }

                    excelHoja.CampoList.Add(new ExcelHojaCampo
                    {
                        Id = lector.GetInt32(lector.GetOrdinal("ExcelHojaCampoId")),
                        ExcelHojaId = excelHoja.Id,
                        NombreCampo = lector.GetString(lector.GetOrdinal("NombreCampo")),
                        PosicionColumna = lector.GetString(lector.GetOrdinal("PosicionColumna")),
                        TipoDato = lector.GetString(lector.GetOrdinal("TipoDato")),
                        PermiteNulo = lector.GetBoolean(lector.GetOrdinal("PermiteNulo")),
                        ValorDefecto = lector.IsDBNull(lector.GetOrdinal("ValorDefecto"))
                                        ? null
                                        : lector.GetString(lector.GetOrdinal("ValorDefecto")),
                        ValorIgnorar = lector.IsDBNull(lector.GetOrdinal("ValorIgnorar"))
                                        ? null
                                        : lector.GetString(lector.GetOrdinal("ValorIgnorar"))
                    });
                }
            }

            return list;
        }

        #endregion
    }
}