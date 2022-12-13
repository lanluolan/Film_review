class shuping {
  String book_reaction_id;
  String user_id;
  String book_id;
  String book_reaction_picture;
  String create_time;
  String title;
  String content;

  shuping({
    this.book_reaction_id,
    this.user_id,
    this.book_id,
    this.book_reaction_picture,
    this.create_time,
    this.title,
    this.content,
  });
  factory shuping.fromJson(Map<String, dynamic> rootdata) {
    return new shuping(
      book_reaction_id: rootdata['book_reaction_id'].toString(),
      user_id: rootdata["user_id"],
      book_id: rootdata["book_id"],
      book_reaction_picture: rootdata["book_reaction_picture"],
      create_time: rootdata["create_time"],
      title: rootdata["title"],
      content: rootdata["content"],
    );
  }
}
