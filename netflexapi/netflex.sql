use netflex
go


alter table MovieGenre add primary key (genre_id,movie_id)
alter table MovieGenre add foreign key (genre_id) references Genre(genre_id)
alter table MovieGenre add foreign key (movie_id) references Movie(id)

alter table Movie add foreign key (creator_id) references Creator(creator_id)
alter table Subtitle add foreign key (country_id) references Country(country_id)
alter table Movie add foreign key (subtitle_id) references Subtitle(subtitle_id)
alter table Actor add foreign key (movie_id) references Movie(id)

alter table Episode add foreign key (movie_id) references Movie(id)

alter table FavorMovie add foreign key (MovieID) references Movie(id)
alter table FavorMovie add foreign key (UserID) references Users(user_id)

alter table Subcription add foreign key (userid) references Users(user_id)

alter table News add foreign key (movieid) references Movie(id)
alter table News add foreign key (userid) references Users(user_id)

alter table MovieGenre add foreign key (movie_id) references Movie(id)
alter table MovieGenre add foreign key (genre_id) references Genre(genre_id)