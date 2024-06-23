using System;
using System.Collections.Generic;

namespace netflexapi.Models
{
    public partial class Subtitle
    {
        public Subtitle()
        {
            Movies = new HashSet<Movie>();
        }

        public int SubtitleId { get; set; }
        public string? SubContent { get; set; }
        public int? CountryId { get; set; }

        public virtual Country? Country { get; set; }
        public virtual ICollection<Movie> Movies { get; set; }
    }
}
