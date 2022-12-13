import 'package:dio/dio.dart';
import 'package:film_review/model/book.dart';
import 'package:film_review/model/booklist.dart';
import 'package:film_review/model/yuduzhuangtailist.dart';
import 'package:film_review/model/yueduzhuangtai.dart';
import 'package:film_review/widgets/booktotal/reading.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:film_review/Login/User.dart';
import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<book> booksum = [];
List<yuduzhuangtai> reads = [];

class MyPlan extends StatefulWidget{
  User userData;
  List bookplan;
  List movieplan;
  List books;
  List movies;
  String session_id;
  MyPlan(this.userData,this.bookplan,this.movieplan,this.books,this.movies,this.session_id);
  @override
  MyPlanState createState() {
    return MyPlanState(userData:userData,bookplan:bookplan,movieplan:movieplan,books:books,movies:movies,session_id:session_id);
  }
}

class MyPlanState extends State<MyPlan> with SingleTickerProviderStateMixin{
  MyPlanState({Key key,this.userData,this.bookplan,this.movieplan,this.books,this.movies,this.session_id}) : super();
  String url="http://6a857704.r2.vip.cpolar.cn";
  final User userData;
  final List bookplan;
  final List movieplan;
  final List books;
  final List movies;
  final String session_id;


  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  String hour="";
  String min="";
  String nowdate="";
  String dateword="";
  Map datewordmap={};

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSetttings = InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings, onSelectNotification: onSelectNotification);
    String nowdatetemp = DateTime.now().toString().substring(0, 16);
    print("nowdatetemp:"+nowdatetemp);
    setState(() {
      // int temp = int.parse(nowdatetemp[12]);
      // if (temp >= 10) {
      //   nowdate = nowdatetemp.substring(0, 11) + temp.toString() + nowdatetemp.substring(13);
      // }
      nowdate=nowdatetemp.split(" ")[1];
      print("nowdate:"+nowdate);
    });
  }
  void getbookinfo(String userid) async {
    final dio = Dio();
    try {
      final uri = Uri.parse(url + "/book_query");
      final uri2 = Uri.parse(url + "/reading_status_query?user_id=${userid}");
      // 3.发送网络请求
      Response response, response2;
      response = await dio.getUri(uri);
      response2 = await dio.getUri(uri2);
      Map<String, dynamic> data = response.data;
      Map<String, dynamic> data2 = response2.data;
      booklist bookstory = booklist.fromJson(data["content"]);
      yuduzhuangtailist readsum = yuduzhuangtailist.fromJson(data2["content"]);

      //ans = response.data;
      booksum = bookstory.books;
      reads = readsum.reads;
    print("我的计划书籍阅读");

    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
  }

  void onSelectNotification(String payload) {
    debugPrint("payload : $payload");
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Notification'),
        content: Text('$payload'),
      ),
    );
  }
  showNotification() async {
    var android = AndroidNotificationDetails(
        'channel id', 'channel NAME',
        priority: Priority.high,importance: Importance.max
    );
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'Notice', 'You have a book to read', platform,
        payload: 'Nitish Kumar Singh is part time Youtuber');
    debugPrint("ok");
  }

  Postreading_status(String book_id,String date) async {
    print(session_id);
    print(book_id);
    print(date);
    //TODO 修改阅读状态
    var headers = {
      'Authorization': session_id,
      'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
    };
    var request = http.MultipartRequest('POST', Uri.parse('$url/reading_status_modify'));
    request.fields.addAll({
      'book_id': book_id,
      'plan_times': date,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("post ok");
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  List<Widget> _getbookData() {
    var temp = bookplan.map((value) {
      // print("value:"+value.toString());
      setState(() {
        if(value["plan_times"].toString()!="[]") {
          dateword=value["plan_times"][0];
          dateword=dateword.split(" ")[1].substring(0,5);
          datewordmap[value["reading_status_id"]]=dateword;
        }
        else {
          datewordmap[value["reading_status_id"]]="(无)";
          dateword="(无)";
        }
      });
      if(value["reading_status"]=="在读"){
        print("now"+nowdate);
        print("date:"+dateword);
        if(nowdate.compareTo(dateword)==0){
          showNotification();
        }
        for(int i=0;i<books.length;i++){
          if(value["book_id"]==books[i]["book_id"].toString()){
            return Card(
              elevation: rpx(10.0),
              margin: EdgeInsets.all(rpx(12.0)),
              child: Container(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(padding: EdgeInsets.only(left: rpx(1.0))),
                      Image.asset("images/${books[i]["book_picture"]}",height: rpx(240),width: rpx(140),),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(books[i]["book_name"].toString(),style: TextStyle(fontSize:rpx(18)),),
                              Text(books[i]["writer"],style: TextStyle(color: Colors.black45,fontSize: 12.0),),
                            ],
                          ),
                          SizedBox(height: rpx(20),),
                          Text("开始时间："+value["reading_times"][0].split(" ")[0]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("计划：每日"+datewordmap[value["reading_status_id"]]+"提醒"),
                              TextButton(onPressed: (){
                                setState(() {
                                  datewordmap[value["reading_status_id"]]="(无)";
                                });
                                Postreading_status(books[i]["book_id"].toString(), "[]");
                                Navigator.of(context).pop();
                              }, child: Text("关闭提醒")),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MaterialButton(
                                textColor: Colors.white,
                                color: Colors.lightBlue,
                                onPressed: (){
                                  int k=0;
                                  int k2=0;
                                  print(books[i]["book_id"].toString());
                                  print("booksum:${booksum.length}");
                                  for(int j=0;j<booksum.length;j++)
                                    {
                                        print("${booksum[j].book_id.toString()}  ${books[i]["book_id"].toString()}");
                                        if(booksum[j].book_id.toString()==books[i]["book_id"].toString())
                                          {

                                                 k=j;
                                                 break;
                                          }
                                    }
                                  for(int j=0;j<reads.length;j++)
                                    {
                                         if(reads[j].book_id.toString()==books[i]["book_id"].toString())
                                           {
                                                k2=j;
                                                break;
                                           }
                                    }
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => reading(
                                          b1: booksum[k],
                                          r1: reads[k2],
                                        )),
                                  );

                                },
                                child: Text("开始阅读"),
                              ),
                              Padding(padding: EdgeInsets.only(left: rpx(10.0))),
                              MaterialButton(color: Colors.lightBlue,onPressed: () {
                                DatePicker.showTimePicker(context,
                                    // 是否展示顶部操作按钮
                                    showTitleActions: true,
                                    // change事件
                                    onChanged: (date) {
                                      print('change $date');
                                    },
                                    // 确定事件
                                    onConfirm: (date) {
                                      print('confirm $date');
                                      String datepost="";
                                      String datepost2="";
                                      setState((){
                                        var temp=date.toString().split(" ");
                                        datewordmap[value["reading_status_id"]]=temp[1].substring(0,5);
                                        });
                                      datepost="[\"2022-12-12 "+datewordmap[value["reading_status_id"]]+":00\"";
                                      datepost2=",\"2022-12-12 "+datewordmap[value["reading_status_id"]]+":00\"]";
                                      Postreading_status(books[i]["book_id"].toString(), datepost+datepost2);
                                      Navigator.of(context).pop();
                                    },
                                    // 当前时间
                                    // currentTime: DateTime(2019, 6, 20, 17, 30, 20), // 指定时间
                                    currentTime: DateTime.now(),
                                    // 当前时间
                                    // 语言
                                    locale: LocaleType.zh);
                              },
                                child: Text(
                                  "修改计划",
                                  style: TextStyle(fontSize:rpx(20.0),color: Colors.white),
                                ),),
                            ],
                          )
                        ],
                      )
                    ],
                  )
              ),
            );
          }
        }
      }
      return SizedBox(height: rpx(1.0),);
    });
    return temp.toList();
  }

  List<Widget> _getmovieData() {
    var temp = bookplan.map((value) {
      return Card(
        elevation: rpx(10.0),
        margin: EdgeInsets.all(rpx(10.0)),
        child: Container(
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(padding: EdgeInsets.only(left: rpx(1.0))),
                Image.asset("images/huozhe.jpg",height: rpx(240),width: rpx(140),),
                Column(
                  children: [
                    Row(
                      children: [
                        Text("book_name".toString(),style: TextStyle(fontSize:rpx(18)),),
                        Text("(加西亚 - 马尔克斯)",style: TextStyle(color: Colors.black45,fontSize: 12.0),),
                      ],
                    ),
                    SizedBox(height: rpx(20),),
                    Text("开始时间：2022年10月1日"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("计划：每日20：00提醒"),
                        TextButton(onPressed: (){}, child: Text("关闭提醒")),
                      ],
                    ),
                    SizedBox(height: rpx(10),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MaterialButton(
                          textColor: Colors.white,
                          color: Colors.lightBlue,
                          onPressed: (){},
                          child: Text("开始阅读"),
                        ),
                        Padding(padding: EdgeInsets.only(left: rpx(10.0))),
                        MaterialButton(
                          textColor: Colors.white,
                          color: Colors.lightBlue,
                          onPressed: (){},
                          child: Text("修改计划"),
                        )
                      ],
                    )
                  ],
                )
              ],
            )
        ),
      );
    });
    return temp.toList();
  }

  @override
  Widget build(BuildContext context) {
    getbookinfo(userData.user_id.toString());
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text("我的计划", style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: ListView(
        children:  _getbookData(),
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}