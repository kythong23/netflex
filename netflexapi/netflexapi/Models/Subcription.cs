using System;
using System.Collections.Generic;

namespace netflexapi.Models
{
    public partial class Subcription
    {
        public Subcription()
        {
            Users = new HashSet<User>();
        }

        public int SubId { get; set; }
        public string? SubName { get; set; }
        public float? SubPrice { get; set; }
        public string? Subdesc { get; set; }

        public virtual ICollection<User> Users { get; set; }
    }
}
