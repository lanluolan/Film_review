import 'package:film_review/model/watch.dart';
import 'package:film_review/model/yueduzhuangtai.dart';

class watchlist {
  List<watch> watchs;
  watchlist({
    this.watchs,
  });
  factory watchlist.fromJson(List<dynamic> parsedJson) {
    List<watch> photos;

    photos = parsedJson.map((i) => watch.fromJson(i)).toList();
    return new watchlist(
      watchs: photos,
    );
  }
}
