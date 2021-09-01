using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Blog3._0.Model;
using Blog3._0.UoW;

namespace Blog3._0
{
    class Program
    {
        static void Main(string[] args)
        {
            DataLayer dataLayer = new DataLayer(); 

            BlogPost blogPost = new BlogPost() { Name = "TestBlogName1234", PostDate = DateTime.Now, Headline = "testHeadline", Text = "Yolo testing the yolo", Files = "filePath", Active = true, TagsId = 1, ImageId = 1, BlogPostId = 5, StartDate = DateTime.Now, EndDate = DateTime.Now, Type = "blogPost"};
            Images image = new Images() { name = "TestImageName", description = "Random image description", path = "ImagePath" };
            TagCloud tagCloud = new TagCloud() {  Tags = "Help" };

            BlogPost blogPostUpdate = new BlogPost() { Id = 1, Name = "UpdatedBlogName", PostDate = DateTime.Now, Headline = "testHeadline", Text = "Yolo testing the yolo", Files = "filePath", Active = true, TagsId = 1, ImageId = 1, BlogPostId = 1, StartDate = DateTime.Now, EndDate = DateTime.Now};
            Images imageUpdate = new Images() { name = "UpdatedTestImageName", description = "Random image description", path = "ImagePath" };
            TagCloud tagCloudUpdate = new TagCloud() { Tags = "UpdatedHelp" };


            Task.Run(() => dataLayer.CreateBlogPost(blogPost, image, tagCloud));
            dataLayer.UpdateBlogPost(blogPostUpdate, imageUpdate, tagCloudUpdate);
            dataLayer.GetAllBlogPosts();
        }

        
    }
}
