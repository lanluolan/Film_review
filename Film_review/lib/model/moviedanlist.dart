import 'package:film_review/model/book.dart';
import 'package:film_review/model/moviedan.dart';

class moviedanlist {
  List<moviedan> yingdans;
  moviedanlist({
    this.yingdans,
  });
  factory moviedanlist.fromJson(List<dynamic> parsedJson) {
    List<moviedan> photos;

    photos = parsedJson.map((i) => moviedan.fromJson(i)).toList();
    return new moviedanlist(
      yingdans: photos,
    );
  }
}
