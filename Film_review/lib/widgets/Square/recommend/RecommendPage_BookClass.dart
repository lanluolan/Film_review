class Book {
  String book_id;
  String book_name;
  String version;
  String writer;
  String publisher;
  String publication_date;
  String book_type;
  String book_picture;
  String language;
  String price;
  String description;

  Book(
      this.book_id,
      this.book_name,
      this.version,
      this.writer,
      this.publisher,
      this.publication_date,
      this.book_type,
      this.book_picture,
      this.language,
      this.price,
      this.description);
  Book.fromJson(Map<String, dynamic> jsonStr) {
    this.book_id = jsonStr['book_id'].toString();
    this.book_name = jsonStr['book_name'];
    this.version = jsonStr['version'];
    this.writer = jsonStr['writer'];
    this.publisher = jsonStr['publisher'];
    this.publication_date = jsonStr['publication_date'];
    this.book_picture = jsonStr['book_picture'];
    this.book_type = jsonStr['book_type'];
    this.book_type = jsonStr['book_type'];
    this.language = jsonStr['language'];
    this.price = jsonStr['price'];
    this.description = jsonStr['description'];
  }
}
