class comment {
  String comment_id;
  String dest_id;
  String type;
  String content;
  String create_time;
  String user_id;

  comment({
    this.comment_id,
    this.dest_id,
    this.type,
    this.content,
    this.create_time,
    this.user_id,
  });
  factory comment.fromJson(Map<String, dynamic> rootdata) {
    return new comment(
      comment_id: rootdata['comment_id'].toString(),
      content: rootdata['content'],
      dest_id: rootdata["dest_id"],
      type: rootdata["type"],
      create_time: rootdata["create_time"],
      user_id: rootdata["user_id"],
    );
  }
}
