import 'package:flutter/material.dart';
import 'package:film_review/widgets/booktotal/addbooksearch.dart';
import 'package:http/http.dart' as http;

TextEditingController emailController =
    new TextEditingController(); //声明controller
TextEditingController emailController2 =
    new TextEditingController(); //声明controller
String bookid;
String url = "http://6a857704.r2.vip.cpolar.cn";
void postRequestFunction(String ans, String session_id) async {
  //TODO 访问后端（用户登录）
  var headers = {
    'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)',
    'Authorization': session_id.toString()
  };
  var request = http.MultipartRequest('POST', Uri.parse(url + '/booklist_add'));
  request.fields.addAll({
    'book_id': ans,
    'description': emailController2.text,
    'booklist_name': emailController.text,
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print("add书单成功");

    // print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

List<String> ans = [];

class addshudan extends StatelessWidget {
  String session_id;
  addshudan({Key key, this.session_id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("添加书单"),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              tooltip: '保存',
              onPressed: () {
                postRequestFunction(ans.toString(), session_id);
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
                decoration: InputDecoration(hintText: "请填写标题(二十个字以内)"),
                // 绑定控制器
                // controller: _username,
                // 输入改变以后的事件
                onChanged: (value) {},
              ),
              SizedBox(height: 20),
              TextFormField(
                autofocus: true,
                autocorrect: false,
                keyboardType: TextInputType.multiline,
                minLines: 20,
                maxLines: 20,
                decoration: InputDecoration(
                  hintText: "请添加书籍",
                  // filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  addbooksearch(ans, session_id))).then((info) {
                        print(info.toString());
                        ans = info;
                      });
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
