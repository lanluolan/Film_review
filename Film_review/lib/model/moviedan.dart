class moviedan {
  int movielist_id;
  String user_id;
  String movielist_name;
  String description;
  String movielist_picture;
  String create_time;
  List<dynamic> movie_id;
  List<dynamic> collector_id;

  moviedan({
    this.movielist_id,
    this.user_id,
    this.movielist_name,
    this.movielist_picture,
    this.description,
    this.create_time,
    this.movie_id,
    this.collector_id,
  });
  factory moviedan.fromJson(Map<String, dynamic> rootdata) {
    return new moviedan(
      movielist_id: rootdata['movielist_id'],
      user_id: rootdata["user_id"],
      movielist_name: rootdata["movielist_name"],
      movielist_picture: rootdata["movielist_picture"],
      description: rootdata["description"],
      create_time: rootdata["create_time"],
      movie_id: rootdata["movie_id"],
      collector_id: rootdata["collector_id"],
    );
  }
}
