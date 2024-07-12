using System;
using System.Collections.Generic;

namespace netlexapiwebadmin.Models
{
    public partial class Movie
    {
        public Movie()
        {
            Actors = new HashSet<Actor>();
            Episodes = new HashSet<Episode>();
            FavorMovies = new HashSet<FavorMovie>();
            News = new HashSet<News>();
            Genres = new HashSet<Genre>();
        }

        public int Id { get; set; }
        public string? Title { get; set; }
        public string? Description { get; set; }
        public string? Img { get; set; }
        public int? Duration { get; set; }
        public DateTime? DateRelease { get; set; }
        public int? Likes { get; set; }
        public int? Episode { get; set; }
        public int? Views { get; set; }
        public int? AgeLimit { get; set; }
        public int? CountryId { get; set; }
        public int? CreatorId { get; set; }
        public int? SubtitleId { get; set; }
        public string? Status { get; set; }
        public string? Trailer { get; set; }

        public virtual Country? Country { get; set; }
        public virtual Creator? Creator { get; set; }
        public virtual Subtitle? Subtitle { get; set; }
        public virtual ICollection<Actor> Actors { get; set; }
        public virtual ICollection<Episode> Episodes { get; set; }
        public virtual ICollection<FavorMovie> FavorMovies { get; set; }
        public virtual ICollection<News> News { get; set; }

        public virtual ICollection<Genre> Genres { get; set; }
    }
}
