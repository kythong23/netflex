class Movies {
  int? id;
  String? title;
  String? description;
  String? img;
  int? duration;
  String? dateRelease;
  int? likes;
  int? episode;
  int? views;
  int? ageLimit;
  int? countryId;
  int? creatorId;
  int? subtitleId;
  String? status;

  Movies(
      {this.id,
        this.title,
        this.description,
        this.img,
        this.duration,
        this.dateRelease,
        this.likes,
        this.episode,
        this.views,
        this.ageLimit,
        this.countryId,
        this.creatorId,
        this.subtitleId,
        this.status});

  Movies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    img = json['img'];
    duration = json['duration'];
    dateRelease = json['dateRelease'];
    likes = json['likes'];
    episode = json['episode'];
    views = json['views'];
    ageLimit = json['ageLimit'];
    countryId = json['countryId'];
    creatorId = json['creatorId'];
    subtitleId = json['subtitleId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['img'] = this.img;
    data['duration'] = this.duration;
    data['dateRelease'] = this.dateRelease;
    data['likes'] = this.likes;
    data['episode'] = this.episode;
    data['views'] = this.views;
    data['ageLimit'] = this.ageLimit;
    data['countryId'] = this.countryId;
    data['creatorId'] = this.creatorId;
    data['subtitleId'] = this.subtitleId;
    data['status'] = this.status;
    return data;
  }
}