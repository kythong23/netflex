using System;
using System.Collections.Generic;

namespace netflexapi.Models
{
    public partial class Subcription
    {
        public int SubId { get; set; }
        public string? SubName { get; set; }
        public float? SubPrice { get; set; }
        public string? Subdesc { get; set; }
        public int? Userid { get; set; }

        public virtual User? User { get; set; }
    }
}
