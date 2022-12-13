import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:film_review/model/movie.dart';
import 'package:film_review/model/moviedan.dart';
import 'package:film_review/model/watch.dart';
import 'package:film_review/widgets/message/bangdan.dart';
import 'package:film_review/widgets/message/messageImage.dart';

class yingdanview extends StatefulWidget {
  moviedan b1;
  List<movie> movies;
  List<movie> yikanmovies = [];
  List<movie> planmovies = [];
  List<moviedan> yingdans = [];
  List<watch> watchs = [];
  String userid;
  yingdanview(this.b1, this.movies, this.yikanmovies, this.planmovies,
      this.yingdans, this.watchs,this.userid);
  @override
  State<StatefulWidget> createState() {
    return ScrollHomePageState(
        b1, movies, yikanmovies, planmovies, yingdans, watchs,userid);
  }
}

class ScrollHomePageState extends State {
  moviedan b1;
  List<movie> movies;
  List<movie> yikanmovies = [];
  List<movie> planmovies = [];
  List<moviedan> yingdans = [];
  String userid;
  List<watch> watchs = [];
  ScrollHomePageState(this.b1, this.movies, this.yikanmovies, this.planmovies,
      this.yingdans, this.watchs,this.userid);
  @override
  Widget build(BuildContext context) {
    print("yingdanview:${yingdans.length}");
    return Expanded(

        ///构建九宫格数据数据
        child: Container(
      padding: EdgeInsets.only(right: 10, left: 10, top: 10),
      child: buildGridView1(),
    ));
  }

  ///GridView 的基本使用
  ///通过构造函数来创建
  Widget buildGridView1() {
    return GridView(
      ///子Item排列规则
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //横轴元素个数
          crossAxisCount: 3,
          //纵轴间距
          mainAxisSpacing: 10.0,
          //横轴间距
          crossAxisSpacing: 10.0,
          //子组件宽高长度比例
          childAspectRatio: 0.75),

      ///GridView中使用的子Widegt
      children: buildListViewItemList(),
    );
  }

  List<Widget> buildListViewItemList() {
    List<Widget> list = [];

    for (int i = 0; i < b1.movie_id.length; i++) {
      list.add(buildListViewItemWidget(i));
    }

    return list;
  }

  ///创建GridView使用的子布局
  Widget buildListViewItemWidget(int index) {
    int k = 0;
    for (int i = 0; i < movies.length; i++) {
      if (movies[i].movie_id.toString() == b1.movie_id[index].toString()) {
        k = i;
        print(k);
        break;
      }
    }
    return new Container(
      ///内容剧中
      alignment: Alignment.center,

      ///根据角标来动态计算生成不同的背景颜色
      color: Colors.cyan[100 * (index % 9)],
      child: messageImage(
          movies[k], movies, yikanmovies, planmovies, yingdans, watchs,userid),
    );
  }
}
