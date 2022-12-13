class User{
  String user_id;
  String user_name;
  String sex;
  String user_picture;
  String user_description;
  String create_time;
  String user_type;

  User(this.user_id,this.user_name,this.sex,this.user_picture,this.user_description,this.create_time,this.user_type);
  User.fromJson(Map<String,dynamic> jsonStr){
    this.user_id=jsonStr['user_id'];
    this.user_name=jsonStr['user_name'];
    this.sex=jsonStr['sex'];
    this.user_picture=jsonStr['user_picture'];
    this.user_description=jsonStr['user_description'];
    this.create_time=jsonStr['create_time'];
    this.user_type=jsonStr['user_type'];
  }
}