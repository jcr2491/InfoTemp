using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Falabella.CrossCutting.Test
{
    [TestClass]
    public class ActiveDirectoryTest
    {
        [TestMethod]
        public void TestMethod1()
        {
            bool existe = ActiveDirectory.ActiveDirectory.ExistsUserInDirectory("pzapata", "sigcomt20172");

            Assert.IsTrue(existe);
        }
    }
}