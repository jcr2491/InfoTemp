using System.Configuration;
using System.DirectoryServices;

namespace Falabella.CrossCutting.ActiveDirectory
{
    public class ActiveDirectory
    {
        public static bool ExistsUserInDirectory(string username, string password)
        {
            var domains = ConfigurationManager.AppSettings["Domains"].Split(',');
            string connectionString = ConfigurationManager.ConnectionStrings["ADWVP"].ConnectionString;
            bool exists = false;

            DirectoryEntry entry = GetDirectoryEntry(connectionString);
            entry.Password = password;

            foreach (string domain in domains)
            {
                entry.Username = $"{username}@{domain}";
                DirectorySearcher search = new DirectorySearcher
                {
                    SearchRoot = entry,
                    Filter = "(&(objectClass=user) (sAMAccountName=" + username + "))",
                    SearchScope = SearchScope.Subtree
                };

                SearchResult result = FindOne(search);

                if (result != null)
                {
                    exists = true;
                    break;
                }
            }
            return exists;
        }

        public static DirectoryEntry GetDirectoryEntry(string connectionString)
        {
            DirectoryEntry dEntry = new DirectoryEntry
            {
                Path = connectionString,
                AuthenticationType = AuthenticationTypes.Secure
            };

            return dEntry;
        }

        public static SearchResult FindOne(DirectorySearcher search)
        {
            SearchResult result;
            try
            {
                result = search.FindOne();
            }
            catch
            {
                result = null;
            }

            return result;
        }
    }
}