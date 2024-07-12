using System;
using System.Collections.Generic;

namespace netlexapiwebadmin.Models
{
    public partial class FavorMovie
    {
        public int FavorId { get; set; }
        public int? MovieId { get; set; }
        public int? UserId { get; set; }

        public virtual Movie? Movie { get; set; }
        public virtual User? User { get; set; }
    }
}
