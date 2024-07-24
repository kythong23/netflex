using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace netlexapiwebadmin.Models
{
    public partial class netflexContext : DbContext
    {
        public netflexContext()
        {
        }

        public netflexContext(DbContextOptions<netflexContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Actor> Actors { get; set; } = null!;
        public virtual DbSet<Country> Countries { get; set; } = null!;
        public virtual DbSet<Creator> Creators { get; set; } = null!;
        public virtual DbSet<Episode> Episodes { get; set; } = null!;
        public virtual DbSet<FavorMovie> FavorMovies { get; set; } = null!;
        public virtual DbSet<Genre> Genres { get; set; } = null!;
        public virtual DbSet<Movie> Movies { get; set; } = null!;
        public virtual DbSet<MovieGenre> MovieGenres { get; set; } = null!;
        public virtual DbSet<News> News { get; set; } = null!;
        public virtual DbSet<Subcription> Subcriptions { get; set; } = null!;
        public virtual DbSet<Subtitle> Subtitles { get; set; } = null!;
        public virtual DbSet<TvShow> TvShows { get; set; } = null!;
        public virtual DbSet<User> Users { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Server=THOONGKYF;Database=netflex;Trusted_Connection=True;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Actor>(entity =>
            {
                entity.ToTable("Actor");

                entity.Property(e => e.ActorId)
                    .ValueGeneratedNever()
                    .HasColumnName("actor_id");

                entity.Property(e => e.ActorName)
                    .HasMaxLength(50)
                    .HasColumnName("actor_name");

                entity.Property(e => e.Description)
                    .HasMaxLength(50)
                    .HasColumnName("description");

                entity.Property(e => e.MovieId).HasColumnName("movie_id");

                entity.HasOne(d => d.Movie)
                    .WithMany(p => p.Actors)
                    .HasForeignKey(d => d.MovieId)
                    .HasConstraintName("FK__Actor__movie_id__5CD6CB2B");
            });

            modelBuilder.Entity<Country>(entity =>
            {
                entity.ToTable("Country");

                entity.Property(e => e.CountryId)
                    .ValueGeneratedNever()
                    .HasColumnName("country_id");

                entity.Property(e => e.CountryName)
                    .HasMaxLength(50)
                    .HasColumnName("country_name");
            });

            modelBuilder.Entity<Creator>(entity =>
            {
                entity.ToTable("Creator");

                entity.Property(e => e.CreatorId)
                    .ValueGeneratedNever()
                    .HasColumnName("creator_id");

                entity.Property(e => e.CreatorName)
                    .HasMaxLength(50)
                    .HasColumnName("creator_name");
            });

            modelBuilder.Entity<Episode>(entity =>
            {
                entity.ToTable("Episode");

                entity.Property(e => e.EpisodeId).HasColumnName("episode_id");

                entity.Property(e => e.Link)
                    .HasMaxLength(200)
                    .HasColumnName("link");

                entity.Property(e => e.MovieId).HasColumnName("movie_id");

                entity.Property(e => e.Name)
                    .HasMaxLength(50)
                    .HasColumnName("name");

                entity.HasOne(d => d.Movie)
                    .WithMany(p => p.Episodes)
                    .HasForeignKey(d => d.MovieId)
                    .HasConstraintName("FK__Episode__movie_i__7B5B524B");
            });

            modelBuilder.Entity<FavorMovie>(entity =>
            {
                entity.HasKey(e => e.FavorId);

                entity.ToTable("FavorMovie");

                entity.Property(e => e.FavorId).HasColumnName("FavorID");

                entity.Property(e => e.MovieId).HasColumnName("MovieID");

                entity.HasOne(d => d.Movie)
                    .WithMany(p => p.FavorMovies)
                    .HasForeignKey(d => d.MovieId)
                    .HasConstraintName("FK__FavorMovi__Movie__17F790F9");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.FavorMovies)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("FK__FavorMovi__UserI__18EBB532");
            });

            modelBuilder.Entity<Genre>(entity =>
            {
                entity.ToTable("Genre");

                entity.Property(e => e.GenreId)
                    .ValueGeneratedNever()
                    .HasColumnName("genre_id");

                entity.Property(e => e.GenreName)
                    .HasMaxLength(50)
                    .HasColumnName("genre_name");
            });

            modelBuilder.Entity<Movie>(entity =>
            {
                entity.ToTable("Movie");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.AgeLimit).HasColumnName("age_limit");

                entity.Property(e => e.CountryId).HasColumnName("country_id");

                entity.Property(e => e.CreatorId).HasColumnName("creator_id");

                entity.Property(e => e.DateRelease)
                    .HasColumnType("date")
                    .HasColumnName("date_release");

                entity.Property(e => e.Description).HasColumnName("description");

                entity.Property(e => e.Duration).HasColumnName("duration");

                entity.Property(e => e.Episode).HasColumnName("episode");

                entity.Property(e => e.Img)
                    .HasMaxLength(200)
                    .HasColumnName("img");

                entity.Property(e => e.Likes).HasColumnName("likes");

                entity.Property(e => e.Status)
                    .HasMaxLength(50)
                    .HasColumnName("status");

                entity.Property(e => e.SubtitleId).HasColumnName("subtitle_id");

                entity.Property(e => e.Title)
                    .HasMaxLength(50)
                    .HasColumnName("title");

                entity.Property(e => e.Trailer).HasColumnName("trailer");

                entity.Property(e => e.Views).HasColumnName("views");

                entity.HasOne(d => d.Country)
                    .WithMany(p => p.Movies)
                    .HasForeignKey(d => d.CountryId)
                    .HasConstraintName("FK__Movie__country_i__52593CB8");

                entity.HasOne(d => d.Creator)
                    .WithMany(p => p.Movies)
                    .HasForeignKey(d => d.CreatorId)
                    .HasConstraintName("FK__Movie__creator_i__534D60F1");

                entity.HasOne(d => d.Subtitle)
                    .WithMany(p => p.Movies)
                    .HasForeignKey(d => d.SubtitleId)
                    .HasConstraintName("FK__Movie__subtitle___68487DD7");
            });

            modelBuilder.Entity<MovieGenre>(entity =>
            {
                entity.HasKey(e => e.Mgenreid);

                entity.ToTable("MovieGenre");

                entity.Property(e => e.Mgenreid)
                    .ValueGeneratedNever()
                    .HasColumnName("mgenreid");

                entity.Property(e => e.GenreId).HasColumnName("genre_id");

                entity.Property(e => e.MovieId).HasColumnName("movie_id");

                entity.HasOne(d => d.Genre)
                    .WithMany(p => p.MovieGenres)
                    .HasForeignKey(d => d.GenreId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__MovieGenr__genre__2BFE89A6");

                entity.HasOne(d => d.Movie)
                    .WithMany(p => p.MovieGenres)
                    .HasForeignKey(d => d.MovieId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__MovieGenr__movie__2B0A656D");
            });

            modelBuilder.Entity<News>(entity =>
            {
                entity.Property(e => e.NewsId)
                    .ValueGeneratedNever()
                    .HasColumnName("news_id");

                entity.Property(e => e.Movieid).HasColumnName("movieid");

                entity.Property(e => e.NewsContent)
                    .HasMaxLength(50)
                    .HasColumnName("news_content");

                entity.Property(e => e.NewsDateRelease)
                    .HasMaxLength(50)
                    .HasColumnName("news_date_release");

                entity.Property(e => e.Userid).HasColumnName("userid");

                entity.HasOne(d => d.Movie)
                    .WithMany(p => p.News)
                    .HasForeignKey(d => d.Movieid)
                    .HasConstraintName("FK__News__movieid__1AD3FDA4");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.News)
                    .HasForeignKey(d => d.Userid)
                    .HasConstraintName("FK__News__userid__1BC821DD");
            });

            modelBuilder.Entity<Subcription>(entity =>
            {
                entity.HasKey(e => e.SubId);

                entity.ToTable("Subcription");

                entity.Property(e => e.SubId)
                    .ValueGeneratedNever()
                    .HasColumnName("SubID");

                entity.Property(e => e.SubName).HasMaxLength(100);

                entity.Property(e => e.Userid).HasColumnName("userid");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Subcriptions)
                    .HasForeignKey(d => d.Userid)
                    .HasConstraintName("FK__Subcripti__useri__19DFD96B");
            });

            modelBuilder.Entity<Subtitle>(entity =>
            {
                entity.ToTable("Subtitle");

                entity.Property(e => e.SubtitleId)
                    .ValueGeneratedNever()
                    .HasColumnName("subtitle_id");

                entity.Property(e => e.CountryId).HasColumnName("country_id");

                entity.Property(e => e.SubContent)
                    .HasMaxLength(50)
                    .HasColumnName("sub_content");

                entity.HasOne(d => d.Country)
                    .WithMany(p => p.Subtitles)
                    .HasForeignKey(d => d.CountryId)
                    .HasConstraintName("FK__Subtitle__countr__5812160E");
            });

            modelBuilder.Entity<TvShow>(entity =>
            {
                entity.HasKey(e => e.TvId);

                entity.ToTable("Tv_show");

                entity.Property(e => e.TvId)
                    .ValueGeneratedNever()
                    .HasColumnName("tv_id");

                entity.Property(e => e.TvLink)
                    .HasMaxLength(50)
                    .HasColumnName("tv_link");

                entity.Property(e => e.TvName)
                    .HasMaxLength(50)
                    .HasColumnName("tv_name");
            });

            modelBuilder.Entity<User>(entity =>
            {
                entity.Property(e => e.UserId)
                    .ValueGeneratedNever()
                    .HasColumnName("user_id");

                entity.Property(e => e.Email)
                    .HasMaxLength(50)
                    .HasColumnName("email");

                entity.Property(e => e.Password)
                    .HasMaxLength(50)
                    .HasColumnName("password");

                entity.Property(e => e.Role)
                    .HasMaxLength(50)
                    .HasColumnName("role");

                entity.Property(e => e.Status)
                    .HasMaxLength(50)
                    .HasColumnName("status");

                entity.Property(e => e.Username)
                    .HasMaxLength(50)
                    .HasColumnName("username");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
