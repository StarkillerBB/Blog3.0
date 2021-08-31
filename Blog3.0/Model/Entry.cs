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
        public Entry() { }
    }
}
