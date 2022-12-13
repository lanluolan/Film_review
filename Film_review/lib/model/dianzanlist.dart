import 'package:film_review/model/book.dart';
import 'package:film_review/model/dianzan.dart';
import 'package:film_review/model/user.dart';

class dianzanlist {
  List<dianzan> dianzans;
  dianzanlist({
    this.dianzans,
  });
  factory dianzanlist.fromJson(List<dynamic> parsedJson) {
    List<dianzan> photos;

    photos = parsedJson.map((i) => dianzan.fromJson(i)).toList();
    return new dianzanlist(
      dianzans: photos,
    );
  }
}
