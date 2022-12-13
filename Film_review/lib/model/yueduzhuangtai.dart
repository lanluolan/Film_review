class yuduzhuangtai {
  String reading_status_id;
  String user_id;
  String book_id;
  String reading_status;
  List<dynamic> reading_times;
  String create_time;
  List<dynamic> plan_times;
  String reading_pages;
  String total_pages;
  yuduzhuangtai({
    this.reading_status_id,
    this.user_id,
    this.book_id,
    this.reading_status,
    this.reading_times,
    this.create_time,
    this.plan_times,
    this.reading_pages,
    this.total_pages,
  });
  factory yuduzhuangtai.fromJson(Map<String, dynamic> rootdata) {
    return new yuduzhuangtai(
      reading_status_id: rootdata['reading_status_id'].toString(),
      user_id: rootdata["user_id"],
      book_id: rootdata["book_id"],
      reading_status: rootdata["reading_status"],
      reading_times: rootdata["reading_times"],
      create_time: rootdata["create_time"],
      plan_times: rootdata["plan_times"],
      reading_pages: rootdata["reading_pages"],
      total_pages: rootdata["total_pages"],
    );
  }
}
