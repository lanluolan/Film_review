import 'package:film_review/model/yueduzhuangtai.dart';

class yuduzhuangtailist {
  List<yuduzhuangtai> reads;
  yuduzhuangtailist({
    this.reads,
  });
  factory yuduzhuangtailist.fromJson(List<dynamic> parsedJson) {
    List<yuduzhuangtai> photos;

    photos = parsedJson.map((i) => yuduzhuangtai.fromJson(i)).toList();
    return new yuduzhuangtailist(
      reads: photos,
    );
  }
}
