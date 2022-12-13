class dianzan {
  String likes_id;
  String dest_id;
  String type;
  String create_time;
  String user_id;

  dianzan({
    this.likes_id,
    this.dest_id,
    this.type,
    this.create_time,
    this.user_id,
  });
  factory dianzan.fromJson(Map<String, dynamic> rootdata) {
    return new dianzan(
      likes_id: rootdata['likes_id'].toString(),
      dest_id: rootdata["dest_id"],
      type: rootdata["type"],
      create_time: rootdata["create_time"],
      user_id: rootdata["user_id"],
    );
  }
}
