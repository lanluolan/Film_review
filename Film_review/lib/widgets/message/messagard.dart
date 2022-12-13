import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:film_review/model/movie.dart';
import 'package:film_review/model/moviedan.dart';
import 'package:film_review/model/moviedanlist.dart';
import 'package:film_review/widgets/message/messagenote.dart';
import 'package:film_review/widgets/message/messagenote3.dart';
import 'dianying.dart';

/*
class dianyinggard extends StatefulWidget {
  @override
  List<movie> movies;
  State<StatefulWidget> createState() {
    return ScrollHomePageState();
  }
}*/

class dianyinggard extends StatelessWidget {
  List<movie> movies;
  List<moviedan> yingdans = [];
  String session_id;
  String userid;
  dianyinggard({Key key, this.movies, this.yingdans, this.session_id,this.userid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: buildGridView(context),
    );
  }

  ///GridView 的基本使用
  ///通过构造函数来创建
  Widget buildGridView(BuildContext context) {
    return GridView(
      ///子Item排列规则
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //横轴元素个数
          crossAxisCount: 3,
          //纵轴间距
          mainAxisSpacing: 10.0,
          //横轴间距
          crossAxisSpacing: 1.0,
          //子组件宽高长度比例
          childAspectRatio: 0.75),

      ///GridView中使用的子Widegt
      children: buildListViewItemList(context),
    );
  }

  List<Widget> buildListViewItemList(BuildContext context) {
    List<Widget> list = [];
    int f = 0;

    ///模拟数据
    for (int i = 0; i < movies.length; i++) {
      list.add(buildListViewItemWidget(i, f, context));
    }
    list.add(buildListViewItemWidget(movies.length, 1, context));
    return list;
  }

  ///创建GridView使用的子布局
  Widget buildListViewItemWidget(int index, int f, BuildContext context) {
    String url = "images/";
    if (f != 1) {
      url = url + "${movies[index].movie_picture}";
    }

    String url2 = "images/bengshanniliuchenhe.webp";
    return Container(
      ///内容剧中
      alignment: Alignment.center,
      color: f == 1
          ? Color.fromARGB(255, 203, 200, 200)
          : Color.fromARGB(255, 255, 255, 255),
      child: f != 1
          ? InkWell(
              onTap: (() => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => messageset(
                        m1: movies[index],
                        yingdans: yingdans,
                        session_id: session_id,
                      )))),
              child: ClipRRect(
                  //borderRadius: BorderRadius.circular(5),
                  child: Image.asset(url == "images/" ? url2 : url)
                  // child: Image.network(
                  // "http://7182fde7.r3.cpolar.top/book_query/${book1[bookid].book_picture}"),
                  ))
          : IconButton(
              iconSize: 80,
              icon: const Icon(
                Icons.add,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => dianying(userid: userid
                  ,)));
              },
            ),
    );
  }

  Widget ADD(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      color: Color.fromARGB(255, 203, 200, 200),
      child: IconButton(
        iconSize: 80,
        icon: const Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => dianying(userid: userid,)));
        },
      ),
    );
  }
}
