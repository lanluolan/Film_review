class bookdan {
  int booklist_id;
  String user_id;
  String booklist_name;
  String description;
  String booklist_picture;
  String create_time;
  List<dynamic> book_id;
  List<dynamic> collector_id;

  bookdan({
    this.booklist_id,
    this.user_id,
    this.booklist_name,
    this.booklist_picture,
    this.description,
    this.create_time,
    this.book_id,
    this.collector_id,
  });
  factory bookdan.fromJson(Map<String, dynamic> rootdata) {
    return new bookdan(
      booklist_id: rootdata['booklist_id'],
      user_id: rootdata["user_id"],
      booklist_name: rootdata["booklist_name"],
      booklist_picture: rootdata["booklist_picture"],
      description: rootdata["description"],
      create_time: rootdata["create_time"],
      book_id: rootdata["book_id"],
      collector_id: rootdata["collector_id"],
    );
  }
}
