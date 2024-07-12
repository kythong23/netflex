using System;
using System.Collections.Generic;

namespace netflexapi.Models
{
    public partial class User
    {
        public User()
        {
            FavorMovies = new HashSet<FavorMovie>();
            News = new HashSet<News>();
            Subcriptions = new HashSet<Subcription>();
        }

        public int UserId { get; set; }
        public string? Username { get; set; }
        public string? Password { get; set; }
        public string? Email { get; set; }
        public string? Role { get; set; }
        public string? Status { get; set; }

        public virtual ICollection<FavorMovie> FavorMovies { get; set; }
        public virtual ICollection<News> News { get; set; }
        public virtual ICollection<Subcription> Subcriptions { get; set; }
    }
}
