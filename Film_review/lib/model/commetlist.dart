import 'package:film_review/model/book.dart';
import 'package:film_review/model/commet.dart';
import 'package:film_review/model/dianzan.dart';
import 'package:film_review/model/user.dart';

class commentlist {
  List<comment> comments;
  commentlist({
    this.comments,
  });
  factory commentlist.fromJson(List<dynamic> parsedJson) {
    List<comment> photos;

    photos = parsedJson.map((i) => comment.fromJson(i)).toList();
    return new commentlist(
      comments: photos,
    );
  }
}
