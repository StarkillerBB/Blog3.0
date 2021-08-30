using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Blog3._0.Model
{
    class Entry
    {
        public int entriesId { get; set; }
        public string name { get; set; }
        public DateTime postDate { get; set; }
        public string headline { get; set; }
        public bool active { get; set; }

    }
}
