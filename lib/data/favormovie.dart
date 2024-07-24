class FavorMovies {
  int? favorId;
  int? movieId;
  int? userId;
  Null movie;
  Null user;

  FavorMovies({this.favorId, this.movieId, this.userId, this.movie, this.user});

  FavorMovies.fromJson(Map<String, dynamic> json) {
    favorId = json['favorId'];
    movieId = json['movieId'];
    userId = json['userId'];
    movie = json['movie'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['movieId'] = this.movieId;
    data['userId'] = this.userId;
    return data;
  }
}