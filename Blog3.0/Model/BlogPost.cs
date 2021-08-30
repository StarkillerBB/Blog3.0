using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Blog3._0.Model;

namespace Blog3._0.Model
{
    class BlogPost : Entry
    {
        static readonly string strcon = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
        static readonly SqlConnection con = new SqlConnection(strcon);

        public int blogId { get; set; }
        public int entryId { get; set; }
        public string text { get; set; }
        public DateTime startDate { get; set; }
        public DateTime endDate { get; set; }
        public string files { get; set; }
        public string type { get; set; }
        public BlogPost() { }

        static void CreateBlogPost(BlogPost blog)
        {

            //Insert entry for the blogPost into database
            SqlCommand cmd = new SqlCommand("createEntries", con);
            SqlDataReader dr;
            //Define that the command is a SP
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.Add(ParameterMaker("name", blog.type));
            cmd.Parameters.Add(ParameterMaker("postDate", blog.postDate));
            cmd.Parameters.Add(ParameterMaker("headline", blog.headline));
            cmd.Parameters.Add(ParameterMaker("active", blog.active));

            //Insert the blogPost into the database
            cmd = new SqlCommand("createBlogPost", con);

            cmd.Parameters.Add(ParameterMaker("text", blog.text));
            cmd.Parameters.Add(ParameterMaker("startDate", blog.startDate));
            cmd.Parameters.Add(ParameterMaker("endDate", blog.endDate));
            cmd.Parameters.Add(ParameterMaker("files", blog.files));
            cmd.Parameters.Add(ParameterMaker("type", blog.type));
            

            con.Open();
            try
            {
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    blog.entriesId = dr.GetInt32(0);
                }
            }
            catch (Exception)
            {

                throw;
            }
            finally
            {
                con.Close();
            }
        }


        //Parameter creator for the SQL.
        static private SqlParameter ParameterMaker(string Parametername, string value)
        {
            SqlParameter param = new SqlParameter();
            param.ParameterName = Parametername;
            param.Value = value;
            return param;
        }
        static private SqlParameter ParameterMaker(string Parametername, DateTime value)
        {
            SqlParameter param = new SqlParameter();
            param.ParameterName = Parametername;
            param.Value = value;
            return param;
        }
        static private SqlParameter ParameterMaker(string Parametername, bool value)
        {
            SqlParameter param = new SqlParameter();
            param.ParameterName = Parametername;
            param.Value = value;
            return param;
        }
    }
}
