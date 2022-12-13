class Movie {
  String movie_id;
  String movie_name;
  String movie_picture;
  String director;
  String scriptwriter;
  String main_performer;
  String movie_type;
  String producer_country;
  String language;
  String release_date;
  String duration;
  String description;

  Movie(
      this.movie_id,
      this.movie_name,
      this.movie_picture,
      this.director,
      this.scriptwriter,
      this.main_performer,
      this.movie_type,
      this.producer_country,
      this.language,
      this.release_date,
      this.duration,
      this.description);
  Movie.fromJson(Map<String, dynamic> jsonStr) {
    this.movie_id = jsonStr['movie_id'].toString();
    this.movie_name = jsonStr['movie_name'];
    this.movie_picture = jsonStr['movie_picture'];
    this.director = jsonStr['director'];
    this.scriptwriter = jsonStr['scriptwriter'];
    this.main_performer = jsonStr['main_performer'];
    this.movie_type = jsonStr['movie_type'];
    this.producer_country = jsonStr['producer_country'];
    this.language = jsonStr['language'];
    this.release_date = jsonStr['release_date'];
    this.duration = jsonStr['duration'];
    this.description = jsonStr['description'];
  }
}
