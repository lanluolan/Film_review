class user {
  String user_id;
  String user_name;
  String sex;
  String user_picture;
  String user_description;
  String create_time;
  String user_type;

  user({
    this.user_id,
    this.user_name,
    this.sex,
    this.user_picture,
    this.user_description,
    this.create_time,
    this.user_type,
  });
  factory user.fromJson(Map<String, dynamic> rootdata) {
    return new user(
      user_id: rootdata['user_id'].toString(),
      user_name: rootdata["user_name"],
      sex: rootdata["sex"],
      user_picture: rootdata["user_picture"],
      user_description: rootdata["user_description"],
      create_time: rootdata["create_time"],
      user_type: rootdata["user_type"],
    );
  }
}
