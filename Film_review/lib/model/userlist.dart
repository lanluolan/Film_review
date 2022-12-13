import 'package:film_review/model/book.dart';
import 'package:film_review/model/user.dart';

class userlist {
  List<user> users;
  userlist({
    this.users,
  });
  factory userlist.fromJson(List<dynamic> parsedJson) {
    List<user> photos;

    photos = parsedJson.map((i) => user.fromJson(i)).toList();
    return new userlist(
      users: photos,
    );
  }
}
