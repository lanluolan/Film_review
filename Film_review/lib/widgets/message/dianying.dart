import 'dart:ffi';

import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:film_review/model/movie.dart';
import 'package:film_review/model/moviedan.dart';
import 'package:film_review/model/moviedanlist.dart';
import 'package:film_review/model/movielist.dart';
import 'package:film_review/model/search.dart';
import 'package:film_review/model/watch.dart';
import 'package:film_review/model/watchlist.dart';
import 'package:film_review/widgets/message/messagenote.dart';
import 'package:film_review/widgets/message/messagenote2.dart';
import 'package:film_review/widgets/message/messagenote3.dart';
import 'package:http/http.dart' as http;

String dropdownValue1 = "综合";
String dropdownValue2 = "类型";
String dropdownValue3 = "地区";
String dropdownValue4 = "年份";

List<movie> movies = [];
List<movie> planmovies = [];
List<movie> yikanmovies = [];
List<watch> watchs = [];

String url = "http://6a857704.r2.vip.cpolar.cn";
void postRequestFunction(moviedan m1, String ans) async {
  //TODO 访问后端（用户登录）
  var headers = {
    'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)',
  };
  var request =
      http.MultipartRequest('POST', Uri.parse(url + '/movielist_modify'));
  request.fields.addAll({
    'movielist_id': m1.movielist_id.toString(),
    'movie_id': ans,
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print("添加电影成功");

    // print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

void getmovielistdiangying() async {
  final dio = Dio();
  try {
    Response response = await dio.get(url + "/movie_query");
    Response response2 =
        await dio.get(url + "/watching_status_query?user_id=test");
    print('电影成功');
    Map<String, dynamic> data = response.data;
    Map<String, dynamic> data2 = response2.data;
    watchlist watchsum = watchlist.fromJson(data2["content"]);
    movielist moviesum = movielist.fromJson(data["content"]);
    movies = moviesum.movies;
    watchs = watchsum.watchs;
    for (int i = 0; i < watchsum.watchs.length; i++) {
      for (int j = 0; j < moviesum.movies.length; j++) {
        if (watchsum.watchs[i].movie_id == moviesum.movies[j].movie_id) {
          if (watchsum.watchs[i].watching_status == "计划看") {
            planmovies.add(moviesum.movies[j]);
          } else {
            yikanmovies.add(moviesum.movies[j]);
          }
        }
      }
    }
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

int len = 0;
List<moviedan> yingdans = [];

void getbangdan() async {
  len = 1;
  final dio = Dio();
  try {
    Response response2 = await dio.get(url + "/movielist_query");
    Map<String, dynamic> data2 = response2.data;
    moviedanlist yingdansum = moviedanlist.fromJson(data2["content"]);
    yingdans = yingdansum.yingdans;
    print('榜单成功');
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

class dianying extends StatefulWidget {
  int select;
  moviedan bangdan1;
  List<String> res;
  String session_id;
  String userid;
  dianying({Key key, this.select, this.bangdan1, this.res, this.session_id,this.userid})
      : super(key: key);

  @override
  dianyingState createState() =>
      dianyingState(select, bangdan1, res, session_id,this.userid);
}

class dianyingState extends State<dianying> {
  int select;
  moviedan bangdan1;
  List<String> res;
  String session_id;
  String userid;
  dianyingState(this.select, this.bangdan1, this.res, this.session_id,this.userid);
  @override
  Widget build(BuildContext context) {
    getmovielistdiangying();
    if (len == 0) getbangdan();
    var now = DateTime.now();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("电影"),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: '搜索',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => SearchPage(
                        type: 1,
                      )));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          ButtonBar(
            alignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              DropdownButton<String>(
                underline: const SizedBox(),
                // decoration:
                // const InputDecoration(border: OutlineInputBorder()),
                value: dropdownValue1,
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue1 = newValue;
                  });
                },
                items: <String>['综合', '最热', '好评', '最新', '即将上线']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              DropdownButton<String>(
                underline: const SizedBox(),
                // decoration:
                // const InputDecoration(border: OutlineInputBorder()),
                value: dropdownValue2,
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue2 = newValue;
                  });
                },
                items: <String>[
                  '类型',
                  '喜剧',
                  '动画',
                  '动作',
                  '爱情',
                  '恐怖',
                  '战争',
                  '悬疑',
                  '青春'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              DropdownButton<String>(
                underline: const SizedBox(),
                // decoration:
                // const InputDecoration(border: OutlineInputBorder()),
                value: dropdownValue3,
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue3 = newValue;
                  });
                },
                items: <String>[
                  '地区',
                  '中国大陆',
                  '美国',
                  '中国香港',
                  '韩国',
                  '日本',
                  '欧洲',
                  '英国',
                  '其他',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              DropdownButton<String>(
                underline: const SizedBox(),
                // decoration:
                // const InputDecoration(border: OutlineInputBorder()),
                value: dropdownValue4,
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue4 = newValue;
                  });
                },
                items: <String>[
                  '年份',
                  '2022',
                  '2021',
                  '2020',
                  '10年代',
                  '00年代',
                  '90年代',
                  '80年代',
                  '其他',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          Container(
            width: 450,
            child: buildGridView(),
          )
        ]),
      ),
    );
  }

  ///GridView 的基本使用
  ///通过构造函数来创建
  Widget buildGridView() {
    return GridView(
      ///子Item排列规则
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //横轴元素个数
          crossAxisCount: 2,
          //纵轴间距
          mainAxisSpacing: 10.0,
          //横轴间距
          crossAxisSpacing: 1.0,
          //子组件宽高长度比例
          childAspectRatio: 0.75),

      ///GridView中使用的子Widegt
      children: buildListViewItemList(),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }

  ///GridView 的基本使用
  ///通过custom方式来创建

  List<Widget> buildListViewItemList() {
    List<Widget> list = [];
    bool judge(movie a) {
      List<String> ans = [];
      ans = a.movie_type.split("/");
      for (int i = 0; i < ans.length; i++) {
        if (dropdownValue2 == ans[i] && ans[i].length == 2) {
          return true;
        } else if (ans[i].length == 3) {
          //print("全3：${ans[i]} ${ans[i].substring(0, 2)}");
          //print(" ${ans[i].substring(1, 3)}");
          if (dropdownValue2 == ans[i].substring(1, 3) ||
              dropdownValue2 == ans[i].substring(0, 2)) {
            return true;
          }
        } else if (ans[i].length == 4) {
          if (dropdownValue2 == ans[i].substring(1, 2)) {
            return true;
          }
        }
      }
      return false;
    }

    for (int i = 0; i < movies.length; i++) {
      if (dropdownValue1 == "综合" &&
          dropdownValue2 == "类型" &&
          dropdownValue3 == "地区" &&
          dropdownValue4 == "年份")
        list.add(buildListViewItemWidget(i));
      else {
        if (dropdownValue2 == "类型" || judge(movies[i])) {
          if (dropdownValue3 == "地区" ||
              movies[i].producer_country == dropdownValue3) {
            if (dropdownValue4 == "年份" ||
                movies[i].release_date.substring(0, 4) == dropdownValue4) {
              list.add(buildListViewItemWidget(i));
            } else {
              if (dropdownValue4.substring(2, 4) == "年代") {
                if (int.parse(movies[i].release_date.substring(2, 4)) <
                        int.parse(dropdownValue4.substring(0, 2)) + 10 &&
                    int.parse(movies[i].release_date.substring(2, 4)) >=
                        int.parse(dropdownValue4.substring(0, 2))) {
                  list.add(buildListViewItemWidget(i));
                }
                print(int.parse(movies[i].release_date.substring(0, 2)));
                print("年代：${int.parse(dropdownValue4.substring(0, 2))}");
              }
            }
          }
        }
      }
    }

    return list;
  }

  Widget buildListViewItemWidget(int index) {
    String url = "images/${movies[index].movie_picture}";
    String url2 = "images/saohei.webp";
    return new Container(

        ///内容剧中
        alignment: Alignment.center,

        ///根据角标来动态计算生成不同的背景颜色
        // color: Colors.cyan[100 * (index % 9)],
        child: Column(
          children: [
            InkWell(
                child: Image(
                  image: AssetImage(url == "images/" ? url2 : url),
                  height: 200,
                ),
                onTap: () {
                  print("select:${select}");
                  if (select == 1) {
                    List<String> ans = [];
                    for (int i = 0; i < bangdan1.movie_id.length; i++) {
                      ans.add(bangdan1.movie_id[i].toString());
                    }
                    ans.add(movies[index].movie_id.toString());
                    print(ans);
                    postRequestFunction(bangdan1, ans.toString());
                    Navigator.pop(context);
                  } else if (select == 2) {
                    List<String> ans = [];
                    if (res.length != 0) {
                      for (int i = 0; i < res.length; i++) {
                        ans.add(res[i].toString());
                      }
                    }

                    ans.add(movies[index].movie_id.toString());
                    Navigator.pop(context, ans);
                  } else {
                    int flag = 0;
                    for (int i = 0; i < yikanmovies.length; i++) {
                      if (movies[index].movie_id == yikanmovies[i].movie_id) {
                        flag = 1;
                        break;
                      }
                    }
                    for (int i = 0; i < planmovies.length; i++) {
                      if (movies[index].movie_id == planmovies[i].movie_id) {
                        flag = 2;
                        break;
                      }
                    }
                    if (flag == 1) {
                      int k = 0;
                      for (int i = 0; i < watchs.length; i++) {
                        if (watchs[i].movie_id.toString() ==
                            movies[index].movie_id.toString()) {
                          if (watchs[i].user_id == "test") {
                            k = i;
                            break;
                          }
                        }
                      }
                      //已看
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => messagenote2(
                                m1: movies[index],
                                yingdans: yingdans,
                                movies: movies,
                                w: watchs[k],
                                session_id: session_id,
                            userid: userid,
                              )));
                    } else if (flag == 2) {
                      //计划看
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => messageset(
                                m1: movies[index],
                                yingdans: yingdans,
                                movies: movies,
                                session_id: session_id,
                            userid: userid,
                              )));
                    } else {
                      //未看
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => messagenote(
                                m1: movies[index],
                                yingdans: yingdans,
                                movies: movies,
                            session_id:session_id ,
userid: userid,
                              )));
                    }
                  }
                }),
            Text(
              "${movies[index].movie_name}",
              maxLines: 3,
            )
          ],
        ));
  }
}
