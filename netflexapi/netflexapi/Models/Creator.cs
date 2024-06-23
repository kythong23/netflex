using System;
using System.Collections.Generic;

namespace netflexapi.Models
{
    public partial class Creator
    {
        public Creator()
        {
            Movies = new HashSet<Movie>();
        }

        public int CreatorId { get; set; }
        public string? CreatorName { get; set; }

        public virtual ICollection<Movie> Movies { get; set; }
    }
}
