import 'package:flutter/material.dart';
import 'package:film_review/model/editgirdview2.dart';
import 'package:film_review/model/movie.dart';
import 'package:film_review/widgets/message/dianying.dart';
import 'package:http/http.dart' as http;

TextEditingController emailController =
    new TextEditingController(); //声明controller
TextEditingController emailController2 =
    new TextEditingController(); //声明controller
String bookid;
List<String> ans = [];
List<movie> addmovies = [];
String res = "请添加影片";
String url = "http://6a857704.r2.vip.cpolar.cn";
void postRequestFunction(String ans, String session_id) async {
  //TODO 访问后端（用户登录）
  var headers = {
    'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)',
    'Authorization': session_id.toString()
  };
  var request =
      http.MultipartRequest('POST', Uri.parse(url + '/movielist_add'));
  request.fields.addAll({
    'movielist_name': emailController.text,
    'description': emailController2.text,
    'movie_id': ans,
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print("添加影单成功");

    // print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

class addbangdan extends StatelessWidget {
  String session_id;
  addbangdan({Key key, this.session_id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("影单"),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              tooltip: '保存',
              onPressed: () {
                print(ans.toString());
                postRequestFunction(ans.toString(), session_id);
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: new SingleChildScrollView(
            child: Container(
                child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(hintText: "请填写标题(二十个子以内)"),
                // 绑定控制器
                // controller: _username,
                // 输入改变以后的事件
                onChanged: (value) {},
              ),
              SizedBox(height: 20),
              /* Container(
                  height: 400,
                  padding:
                      EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    border: new Border.all(
                        width: 1, color: Color.fromARGB(255, 79, 78, 78)),
                  ),
                  child: Column(
                    children: [view(addmovies, context)],
                  )),*/
              TextFormField(
                autofocus: true,
                autocorrect: false,
                keyboardType: TextInputType.multiline,
                minLines: 20,
                maxLines: 20,
                decoration: InputDecoration(
                  hintText: "${res}",
                  // filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => dianying(
                                    select: 2,
                                    res: ans,
                                  ))).then((info) {
                        print(info.toString());
                        ans = info;
                      });
                      // 调用 getImage 方法 , 调出相机拍照
                      // getImageFromCamera();
                    },
                  ),
                  fillColor: Color(0xFFF2F2F2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1),
                  ),
                ),
              ),
              TextField(
                controller: emailController2,
                decoration: InputDecoration(hintText: "#请填写标签"),
                // 绑定控制器
                // controller: _username,
                // 输入改变以后的事件
                onChanged: (value) {},
              ),
            ],
          ),
        )
                // 多行文本输入框

                )));
  }
}

Widget view(List<movie> movies, BuildContext context) {
  return Expanded(
    child: buildGridView(context),
  );
}

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

  ///模拟数据
  for (int i = 0; i < addmovies.length; i++) {
    list.add(buildListViewItemWidget(i, context));
  }
  list.add(ADD(context));
  return list;
}

///创建GridView使用的子布局
Widget buildListViewItemWidget(int index, BuildContext context) {
  String url = "images/${movies[index].movie_picture}";

  String url2 = "images/bengshanniliuchenhe.webp";
  return Container(

      ///内容剧中
      alignment: Alignment.center,
      color: Color.fromARGB(255, 255, 255, 255),
      child: ClipRRect(
          //borderRadius: BorderRadius.circular(5),
          child: Image.asset(url == "images/" ? url2 : url)
          // child: Image.network(
          // "http://7182fde7.r3.cpolar.top/book_query/${book1[bookid].book_picture}"),
          ));
}

bool judge(List<movie> ans, movie a) {
  for (int i = 0; i < ans.length; i++) {
    // print("${ans[i]} ${a}");

    if (ans[i].movie_id.toString() == a.movie_id.toString()) {
      return false;
    }
  }
  return true;
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
        setState() {
          if (ans.length != 0) {
            //girdview2(m1, movies);
            for (int i = 0; i < movies.length; i++) {
              for (int j = 0; j < ans.length; j++) {
                if (movies[i].movie_id.toString() == ans[j].toString()) {
                  if (judge(addmovies, movies[i])) {
                    addmovies.add(movies[i]);
                  }
                }
              }
            }
          }
          print("addmovies:${addmovies.length}");
        }

        print(ans.length);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => dianying(
                      select: 2,
                      res: ans,
                    ))).then((info) {
          print(info.toString());
          ans = info;
        });
      },
    ),
  );
}
