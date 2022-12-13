class watch {
  String watching_status_id;
  String user_id;
  String movie_id;
  String watching_status;
  String status_time;
  String create_time;
  watch({
    this.watching_status_id,
    this.user_id,
    this.movie_id,
    this.watching_status,
    this.status_time,
    this.create_time,
  });
  factory watch.fromJson(Map<String, dynamic> rootdata) {
    return new watch(
      watching_status_id: rootdata['watching_status_id'].toString(),
      user_id: rootdata["user_id"],
      movie_id: rootdata["movie_id"],
      watching_status: rootdata["watching_status"],
      status_time: rootdata["status_time"],
      create_time: rootdata["create_time"],
    );
  }
}
