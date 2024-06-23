﻿using System;
using System.Collections.Generic;

namespace netflexapi.Models
{
    public partial class Genre
    {
        public Genre()
        {
            Movies = new HashSet<Movie>();
        }

        public int GenreId { get; set; }
        public string? GenreName { get; set; }

        public virtual ICollection<Movie> Movies { get; set; }
    }
}
