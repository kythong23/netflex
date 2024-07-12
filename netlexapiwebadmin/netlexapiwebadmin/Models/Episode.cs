using System;
using System.Collections.Generic;

namespace netlexapiwebadmin.Models
{
    public partial class Episode
    {
        public int EpisodeId { get; set; }
        public string? Name { get; set; }
        public string? Link { get; set; }
        public int? MovieId { get; set; }

        public virtual Movie? Movie { get; set; }
    }
}
