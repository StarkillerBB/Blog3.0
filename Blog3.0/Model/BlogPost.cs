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
        

        public int Id { get; set; }
        public string Text { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public string Files { get; set; }
        public string Type { get; set; }
        public List<Images> Image { get; set; }
        public List<TagCloud> Tags { get; set; }
        public BlogPost() { }


    }
}
