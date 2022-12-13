class book {
  String book_id;
  String book_name;
  String book_picture;
  String book_type;
  String description;
  String language;
  String price;
  String publication_date;
  String publisher;
  String version;
  String writer;

  book(
      {this.book_id,
      this.book_name,
      this.book_picture,
      this.book_type,
      this.description,
      this.language,
      this.price,
      this.publication_date,
      this.publisher,
      this.version,
      this.writer});
  factory book.fromJson(Map<String, dynamic> rootdata) {
    return new book(
        book_id: rootdata['book_id'].toString(),
        book_name: rootdata["book_name"],
        book_picture: rootdata["book_picture"],
        book_type: rootdata["book_type"],
        description: rootdata["description"],
        language: rootdata["language"],
        price: rootdata["price"],
        publication_date: rootdata["publication_date"],
        publisher: rootdata["publisher"],
        version: rootdata["version"],
        writer: rootdata["writer"]);
  }
}
