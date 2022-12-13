import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:film_review/model/commet.dart';
import 'package:film_review/model/commetlist.dart';
import 'package:film_review/model/dianzan.dart';
import 'package:film_review/model/dianzanlist.dart';
import 'package:film_review/model/movie.dart';
import 'package:film_review/model/yingpingmodel.dart';
import 'package:film_review/widgets/booktotal/addreadsense.dart';
import 'package:film_review/widgets/message/addyingping.dart';
import 'package:film_review/widgets/message/yingpingItem.dart';

List<dianzan> dianzans = [];
List<comment> comments = [];
String url = "http://6a857704.r2.vip.cpolar.cn";
int len = 0;
void getdianzaninfo() async {
  len += 1;
  final dio = Dio();
  try {
    final uri = Uri.parse(url + "/likes_query?type=5");
    final uri2 = Uri.parse(url + "/comment_query");
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

bool judge(List<yingpingmodel> ans, yingpingmodel a) {
  for (int i = 0; i < ans.length; i++) {
    // print("${ans[i]} ${a}");

    if (ans[i].movie_reaction_id.toString() == a.movie_reaction_id.toString()) {
      return false;
    }
  }
  return true;
}

class messagepingjia extends StatefulWidget {
  movie m1;
  List<yingpingmodel> yingpings;
  String session_id;
  messagepingjia({Key key, this.m1, this.yingpings, this.session_id})
      : super(key: key);

  @override
  messagejiaState createState() => messagejiaState(m1, yingpings, session_id);
}

class messagejiaState extends State<messagepingjia>
    with SingleTickerProviderStateMixin {
  int _currentTopTabIndex;
  TabController _tabController;
  movie m1;
  List<yingpingmodel> yingpings;
  String session_id;
  messagejiaState(this.m1, this.yingpings, this.session_id);
  List<yingpingmodel> myyingpings = [];

  ScrollController _pageScrollerController, _pageScrollerController2;

  static const List<Tab> _homeTopTabList = <Tab>[
    Tab(
      text: '全部影评',
    ),
    Tab(
      text: '我的影评',
    ),
  ];
  @override
  void initState() {
    super.initState();
    // TabController的滚动事件会触发一次监听, 点击事件会触发两次监听(一次是正常触发,一次是tab的动画触发)
    _tabController = TabController(length: _homeTopTabList.length, vsync: this);

    // 添加监听获取tab选中下标
    _tabController.addListener(() {
      _currentTopTabIndex = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (len == 0) getdianzaninfo();
    for (int i = 0; i < yingpings.length; i++) {
      if (yingpings[i].user_id.toString() == "test") {
        if (judge(myyingpings, yingpings[i])) {
          myyingpings.add(yingpings[i]);
        }
      }
    }
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        title: Center(
          child: Text("影评"),
        ),
        bottom: TabBar(tabs: _homeTopTabList, controller: _tabController),
        actions: <Widget>[
          TextButton(
            child: Text("写影评",
                style: TextStyle(color: Color.fromARGB(255, 214, 122, 24))),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => yingping(
                        m1: m1,
                        session_id: session_id,
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
    return new Expanded(
      child: new ListView.builder(
        controller:
            flag == 1 ? _pageScrollerController : _pageScrollerController2,
        padding: const EdgeInsets.all(16.0), // 设置padding
        itemBuilder: (context, index) {
          if (flag == 1) {
            return messagenoticeItem(
                flag, myyingpings[index], dianzans, comments, session_id);
          } else {
            return messagenoticeItem(
                flag, yingpings[index], dianzans, comments, session_id);
          }
        },
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: flag == 0 ? yingpings.length : myyingpings.length,
      ),
    );
  }
}
