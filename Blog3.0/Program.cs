using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Blog3._0
{
    class Program
    {

        static readonly string strcon = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
        static readonly SqlConnection con = new SqlConnection(strcon);

        static void Main(string[] args)
        {

        }
    }
}
