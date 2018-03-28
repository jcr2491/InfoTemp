using System.DirectoryServices;

namespace Sigcomt.Common.ActiveDirectory
{
    public class ActiveDirectory
    {
        public static bool ExistsUserInDirectory(string username, string password)
        {
            DirectoryEntry entry = GetDirectoryEntry(ConfigurationAppSettings.ConnectionAd);
            entry.Password = password;
            entry.Username = username;

            DirectorySearcher search = new DirectorySearcher
            {
                SearchRoot = entry,
                Filter = "(&(objectClass=user) (sAMAccountName=" + username.Split('@')[0] + "))",
                SearchScope = SearchScope.Subtree
            };

            SearchResult result = FindOne(search);

            return result != null;
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
