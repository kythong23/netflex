class Genre {
  int? genreId;
  String? genreName;
  Null movieGenreMgenre;
  List<Null>? movieGenreGenres;

  Genre(
      {this.genreId,
        this.genreName,
        this.movieGenreMgenre,
        this.movieGenreGenres});

  Genre.fromJson(Map<String, dynamic> json) {
    genreId = json['genreId'];
    genreName = json['genreName'];
    movieGenreMgenre = json['movieGenreMgenre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['genreId'] = this.genreId;
    data['genreName'] = this.genreName;
    data['movieGenreMgenre'] = this.movieGenreMgenre;
    return data;
  }
}