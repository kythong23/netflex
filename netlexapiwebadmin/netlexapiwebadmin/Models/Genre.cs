using System;
using System.Collections.Generic;

namespace netlexapiwebadmin.Models
{
    public partial class Genre
    {
        public Genre()
        {
            MovieGenreGenres = new HashSet<MovieGenre>();
        }

        public int GenreId { get; set; }
        public string? GenreName { get; set; }

        public virtual MovieGenre? MovieGenreMgenre { get; set; }
        public virtual ICollection<MovieGenre> MovieGenreGenres { get; set; }
    }
}
