using System;
using System.Collections.Generic;

namespace netlexapiwebadmin.Models
{
    public partial class Country
    {
        public Country()
        {
            Movies = new HashSet<Movie>();
            Subtitles = new HashSet<Subtitle>();
        }

        public int CountryId { get; set; }
        public string? CountryName { get; set; }

        public virtual ICollection<Movie> Movies { get; set; }
        public virtual ICollection<Subtitle> Subtitles { get; set; }
    }
}
