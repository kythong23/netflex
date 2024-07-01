﻿using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace netflexapi.Models
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
        public virtual DbSet<Genre> Genres { get; set; } = null!;
        public virtual DbSet<Movie> Movies { get; set; } = null!;
        public virtual DbSet<News> News { get; set; } = null!;
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

                entity.Property(e => e.EpisodeId)
                    .ValueGeneratedNever()
                    .HasColumnName("episode_id");

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

            modelBuilder.Entity<Genre>(entity =>
            {
                entity.ToTable("Genre");

                entity.Property(e => e.GenreId)
                    .ValueGeneratedNever()
                    .HasColumnName("genre_id");

                entity.Property(e => e.GenreName)
                    .HasMaxLength(50)
                    .HasColumnName("genre_name");

                entity.HasMany(d => d.Movies)
                    .WithMany(p => p.Genres)
                    .UsingEntity<Dictionary<string, object>>(
                        "MovieGenre",
                        l => l.HasOne<Movie>().WithMany().HasForeignKey("MovieId").OnDelete(DeleteBehavior.ClientSetNull).HasConstraintName("FK__MovieGenr__movie__4222D4EF"),
                        r => r.HasOne<Genre>().WithMany().HasForeignKey("GenreId").OnDelete(DeleteBehavior.ClientSetNull).HasConstraintName("FK__MovieGenr__genre__44FF419A"),
                        j =>
                        {
                            j.HasKey("GenreId", "MovieId").HasName("PK__MovieGen__907E523660322376");

                            j.ToTable("MovieGenre");

                            j.IndexerProperty<int>("GenreId").HasColumnName("genre_id");

                            j.IndexerProperty<int>("MovieId").HasColumnName("movie_id");
                        });
            });

            modelBuilder.Entity<Movie>(entity =>
            {
                entity.ToTable("Movie");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever()
                    .HasColumnName("id");

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

            modelBuilder.Entity<News>(entity =>
            {
                entity.Property(e => e.NewsId)
                    .ValueGeneratedNever()
                    .HasColumnName("news_id");

                entity.Property(e => e.NewsContent)
                    .HasMaxLength(50)
                    .HasColumnName("news_content");

                entity.Property(e => e.NewsDateRelease)
                    .HasMaxLength(50)
                    .HasColumnName("news_date_release");
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
                entity.ToTable("User");

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
