import 'package:film_review/model/shuping.dart';
import 'package:film_review/model/yingpingmodel.dart';

class yingpinglist {
  List<yingpingmodel> yingpings;
  yingpinglist({
    this.yingpings,
  });
  factory yingpinglist.fromJson(List<dynamic> parsedJson) {
    List<yingpingmodel> photos;

    photos = parsedJson.map((i) => yingpingmodel.fromJson(i)).toList();
    return new yingpinglist(
      yingpings: photos,
    );
  }
}
