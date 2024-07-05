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
  String? trailer;

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
        this.status,
        this.trailer});

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
    trailer = json['trailer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['img'] = img;
    data['duration'] = duration;
    data['dateRelease'] = dateRelease;
    data['likes'] = likes;
    data['episode'] = episode;
    data['views'] = views;
    data['ageLimit'] = ageLimit;
    data['countryId'] = countryId;
    data['creatorId'] = creatorId;
    data['subtitleId'] = subtitleId;
    data['status'] = status;
    data['trailer'] = trailer;
    return data;
  }
}