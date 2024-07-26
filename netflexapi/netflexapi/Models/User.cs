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
        }

        public int UserId { get; set; }
        public string? Username { get; set; }
        public string? Password { get; set; }
        public string? Email { get; set; }
        public string? Role { get; set; }
        public string? Status { get; set; }
        public int? SubcriptionId { get; set; }
        public DateTime? ExpiredDate { get; set; }

        public virtual Subcription? Subcription { get; set; }
        public virtual ICollection<FavorMovie> FavorMovies { get; set; }
        public virtual ICollection<News> News { get; set; }
    }
}
