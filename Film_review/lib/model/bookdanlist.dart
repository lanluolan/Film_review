import 'package:film_review/model/book.dart';
import 'package:film_review/model/bookdan.dart';
import 'package:film_review/model/moviedan.dart';

class bookdanlist {
  List<bookdan> bookdans;
  bookdanlist({
    this.bookdans,
  });
  factory bookdanlist.fromJson(List<dynamic> parsedJson) {
    List<bookdan> photos;

    photos = parsedJson.map((i) => bookdan.fromJson(i)).toList();
    return new bookdanlist(
      bookdans: photos,
    );
  }
}
