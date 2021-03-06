using Newtonsoft.Json;
using System;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Reflection;
using System.Text.RegularExpressions;

namespace Sigcomt.Common
{
    public static class Utils
    {
        private static readonly CultureInfo CultureInfoEs = CultureInfo.CreateSpecificCulture("es");

        #region M�todos Enums

        public static string GetStringValue(this Enum value)
        {
            return Convert.ToString(Convert.ChangeType(value, value.GetTypeCode()));
        }

        public static int GetNumberValue(this Enum value)
        {
            return Convert.ToInt32(Convert.ChangeType(value, value.GetTypeCode()));
        }

        #endregion

        #region M�todos Fecha

        /// <summary>
        ///  Convierte la cadena yyyy/MM/dd en un datetime
        /// </summary>
        /// <param name="fecha">yyyy/MM/dd</param>
        /// <returns></returns>
        public static object GetDateFormat1(string fecha)
        {
            if (!string.IsNullOrEmpty(fecha))
                return DateTime.ParseExact(fecha, "yyyy/MM/dd", CultureInfo.InvariantCulture);

            return DBNull.Value;
        }

        /// <summary>
        /// Convierte la cadena dd-MMM-yyyy HH:mm:ss en un datetime
        /// </summary>
        /// <param name="fecha">dd-MMM-yyyy HH:mm:ss</param>
        /// <returns></returns>
        public static object GetDateFormat2(string fecha)
        {
            if (!string.IsNullOrEmpty(fecha))
                return DateTime.ParseExact(fecha.Insert(6, "."), "dd-MMM-yyyy HH:mm:ss", CultureInfoEs);

            return DBNull.Value;
        }

        /// <summary>
        /// Convierte la cadena yyyy/MM en un datetime
        /// </summary>
        /// <param name="fecha">yyyy/MM</param>
        /// <returns></returns>
        public static object GetDateFormat3(string fecha)
        {
            if (!string.IsNullOrEmpty(fecha))
                return DateTime.ParseExact(fecha, "yyyyMM", CultureInfo.InvariantCulture);

            return DBNull.Value;
        }

        /// <summary>
        /// Convierte la cadena yyyyMMdd en un datetime
        /// </summary>
        /// <param name="fecha">yyyyMMdd</param>
        /// <returns></returns>
        public static object GetDateFormat4(string fecha)
        {
            if (!string.IsNullOrEmpty(fecha) && fecha.Any(p => p != '0'))
                return DateTime.ParseExact(fecha, "yyyyMMdd", CultureInfo.InvariantCulture);

            return DBNull.Value;
        }

        /// <summary>
        /// Convierte la cadena dd/MM/yyyy en un datetime
        /// </summary>
        /// <param name="fecha">dd/MM/yyyy</param>
        /// <returns></returns>
        public static object GetDateFormat5(string fecha)
        {
            if (!string.IsNullOrEmpty(fecha))
                return DateTime.ParseExact(fecha, "dd/MM/yyyy", CultureInfo.InvariantCulture);

            return DBNull.Value;
        }

        /// <summary>
        /// Convierte la cadena dd/MM/yyyy en un datetime
        /// </summary>
        /// <param name="fecha">dd/MM/yyyy</param>
        /// <returns></returns>
        public static object GetDateFormat6(string fecha)
        {
            if (!string.IsNullOrEmpty(fecha))
            {
                var fechaSplit = fecha.Split('/');

                return new DateTime(int.Parse(fechaSplit[2].Substring(0, 4)), int.Parse(fechaSplit[1]),
                    int.Parse(fechaSplit[0]));
            }

            return DBNull.Value;
        }

        public static object GetHourFormat(string hora)
        {
            hora = hora.Trim();
            if (hora != string.Empty)
            {
                hora = hora.PadLeft(7, '0');
                DateTime dateTime = DateTime.ParseExact(hora, "hh:mmtt", CultureInfo.InvariantCulture);
                return dateTime.TimeOfDay;
            }

            return DBNull.Value;
        }

        public static string GetDateLastDayOfMonth(string fecha)
        {
            DateTime date = Convert.ToDateTime(fecha);
            int dia = DateTime.DaysInMonth(date.Year, date.Month);

            return $"{dia}/{date.Month}/{date.Year}";
        }

        /// <summary>
        /// Obtiene el �ltmo d�a del mes
        /// </summary>
        /// <param name="fecha"></param>
        /// <returns></returns>
        public static DateTime GetDateLastDayOfMonth(this DateTime fecha)
        {
            int dia = DateTime.DaysInMonth(fecha.Year, fecha.Month);

            return new DateTime(fecha.Year, fecha.Month, dia);
        }

