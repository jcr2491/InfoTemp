using System;
using System.Globalization;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Falabella.CrossCutting.Test
{
    [TestClass]
    public class UtilsTest
    {
        [TestMethod]
        public void TestMethod1()
        {
            var cultura = CultureInfo.CreateSpecificCulture("es");
            var month = new DateTime(2016, 4, 2).ToString("MMM", cultura);
            string dateString = "05-abr-2016 00:00:00".Insert(6, ".");
            var date = DateTime.ParseExact(dateString, "dd-MMM-yyyy hh:mm:ss", cultura);
            int month2 = date.Month;
        }

        [TestMethod]
        public void TestMethod2()
        {
            DateTime date1 = new DateTime(2017, 2, 1);
            DateTime date2 = new DateTime(2017, 2, 5);

            int days = date2.Subtract(date1).Days;
        }

        [TestMethod]
        public void TestMethod3()
        {
            var cultura = CultureInfo.CreateSpecificCulture("es");
            var day = DateTime.Today.ToString("ddd", cultura);
            string dia = day.Substring(0, 1).ToUpper();
        }

        [TestMethod]
        public void TestMethod4()
        {
            DateTime dateTime = DateTime.ParseExact("07:30PM", "hh:mmtt", CultureInfo.InvariantCulture);
            TimeSpan span = dateTime.TimeOfDay;
            int hora = span.Hours;
        }
    }
}