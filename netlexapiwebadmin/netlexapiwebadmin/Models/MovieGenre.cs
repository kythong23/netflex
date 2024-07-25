﻿using System;
using System.Collections.Generic;

namespace netlexapiwebadmin.Models
{
    public partial class MovieGenre
    {
        public int Mgenreid { get; set; }
        public int MovieId { get; set; }
        public int GenreId { get; set; }

        public virtual Genre Genre { get; set; } = null!;
        public virtual Movie Movie { get; set; } = null!;
    }
}