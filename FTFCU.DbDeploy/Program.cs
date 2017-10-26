using Microsoft.SqlServer.Dac;
using System;
using System.Configuration;
using System.IO;

namespace FTFCU.DbDeploy
{
    static class Program
    {
        static void Main(string[] args)
        {
            var Options = new Options();
            string vDacDictionary = null;
            string vDacProfile = null;
            string vtargetDatabase = null;
            string connectionString = null;
            bool isValid = false;
            
                try
                {
                    isValid = CommandLine.Parser.Default.ParseArguments(args, Options);
                }
                catch (Exception e)
                {
                    Console.WriteLine("there is an error in command line arguments , try reading it from configuration " + e.Message);
                   
                }

           

            if (isValid)
            {
                vDacDictionary = Options.DacDictionary;
                vDacProfile = Options.DacProfile;
                vtargetDatabase = Options.TargetDatabase;
                connectionString = ConnectionStringResolver(Options, connectionString);
            }
            else
            {

                vDacDictionary = ConfigurationManager.AppSettings.Get("dac directory");
                vDacProfile = ConfigurationManager.AppSettings.Get("dac profile");
                vtargetDatabase = ConfigurationManager.AppSettings.Get("targetdatabase");
                connectionString = ConfigurationManager.ConnectionStrings["Mask"].ConnectionString;
            }
            string path = Directory.GetCurrentDirectory();
           // connectionString = ConnectionStringResolver(Options, connectionString);

            try
            {
                var dp = DacPackage.Load(path + $@"\" + vDacDictionary);
                var dacService = new DacServices(connectionString);
                var dacProfile = DacProfile.Load(path + $@"\" + vDacProfile);
                dacService.Message += (object sender, Microsoft.SqlServer.Dac.DacMessageEventArgs eventArgs) => Console.WriteLine(eventArgs.Message.Message);

                dacService.Deploy(dp, vtargetDatabase, true, dacProfile.DeployOptions);

                Console.WriteLine("Deployment completed successfully !!!!");
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error in the deployment. please correct the input " + ex.Message);
            }
            Console.ReadLine();

        }

        

        private static string ConnectionStringResolver(Options Options, string connectionString)
        {
            if (string.IsNullOrWhiteSpace(Options.ConnectionString))
            {
                connectionString = ConfigurationManager.ConnectionStrings["Mask"].ConnectionString;
            }else
            {
                connectionString = Options.ConnectionString;
            }

            return connectionString;
        }
    }
}
