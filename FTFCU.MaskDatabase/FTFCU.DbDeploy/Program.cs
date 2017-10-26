using Microsoft.SqlServer.Dac;
using System.Configuration;
using System.IO;

namespace FTFCU.DbDeploy
{
    static class Program
    {
        static void Main(string[] args)
        {

            string path = Directory.GetCurrentDirectory() ;
            var dacPackDirectory = path+ $@"\FTFCU.MaskDatabase.dacpac";
            var dacPackProfile = path + $@"\FTFCU.MaskDatabase.publish.xml";
            var targetDatabase =  "Mask";
            var connectionString = ConfigurationManager.ConnectionStrings["Mask"].ConnectionString;


            var dacService = new DacServices(connectionString);
            var dp = DacPackage.Load(dacPackDirectory);
            var dacProfile = DacProfile.Load(dacPackProfile);
            dacService.Deploy(dp, targetDatabase, true, dacProfile.DeployOptions);
        }
    }
}
