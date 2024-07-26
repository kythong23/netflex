class MovieGenres {
  int? mgenreid;
  int? movieId;
  int? genreId;
  Null? genre;
  Null? movie;

  MovieGenres(
      {this.mgenreid, this.movieId, this.genreId, this.genre, this.movie});

  MovieGenres.fromJson(Map<String, dynamic> json) {
    mgenreid = json['mgenreid'];
    movieId = json['movieId'];
    genreId = json['genreId'];
    genre = json['genre'];
    movie = json['movie'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mgenreid'] = this.mgenreid;
    data['movieId'] = this.movieId;
    data['genreId'] = this.genreId;
    data['genre'] = this.genre;
    data['movie'] = this.movie;
    return data;
  }
}