        public static DateTime ChangeYear(this DateTime fecha, int year)
        {
            return new DateTime(year, fecha.Month, fecha.Day);
        }

        public static string GetFirstLetterDay(this DateTime fecha)
        {
            string day = fecha.ToString("ddd", CultureInfoEs);
            return day.Substring(0, 1).ToUpper();
        }

        public static string GetFirstLetterMonth(this DateTime fecha)
        {
            string month = fecha.ToString("MMM", CultureInfoEs);
            return month.TrimEnd('.');
        }

        public static string GetNameMonth(this DateTime fecha)
        {
            string month = fecha.ToString("MMMM", CultureInfoEs);
            return month;
        }

        /// <summary>
        /// Obtiene la fecha en cadena
        /// </summary>
        /// <param name="fecha"></param>
        /// <returns>dd/MM/yyyy</returns>
        public static string GetDateToString(this DateTime fecha)
        {
            return fecha.ToString("dd/MM/yyyy");
        }      

        /// <summary>
        /// Obtiene la fecha en cadena
        /// </summary>
        /// <param name="fecha"></param>
        /// <returns>dd/MM/yyyy hh:mm:ss</returns>
        public static string GetDateTimeToString(this DateTime fecha)
        {
            return fecha.ToString("dd/MM/yyyy hh:mm:ss");
        }

        /// <summary>
        /// Resta la fecha y hora especificadas de esta instancia
        /// </summary>
        /// <param name="fechaIni"></param>
        /// <param name="fechaFin"></param>
        /// <returns>hh:mm:ss</returns>
        public static string SubtractDate(this DateTime fechaIni, DateTime? fechaFin)
        {
            if (fechaFin != null)
            {
                var diff = fechaFin.Value.Subtract(fechaIni);
                return diff.ToString().Split('.')[0];
            }

            return string.Empty;
        }

        /// <summary>
        /// Obtiene la fecha con el primer dia del mes.
        /// </summary>
        /// <param name="fecha"></param>
        /// <returns></returns>
        public static string GetDateToStringFirstDay(this DateTime fecha)
        {
            return fecha.ToString("01/MM/yyyy");
        }

        /// <summary>
        /// Obtiene la fecha con el primer dia del mes.
        /// </summary>
        /// <param name="fecha"></param>
        /// <returns></returns>
        public static DateTime GetDateFirstDay(this DateTime fecha)
        {
            return new DateTime(fecha.Year, fecha.Month, 1);
        }

        public static bool EsFecha(string valor)
        {
            // dd/mm/yyyy o dd-mm-yyyy
            string pattern = @"^(?:(?:0?[1-9]|1\d|2[0-8])(\/|-)(?:0?[1-9]|1[0-2]))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(?:(?:31(\/|-)(?:0?[13578]|1[02]))|(?:(?:29|30)(\/|-)(?:0?[1,3-9]|1[0-2])))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(29(\/|-)0?2)(\/|-)(?:(?:0[48]00|[13579][26]00|[2468][048]00)|(?:\d\d)?(?:0[48]|[2468][048]|[13579][26]))$";
            if (Regex.IsMatch(valor, pattern)) return true;

            // mm/dd/yyyy o mm-dd-yyyy
            pattern = @"^(?:(?:(?:0?[13578]|1[02])(\/|-)31)|(?:(?:0?[1,3-9]|1[0-2])(\/|-)(?:29|30)))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(?:(?:0?[1-9]|1[0-2])(\/|-)(?:0?[1-9]|1\d|2[0-8]))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(0?2(\/|-)29)(\/|-)(?:(?:0[48]00|[13579][26]00|[2468][048]00)|(?:\d\d)?(?:0[48]|[2468][048]|[13579][26]))$";
            if (Regex.IsMatch(valor, pattern)) return true;

            return false;
        }

        #endregion

        #region Metodos Cadenas y N�meros

        public static object GetValueColumn(string value)
        {
            if (value == null) return DBNull.Value;

            value = value.Trim();
            if (value != string.Empty) return value;

            return DBNull.Value;
        }

        public static object GetValueColumnUpperCase(string value)
        {
            if (value == null) return DBNull.Value;

            value = value.Trim();
            if (value != string.Empty) return value.ToUpper();

            return DBNull.Value;
        }

        /// <summary>
        /// Permite obtener "value" sin espacios en blanco y si esta vacio devuelve "valueDefecto"
        /// </summary>
        /// <param name="value"></param>
        /// <param name="valueDefecto"></param>
        /// <returns></returns>
        public static string GetValueColumn(string value, string valueDefecto)
        {
            if (value == null) return valueDefecto;

            value = value.Trim();
            return value != string.Empty ? value : valueDefecto;
        }

        public static object GetValueColumn(int? value)
        {
            if (value != null) return value;

