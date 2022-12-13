//import 'package:json_annotation/json_annotation.dart';

class UserInfo {
  String userid;
  String username;
  String sex;
  String createtime;
  UserInfo(this.userid, this.username, this.sex, this.createtime);
  static UserInfo fromJson(Map<String, dynamic> rootdata) {
    Map<String, dynamic> data =
        Map<String, dynamic>.from(rootdata['content'][1]);
    UserInfo user = UserInfo(
        data["user_id"], data["user_name"], data["sex"], data["create_time"]);

    return user;
  }
}
