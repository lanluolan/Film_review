import 'package:film_review/model/shuping.dart';

class shupinglist {
  List<shuping> shupings;
  shupinglist({
    this.shupings,
  });
  factory shupinglist.fromJson(List<dynamic> parsedJson) {
    List<shuping> photos;

    photos = parsedJson.map((i) => shuping.fromJson(i)).toList();
    return new shupinglist(
      shupings: photos,
    );
  }
}
