using Sigcomt.ActiveDirectory.Interfaces;
using Sigcomt.Common;
using System.DirectoryServices;

namespace Sigcomt.ActiveDirectory
{
    public class UsuarioAD : IUsuarioAD
    {
        public bool AutenticarEnDominio(string username, string password)
        {
            try
            {
                DirectoryEntry directoryEntry = new DirectoryEntry();
                SearchResult results = null;
                directoryEntry.Path = ConfigurationAppSettings.ConnectionActiveDirectory();
                directoryEntry.AuthenticationType = AuthenticationTypes.Secure;
                directoryEntry.Password = password;

                var dominiosAD = ConfigurationAppSettings.DominiosAD();

                if (dominiosAD!= null)
                {
                    var dominios = dominiosAD.Split(';');
                    for (int i = 0; i < dominios.Length; i++)
                    {
                        directoryEntry.Username = string.Format("{0}@{1}", username, dominios[i]);
                        DirectorySearcher searchAD = new DirectorySearcher(directoryEntry);
                        searchAD.Filter = "(SAMAccountName=" + username + ")";
                        searchAD.SearchScope = SearchScope.Subtree;

                        try
                        {
                            results = searchAD.FindOne();
                            if (results != null)
                                break;
                        }
                        catch
                        {
                        }
                        directoryEntry.Close();
                    }

                    return (results != null);
                }else
                {
                    return false;
                }
            }
            catch
            {
                return false;
            }
        }
    }
}
