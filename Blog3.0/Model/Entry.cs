using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Blog3._0.Model
{
    abstract public class Entry
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public DateTime PostDate { get; set; }
        public string Headline { get; set; }
        public bool Active { get; set; }
        public int TagsId { get; set; }
        public int ImageId { get; set; }
        public int ReferenceId { get; set; }
        public int FrameworkReviewId { get; set; }
        public int BlogPostId { get; set; }
        public Entry() { }
    }
}
