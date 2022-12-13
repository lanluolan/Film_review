class movie {
  String movie_id;
  String movie_name;
  String director;
  String scriptwriter;
  String main_performer;
  String language;
  String movie_type;
  String producer_country;
  String description;
  String release_date;
  String duration;
  String movie_picture;
  movie({
    this.movie_id,
    this.movie_name,
    this.director,
    this.scriptwriter,
    this.main_performer,
    this.language,
    this.movie_type,
    this.producer_country,
    this.description,
    this.release_date,
    this.duration,
    this.movie_picture,
  });
  factory movie.fromJson(Map<String, dynamic> rootdata) {
    return new movie(
      movie_id: rootdata['movie_id'].toString(),
      release_date: rootdata['release_date'],
      movie_picture: rootdata['movie_picture'],
      duration: rootdata['duration'],
      movie_name: rootdata["movie_name"],
      director: rootdata["director"],
      scriptwriter: rootdata["scriptwriter"],
      main_performer: rootdata["main_performer"],
      language: rootdata["language"],
      movie_type: rootdata["movie_type"],
      producer_country: rootdata["producer_country"],
      description: rootdata["description"],
    );
  }
}
