import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:film_review/model/book.dart';
import 'package:film_review/model/commet.dart';
import 'package:film_review/model/commetlist.dart';
import 'package:film_review/model/dianzan.dart';
import 'package:film_review/model/dianzanlist.dart';
import 'package:film_review/model/shuping.dart';
import 'package:film_review/widgets/booktotal/addreadsense.dart';
import 'booknoticeItem.dart';

List<dianzan> dianzans = [];
List<comment> comments = [];
String url = "http://6a857704.r2.vip.cpolar.cn";
int len = 0;
void getdianzaninfo() async {
  len += 1;
  final dio = Dio();
  try {
    final uri = Uri.parse(url + "/likes_query?type=6");
    final uri2 = Uri.parse(url + "/comment_query?type=6");
    // 3.发送网络请求
    Response response, response2;
    response = await dio.getUri(uri);
    response2 = await dio.getUri(uri2);
    Map<String, dynamic> data = response.data;
    Map<String, dynamic> data2 = response2.data;
    dianzanlist dianzansum = dianzanlist.fromJson(data["content"]);
    //  yuduzhuangtailist readsum = yuduzhuangtailist.fromJson(data2["content"]);
    dianzans = dianzansum.dianzans;
    commentlist comsum = commentlist.fromJson(data2["content"]);
    comments = comsum.comments;
    print("点赞和评论获得成功");
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

bool judge(List<shuping> ans, shuping a) {
  for (int i = 0; i < ans.length; i++) {
    // print("${ans[i]} ${a}");

    if (ans[i].book_reaction_id.toString() == a.book_reaction_id.toString()) {
      return false;
    }
  }
  return true;
}

class bookpingjia extends StatefulWidget {
  List<shuping> shupings;
  book b1;
  String session_id;
  String userid;
  bookpingjia({Key key, this.shupings, this.b1, this.session_id, this.userid})
      : super(key: key);
  @override
  bookpingjiaState createState() =>
      bookpingjiaState(shupings, b1, session_id, userid);
}

class bookpingjiaState extends State<bookpingjia>
    with SingleTickerProviderStateMixin {
  List<shuping> shupings;
  int _currentTopTabIndex;
  TabController _tabController;
  book b1;
  String userid;
  String session_id;
  bookpingjiaState(this.shupings, this.b1, this.session_id, this.userid);
  List<shuping> myshupings = [];

  ScrollController _pageScrollerController, _pageScrollerController2;

  static const List<Tab> _homeTopTabList = <Tab>[
    Tab(
      text: '全部书评',
    ),
    Tab(
      text: '我的书评',
    ),
  ];
  @override
  void initState() {
    super.initState();
    // TabController的滚动事件会触发一次监听, 点击事件会触发两次监听(一次是正常触发,一次是tab的动画触发)
    _tabController = TabController(length: _homeTopTabList.length, vsync: this);

    _pageScrollerController = ScrollController();
    _pageScrollerController2 = ScrollController();

    // 添加监听获取tab选中下标
    _tabController.addListener(() {
      _currentTopTabIndex = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    getdianzaninfo();
    for (int i = 0; i < shupings.length; i++) {
      if (shupings[i].user_id.toString() == userid.toString()) {
        if (judge(myshupings, shupings[i])) {
          myshupings.add(shupings[i]);
        }
      }
    }
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        title: Center(
          child: Text("书评"),
        ),
        bottom: TabBar(tabs: _homeTopTabList, controller: _tabController),
        actions: <Widget>[
          TextButton(
            child: Text("写书评",
                style: TextStyle(color: Color.fromARGB(255, 214, 122, 24))),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => readsense(
                        b1: b1,
                      )));
            },
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Column(
            children: [
              _buildSuggestions(0),
            ],
          ),
          Column(
            children: [
              _buildSuggestions(1),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSuggestions(int flag) {
    int cnt = 0;
    return new Expanded(
      child: new ListView.builder(
        controller:
            flag == 1 ? _pageScrollerController : _pageScrollerController2,
        padding: const EdgeInsets.all(16.0), // 设置padding
        itemBuilder: (context, index) {
          print("${flag}    2:${index}");
          if (flag == 1) {
            return booknoticeItem(
                flag, myshupings[index], dianzans, comments, session_id);
          } else {
            return booknoticeItem(
                flag, shupings[index], dianzans, comments, session_id);
          }
        },
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: flag == 0 ? shupings.length : myshupings.length,
      ),
    );
  }
}
