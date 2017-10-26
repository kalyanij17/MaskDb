using CommandLine;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FTFCU.DbDeploy
{
    class Options
    {
        [Option('c', "connectionstring", Required = false,
    HelpText = "This is the connectiong string to the sql database .")]
        public string ConnectionString { get; set; }
        [Option('t', "targetdatabase", Required = true,
   HelpText = "target database required.")]
        public string TargetDatabase { get; set; }

        [Option('d', " dac directory", Required = true,
   HelpText = "dac directory.")]
        public string DacDictionary { get; set; }

        [Option('p', " dac profile", Required = true,
   HelpText = "dac profile required.")]
        public string DacProfile { get; set; }

        [Option('h', " help", Required = false,
    HelpText = "These are parameters used to build database.  \n" +
            "c connectionstring -  connectionstring to sql database. \n" +
            "t target database - database name that needs to be built \n "+
            "d dac dictionary - dacpac name \n" +
            "p dac profile - profile xml with sql scritps "
            )]
        public string Help { get; set; }

    }
}
