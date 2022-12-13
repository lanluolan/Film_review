import 'package:flutter/material.dart';
import 'package:film_review/model/movie.dart';
import 'package:film_review/model/moviedan.dart';
import 'package:film_review/widgets/message/dianying.dart';
import 'package:http/http.dart' as http;

String url = "http://6a857704.r2.vip.cpolar.cn";

void postRequestFunction(moviedan m1, String list) async {
  //TODO 访问后端（用户登录）
  var headers = {
    'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)',
  };
  var request =
      http.MultipartRequest('POST', Uri.parse(url + '/movielist_modify'));
  request.fields.addAll({
    'movielist_id': m1.movielist_id.toString(),
    'movie_id': list,
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print("删除成功");

    // print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

class girdview2 extends StatelessWidget {
  //dianyinggard({Key key, this.movies}) : super(key: key);
  moviedan bangdan1;
  List<movie> movies;
  String session_id;
  girdview2(this.bangdan1, this.movies, this.session_id);
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
    for (int i = 0; i < bangdan1.movie_id.length; i++) {
      list.add(buildListViewItemWidget(i, f, context));
    }
    list.add(buildListViewItemWidget(bangdan1.movie_id.length, 1, context));
    return list;
  }

  ///创建GridView使用的子布局
  Widget buildListViewItemWidget(int index, int f, BuildContext context) {
    return Container(
      ///内容剧中
      alignment: Alignment.center,
      color: f == 1
          ? Color.fromARGB(255, 203, 200, 200)
          : Color.fromARGB(255, 255, 255, 255),
      child: f != 1
          ? InkWell(onTap: () {}, child: danimage(index))
          : IconButton(
              iconSize: 80,
              icon: const Icon(
                Icons.add,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => dianying(
                          select: 1,
                          bangdan1: bangdan1,
                          session_id: session_id,
                        )));
              },
            ),
    );
  }

  Widget danimage(int i) {
    int k = 0;
    for (int j = 0; j < movies.length; j++) {
      if (movies[j].movie_id.toString() == bangdan1.movie_id[i].toString()) {
        k = j;
        print(k);
        break;
      }
    }
    String url = "images/${movies[k].movie_picture}";
    String url2 = "images/saohei.webp";
    return Container(
        decoration: BoxDecoration(
          image: new DecorationImage(
            fit: BoxFit.cover,
            image: new ExactAssetImage(url == "images/" ? url2 : url),
          ),
        ),
        child: Row(
          children: [
            Spacer(),
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.delete_sharp),
                  color: Color.fromARGB(255, 8, 143, 143),
                  onPressed: () {
                    List<String> ans = [];
                    for (int j = 0; j < bangdan1.movie_id.length; j++) {
                      if (j != i) {
                        ans.add(bangdan1.movie_id[j].toString());
                      }
                    }
                    print("${ans}");
                    postRequestFunction(bangdan1, ans.toString());
                  },
                ),
              ],
            )
          ],
        ));
  }
}
