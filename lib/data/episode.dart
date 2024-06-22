class Episode {
  int? episodeId;
  String? name;
  String? link;
  int? movieId;

  Episode({this.episodeId, this.name, this.link, this.movieId});

  Episode.fromJson(Map<String, dynamic> json) {
    episodeId = json['episodeId'];
    name = json['name'];
    link = json['link'];
    movieId = json['movieId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['episodeId'] = this.episodeId;
    data['name'] = this.name;
    data['link'] = this.link;
    data['movieId'] = this.movieId;
    return data;
  }
}