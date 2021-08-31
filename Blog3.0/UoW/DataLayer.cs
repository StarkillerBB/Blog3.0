using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Blog3._0.Model;

namespace Blog3._0.UoW
{
    class DataLayer
    {

        public List<Entry> entry = new List<Entry>();
        public List<BlogPost> blogPost = new List<BlogPost>();
        public List<Images> images = new List<Images>();
        public List<TagCloud> tagCloud = new List<TagCloud>();

        static readonly string strcon = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
        static readonly SqlConnection con = new SqlConnection(strcon);

        public void CreateBlogPost(BlogPost blog, Images image, TagCloud tags)
        {
            //Insert tags for the blogPost into database
            SqlCommand cmdTags = new SqlCommand("createTags", con);
            SqlDataReader dr;
            //Define that the command is a SP
            cmdTags.CommandType = System.Data.CommandType.StoredProcedure;

            cmdTags.Parameters.Add(ParameterMaker("tags", tags.Tags));

            //Insert entry for the blogPost into database
            SqlCommand cmdEntry = new SqlCommand("createEntries", con);
            //Define that the command is a SP
            cmdEntry.CommandType = System.Data.CommandType.StoredProcedure;

            cmdEntry.Parameters.Add(ParameterMaker("name", blog.Name));
            cmdEntry.Parameters.Add(ParameterMaker("postDate", blog.PostDate));
            cmdEntry.Parameters.Add(ParameterMaker("headline", blog.Headline));
            cmdEntry.Parameters.Add(ParameterMaker("text", blog.Text));
            cmdEntry.Parameters.Add(ParameterMaker("files", blog.Files));
            cmdEntry.Parameters.Add(ParameterMaker("active", blog.Active));
            cmdEntry.Parameters.Add(ParameterMaker("tagsId", blog.TagsId));
            cmdEntry.Parameters.Add(ParameterMaker("imageId", blog.ImageId));

            //Insert the blogPost into the database
            SqlCommand cmdBlogPost = new SqlCommand("createBlogPost", con);

            cmdBlogPost.CommandType = System.Data.CommandType.StoredProcedure;

            cmdBlogPost.Parameters.Add(ParameterMaker("bEntryId", blog.BlogPostId));
            cmdBlogPost.Parameters.Add(ParameterMaker("startDate", blog.StartDate));
            cmdBlogPost.Parameters.Add(ParameterMaker("endDate", blog.EndDate));
            cmdBlogPost.Parameters.Add(ParameterMaker("postType", blog.Type));

            //Insert the images into the database
            SqlCommand cmdImage = new SqlCommand("createImages", con);

            cmdImage.CommandType = System.Data.CommandType.StoredProcedure;

            cmdImage.Parameters.Add(ParameterMaker("name", image.name));
            cmdImage.Parameters.Add(ParameterMaker("description", image.description));
            cmdImage.Parameters.Add(ParameterMaker("path", image.path));


            con.Open();
            try
            {
                dr = cmdTags.ExecuteReader();
                if (dr.HasRows)
                {
                    blog.Id = dr.GetInt32(0);
                    dr.Read();
                    
                }
                dr.Close();


                dr = cmdImage.ExecuteReader();
                if (dr.HasRows)
                {
                    blog.Id = dr.GetInt32(0);
                    dr.Read();
                    
                }
                dr.Close();


                dr = cmdEntry.ExecuteReader();
                if (dr.HasRows)
                {
                    blog.Id = dr.GetInt32(0);
                    dr.Read();
                    
                }
                dr.Close();


                dr = cmdBlogPost.ExecuteReader();
                if (dr.HasRows)
                {
                    blog.Id = dr.GetInt32(0);
                    dr.Read();
                    
                }


                
            }
            //catch (Exception)
            //{

            //    throw;
            //}
            finally
            {
                con.Close();
            }
        }