            return DBNull.Value;
        }

        public static object GetPorcentaje(string value)
        {
            value = value.Trim();
            if (value != string.Empty)
            {
                if (value.EndsWith("%")) return Convert.ToDecimal(value.TrimEnd('%')) / 100;
                return value;
            }

            return DBNull.Value;
        }

        public static object GetValueReplace(string value, string valueLastFind, string valueReplace)
        {
            value = value.Trim();
            if (value == string.Empty) return DBNull.Value;

            if (!value.EndsWith(valueLastFind, true, null)) return value;
            value = value.Replace(valueLastFind.ToLower(), string.Empty).Replace(valueLastFind.ToUpper(), string.Empty);
            value += valueReplace;

            return value;
        }

        public static object GetValueTrimStart(string value, params char[] trimChars)
        {
            value = value.Trim();
            if (value == string.Empty) return DBNull.Value;

            return value.TrimStart(trimChars);
        }

        /// <summary>
        /// Devuelve una cadena y quita comillas al inicio y fin
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static object GetStringColumn(string value)
        {
            value = value.Trim();
            if (value != string.Empty)
            {
                return value.Trim('\"');
            }

            return DBNull.Value;
        }

        public static bool EsEntero(string valor)
        {
            string pattern = @"^-?[0-9]+$";
            return Regex.IsMatch(valor, pattern);
        }

        public static bool EsDecimal(string valor)
        {
            string pattern = @"^-?[0-9]+([.,][0-9]+)?$";
            return Regex.IsMatch(valor, pattern);
        }

        public static bool EsSoloLetras(string valor)
        {
            string pattern = @"^[a-zA-Z��\s]";
            return Regex.IsMatch(valor, pattern);
        }

        public static bool EsNumeroYLetras(string valor)
        {
            string pattern = @"^[a-zA-Z��\s\W\D 0-9]*$";
            return Regex.IsMatch(valor, pattern);
        }

        public static bool EsDefault(string valor)
        {
            bool result = true;
            if (valor == string.Empty)
                result = false;

            return result;           
        }

        #endregion

        #region M�todos DataTable

        public static System.Data.DataTable CrearCabeceraDataTable<T>()
        {
            Type type = typeof(T);
            var properties = type.GetProperties();

            System.Data.DataTable dataTable = new System.Data.DataTable();
            foreach (PropertyInfo info in properties)
            {
                dataTable.Columns.Add(new DataColumn(info.Name,
                    Nullable.GetUnderlyingType(info.PropertyType) ?? info.PropertyType));
            }

            return dataTable;
        }
        
        public static T ConvertedEntity<T>(this IDataReader dr) where T : new()
        {
            // Create a new type of the entity I want
            Type t = typeof(T);
            T returnObject = new T();
            for (int i = 0; i < dr.FieldCount; i++)
            {
                string colName = dr.GetName(i);

                // Look for the object's property with the columns name, ignore case
                PropertyInfo pInfo = t.GetProperty(colName.ToLower(),
                    BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance);

                // did we find the property ?
                if (pInfo != null)
                {
                    object val = dr[colName];
                    // is this a Nullable<> type
                    bool isNullable = (Nullable.GetUnderlyingType(pInfo.PropertyType) != null);
                    if (isNullable)
                    {
                        val = val is DBNull
                            ? null
                            : Convert.ChangeType(val, Nullable.GetUnderlyingType(pInfo.PropertyType));
                    }
                    else
                    {
                        // Convert the db type into the type of the property in our entity
                        val = Convert.ChangeType(val, pInfo.PropertyType);
                    }
                    // Set the value of the property with the value from the db
                    pInfo.SetValue(returnObject, val, null);
                }
            }

            // return the entity object with values
            return returnObject;
        }

        #endregion

        #region M�todos Generales

        public static Type TipoColumna(string tipo)
        {
            Type type = null;

            switch (tipo)
            {
                case "int":
                case "tinyint":
                    type = typeof(int);
                    break;
                case "datetime":
                case "date":
                case "datetime2":
                    type = typeof(DateTime);
                    break;
                case "varchar":
                case "nvarchar":
                case "char":
                    type = typeof(string);
                    break;
                case "decimal":
                case "numeric":
                    type = typeof(decimal);
                    break;
                case "float":
                    type = typeof(float);
                    break;
                case "bit":
                    type = typeof(bool);
                    break;
            }
            return type;
        }

        /// <summary>
        /// Permite crear una copia del objeto.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="instance"></param>
        /// <returns></returns>
        public static T Clone<T>(this T instance)
        {
            var json = JsonConvert.SerializeObject(instance);
            return JsonConvert.DeserializeObject<T>(json);
        }

        #endregion
    }
}