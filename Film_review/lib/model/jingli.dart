class jingli {
  String experience_id;
  String user_id;
  String title;
  String content;
  String type;

  jingli({
    this.experience_id,
    this.user_id,
    this.title,
    this.content,
    this.type,
  });
  factory jingli.fromJson(Map<String, dynamic> rootdata) {
    return new jingli(
      experience_id: rootdata['experience_id'].toString(),
      user_id: rootdata["user_id"],
      title: rootdata["title"],
      content: rootdata["content"],
      type: rootdata["type"],
    );
  }
}
