import 'package:film_review/model/book.dart';
import 'package:film_review/model/jingli.dart';

class jinglilist {
  List<jingli> jilings;
  jinglilist({
    this.jilings,
  });
  factory jinglilist.fromJson(List<dynamic> parsedJson) {
    List<jingli> photos;

    photos = parsedJson.map((i) => jingli.fromJson(i)).toList();
    return new jinglilist(
      jilings: photos,
    );
  }
}