        public void UpdateBlogPost(BlogPost blog, Images image, TagCloud tags)
        {
            //Insert tags for the blogPost into database
            SqlCommand cmdTags = new SqlCommand("updateTags", con);
            SqlDataReader dr;
            //Define that the command is a SP
            cmdTags.CommandType = System.Data.CommandType.StoredProcedure;

            cmdTags.Parameters.Add(ParameterMaker("id", blog.Id));
            cmdTags.Parameters.Add(ParameterMaker("tags", tags.Tags));

            //Insert entry for the blogPost into database
            SqlCommand cmdEntry = new SqlCommand("updateEntries", con);
            //Define that the command is a SP
            cmdEntry.CommandType = System.Data.CommandType.StoredProcedure;

            cmdEntry.Parameters.Add(ParameterMaker("id", blog.Id));
            cmdEntry.Parameters.Add(ParameterMaker("name", blog.Name));
            cmdEntry.Parameters.Add(ParameterMaker("headline", blog.Headline));
            cmdEntry.Parameters.Add(ParameterMaker("text", blog.Text));
            cmdEntry.Parameters.Add(ParameterMaker("files", blog.Files));
            cmdEntry.Parameters.Add(ParameterMaker("active", blog.Active));

            //Insert the blogPost into the database
            SqlCommand cmdBlogPost = new SqlCommand("updateBlogPost", con);

            cmdBlogPost.CommandType = System.Data.CommandType.StoredProcedure;

            cmdBlogPost.Parameters.Add(ParameterMaker("id", blog.Id));
            cmdBlogPost.Parameters.Add(ParameterMaker("startDate", blog.StartDate));
            cmdBlogPost.Parameters.Add(ParameterMaker("endDate", blog.EndDate));

            //Insert the images into the database
            SqlCommand cmdImage = new SqlCommand("updateImages", con);

            cmdImage.CommandType = System.Data.CommandType.StoredProcedure;

            cmdImage.Parameters.Add(ParameterMaker("id", blog.Id));
            cmdImage.Parameters.Add(ParameterMaker("name", image.name));
            cmdImage.Parameters.Add(ParameterMaker("description", image.description));
            cmdImage.Parameters.Add(ParameterMaker("path", image.path));


            con.Open();
            try
            {
                dr = cmdTags.ExecuteReader();
                dr.Read();
                dr.Close();
                dr = cmdImage.ExecuteReader();
                dr.Read();
                dr.Close();
                dr = cmdEntry.ExecuteReader();
                dr.Read();
                dr.Close();
                dr = cmdBlogPost.ExecuteReader();
                dr.Read();
                dr.Close();




            }
            //catch (Exception)
            //{

            //    throw;
            //}
            finally
            {
                con.Close();
            }
        }

        public List<BlogPost> GetAllBlogPosts()
        {

            SqlCommand cmd = new SqlCommand("getAllBlogPosts", con);
            SqlDataReader dr;
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            TagCloud tagCloud = new TagCloud();
            Images images = new Images();
            List<BlogPost> allPosts = new List<BlogPost>();


            con.Open();
            try
            {
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {

                    while (dr.Read())
                    {
                            
                        BlogPost blog = new BlogPost();
                        
                        blog.Id= dr.GetInt32(0);
                        blog.Name = dr.GetString(1);
                        blog.PostDate = dr.GetDateTime(2);
                        blog.Headline = dr.GetString(3);
                        blog.Text = dr.GetString(4);
                        blog.Files = dr.GetString(5);
                        blog.Active = dr.GetBoolean(6);
                        blog.TagsId = dr.GetInt32(7);
                        blog.StartDate = dr.GetDateTime(11);
                        blog.EndDate = dr.GetDateTime(12);
                        tagCloud.TagCloudId = dr.GetInt32(14);
                        tagCloud.Tags = dr.GetString(15); 
                        images.imageId = dr.GetInt32(16);
                        images.name = dr.GetString(17);
                        images.description = dr.GetString(18);
                        images.path = dr.GetString(19);

                        allPosts.Add(blog);
                    }
                }
            }
            //catch (Exception)
            //{

            //    throw;
            //}
            finally
            {
                con.Close();
            }

            return allPosts;
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
        static private SqlParameter ParameterMaker(string Parametername, int value)
        {
            SqlParameter param = new SqlParameter();
            param.ParameterName = Parametername;
            param.Value = value;
            return param;
        }

    }
}
