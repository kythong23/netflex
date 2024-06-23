using System;
using System.Collections.Generic;

namespace netflexapi.Models
{
    public partial class Actor
    {
        public int ActorId { get; set; }
        public string? ActorName { get; set; }
        public string? Description { get; set; }
        public int? MovieId { get; set; }

        public virtual Movie? Movie { get; set; }
    }
}
