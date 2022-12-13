class yingpingmodel {
  String movie_reaction_id;
  String user_id;
  String movie_id;
  String movie_reaction_picture;
  String create_time;
  String title;
  String content;

  yingpingmodel({
    this.movie_reaction_id,
    this.user_id,
    this.movie_id,
    this.movie_reaction_picture,
    this.create_time,
    this.title,
    this.content,
  });
  factory yingpingmodel.fromJson(Map<String, dynamic> rootdata) {
    return new yingpingmodel(
      movie_reaction_id: rootdata['movie_reaction_id'].toString(),
      user_id: rootdata["user_id"],
      movie_id: rootdata["movie_id"],
      movie_reaction_picture: rootdata["movie_reaction_picture"],
      create_time: rootdata["create_time"],
      title: rootdata["title"],
      content: rootdata["content"],
    );
  }
}
