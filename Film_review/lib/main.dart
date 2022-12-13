// import 'dart:convert';
// import 'package:film_review/PersonalCenter/MyCollect.dart';
// import 'package:film_review/PersonalCenter/MyMessage.dart';
// import 'package:film_review/PersonalCenter/MyPost.dart';
// import 'package:film_review/PersonalCenter/mypostdetails/MyPostLike.dart';
// import 'package:film_review/PersonalCenter/mypostdetails/MyPostRemark.dart';
// import 'package:film_review/Square/ranking_list/RankingList.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:film_review/PersonalCenter/Mine.dart';
// import 'package:film_review/PersonalCenter/about_details/UserAgreement.dart';
// import 'package:film_review/Square/SquarePage.dart';
// import 'package:film_review/Square/recommend/RecommendPage.dart';
// import 'package:film_review/PersonalCenter/Vip.dart';
// import 'package:flutter/material.dart';
// import 'Login/Forget_password.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'Login/Register.dart';
// import 'package:film_review/PersonalCenter/About.dart';
// import 'package:film_review/Login/User.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'rpx.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//         builder: (BuildContext context, BoxConstraints constraints) {
//           initScreenUtil(constraints); // 初始化屏幕适配插件
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             theme: ThemeData(
//               primarySwatch: Colors.blue,
//             ),
//             home: MyHomePage(),
//           );
//         }
//     );
//   }
// }
//
//
// class MyHomePage extends StatefulWidget {
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final GlobalKey _formKey = GlobalKey<FormState>();
//   String _email="", _password="",session_id="";
//   bool _isObscure = true;
//   Color _eyeColor = Colors.grey;
//   final List _loginMethod = [
//     {
//       "title": "wechat",
//       "icon": Icons.wechat,
//     },
//     {
//       "title": "Apple",
//       "icon": Icons.apple,
//     },
//     {
//       "title": "QQ",
//       "icon": Icons.quora,
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Form(
//         key: _formKey, // 设置globalKey，用于后面获取FormStat
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//
//         child: ListView(
//           padding: EdgeInsets.symmetric(horizontal: rpx(20)),
//           children: [
//             SizedBox(height: kToolbarHeight), // 距离顶部一个工具栏的高度
//             SizedBox(height: rpx(90)),
//             buildIcon(),
//             SizedBox(height: rpx(30)),
//             buildEmailTextField(), // 输入邮箱
//             SizedBox(height:rpx(30)),
//             buildPasswordTextField(context), // 输入密码
//             buildForgetPasswordText(context), // 忘记密码
//             SizedBox(height: rpx(60)),
//             buildLoginButton(context), // 登录按钮
//             SizedBox(height: rpx(150)),
//             buildOtherLoginText(), // 其他账号登录
//             buildOtherMethod(context), // 其他登录方式
//             buildRegisterText(context), // 注册
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildBackground(){
//     return Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             fit: BoxFit.cover,
//             image: new NetworkImage('https://randomuser.me/api/portraits/men/43.jpg'),
//           ),
//         ),
//     );
//   }
//
//   Widget buildRegisterText(context) {
//     return Center(
//       child: Padding(
//         padding:EdgeInsets.only(top: rpx(10)),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text('没有账号?'),
//             GestureDetector(
//               child: const Text('点击注册', style: TextStyle(color: Colors.green)),
//               onTap: () {
//                 print("点击注册");
//                 Navigator.push<int>(context, MaterialPageRoute(builder: (BuildContext context){
//                   return Register();
//                 }));
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildOtherMethod(context) {
//     return ButtonBar(
//       alignment: MainAxisAlignment.center,
//       children: _loginMethod
//           .map((item) =>
//           Builder(builder: (context) {
//             return IconButton(
//                 icon: Icon(item['icon'],
//                     color: Theme
//                         .of(context)
//                         .iconTheme
//                         .color),
//                 onPressed: () {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                         content: Text('${item['title']}登录'),
//                         action: SnackBarAction(
//                           label: '取消',
//                           onPressed: () {},
//                         )),
//                   );
//                 });
//           }))
//           .toList(),
//     );
//   }
//
//   Widget buildOtherLoginText() {
//     return Center(
//       child: Text(
//         '其他账号登录',
//         style: TextStyle(color: Colors.grey, fontSize: rpx(20)),
//       ),
//     );
//   }
//
//   Widget buildLoginButton(BuildContext context) {
//     return Align(
//       child: SizedBox(
//         height: rpx(60),
//         width: rpx(270),
//         child: ElevatedButton(
//           style: ButtonStyle(
//             // 设置圆角
//               shape: MaterialStateProperty.all(const StadiumBorder(
//                   side: BorderSide(style: BorderStyle.none)))),
//           child: Text('登录',
//               style: Theme
//                   .of(context)
//                   .primaryTextTheme
//                   .headline5),
//           onPressed: () async {
//             //表单校验通过才会继续执行
//             if ((_formKey.currentState as FormState).validate() && _email!="" && _password!="") {
//               (_formKey.currentState as FormState).save();
//               //TODO 访问后端（用户登录）
//               var headers = {
//                 'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
//               };
//               var request = http.MultipartRequest(
//                   'POST',
//                   Uri.parse('http://7b8e1f42.r3.vip.cpolar.cn/user_login'));
//               request.fields.addAll({
//                 'user_id': _email,
//                 'user_password': _password,
//               });
//               request.headers.addAll(headers);
//               http.StreamedResponse response = await request.send();
//               if (response.statusCode == 200) {
//                 String responseContent = await response.stream.transform(utf8.decoder).join();
//                 setState(() {
//                   session_id =
//                       json.decode(responseContent)["session_id"].toString();
//                 });
//                 print("hello:" + session_id);
//                 if (session_id == "null") {
//                   Fluttertoast.showToast(
//                       msg: "登录失败，请检查账号和密码",
//                       toastLength: Toast.LENGTH_SHORT,
//                       gravity: ToastGravity.BOTTOM,
//                       timeInSecForIosWeb:1,
//                       backgroundColor: const Color(0x000000),
//                       textColor: Colors.black54,
//                       fontSize: rpx(20.0)
//                   );
//                 } else {
//                   Navigator.push<int>(context,
//                       MaterialPageRoute(builder: (BuildContext context) {
//                         return SquarePage(session_id, _email, "user_name");
//                         // return Mine(_email, session_id);
//                       }));
//                 }
//                 // print(await response.stream.bytesToString());
//               }
//               else {
//                 print(response.reasonPhrase);
//                 Fluttertoast.showToast(
//                     msg: "登录失败，请检查网络连接",
//                     toastLength: Toast.LENGTH_SHORT,
//                     gravity: ToastGravity.BOTTOM,
//                     timeInSecForIosWeb: 1,
//                     backgroundColor: const Color(0x000000),
//                     textColor: Colors.black54,
//                     fontSize: rpx(20.0)
//                 );
//               }
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget buildForgetPasswordText(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top:rpx(8)),
//       child: Align(
//         alignment: Alignment.centerRight,
//         child: TextButton(
//           onPressed: () {
//             Navigator.push<int>(context, MaterialPageRoute(builder: (BuildContext context){
//               return Forget_password();
//             }));
//           },
//           child: Text("忘记密码？",
//               style: TextStyle(fontSize: rpx(20), color: Colors.grey)),
//         ),
//       ),
//     );
//   }
//
//   Widget buildPasswordTextField(BuildContext context) {
//     return TextFormField(
//         obscureText: _isObscure, // 是否显示文字
//         onSaved: (v) => _password = v,
//         validator: (v) {
//           if (v.isEmpty) {
//             return '请输入密码';
//           }
//           _password=v;
//         },
//         decoration: InputDecoration(
//             labelText: "Password",
//             suffixIcon: IconButton(
//               icon: Icon(
//                 Icons.remove_red_eye,
//                 color: _eyeColor,
//               ),
//               onPressed: () {
//                 // 修改 state 内部变量, 且需要界面内容更新, 需要使用 setState()
//                 setState(() {
//                   _isObscure = !_isObscure;
//                   _eyeColor = (_isObscure
//                       ? Colors.grey
//                       : Theme
//                       .of(context)
//                       .iconTheme
//                       .color);
//                 });
//               },
//             )));
//   }
//
//   Widget buildEmailTextField() {
//     return TextFormField(
//       decoration: const InputDecoration(labelText: 'Email Address'),
//       validator: (v) {
//         if (v.isEmpty) {
//           return '请输入id';
//         }
//         _email=v;
//       },
//       onSaved: (v) => _email = v,
//     );
//   }
//
//   Widget buildIcon() {
//     return Container(
//       child: Image.asset("images/if-library@1x.jpg",width: rpx(90),height: rpx(90),),
//     );
//   }
// }

/*
void main() {
  //设置Android头部的导航栏透明
  SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  runApp(new MyApp());
}
*/
import 'package:film_review/app.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'rpx.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'Login/Forget_password.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'Login/Register.dart';
import 'Login/User.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'rpx.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          initScreenUtil(constraints); // 初始化屏幕适配插件
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: MyHomePage(),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  String _email = "", _password = "", session_id = "",realemail;
  bool _isObscure = true;
  Color _eyeColor = Colors.grey;
  final List _loginMethod = [
    {
      "title": "wechat",
      "icon": Icons.wechat,
    },
    {
      "title": "Apple",
      "icon": Icons.apple,
    },
    {
      "title": "QQ",
      "icon": Icons.quora,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey, // 设置globalKey，用于后面获取FormStat
        autovalidateMode: AutovalidateMode.onUserInteraction,

        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: rpx(20)),
          children: [
            SizedBox(height: kToolbarHeight), // 距离顶部一个工具栏的高度
            SizedBox(height: rpx(90)),
            buildIcon(),
            SizedBox(height: rpx(30)),
            buildEmailTextField(), // 输入邮箱
            SizedBox(height: rpx(30)),
            buildPasswordTextField(context), // 输入密码
            buildForgetPasswordText(context), // 忘记密码
            SizedBox(height: rpx(60)),
            buildLoginButton(context), // 登录按钮
            SizedBox(height: rpx(150)),
            buildOtherLoginText(), // 其他账号登录
            buildOtherMethod(context), // 其他登录方式
            buildRegisterText(context), // 注册
          ],
        ),
      ),
    );
  }

  Widget buildBackground() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: new NetworkImage(
              'https://randomuser.me/api/portraits/men/43.jpg'),
        ),
      ),
    );
  }

  Widget buildRegisterText(context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: rpx(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('没有账号?'),
            GestureDetector(
              child: const Text('点击注册', style: TextStyle(color: Colors.green)),
              onTap: () {
                print("点击注册");
                Navigator.push<int>(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return Register();
                    }));
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildOtherMethod(context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: _loginMethod
          .map((item) => Builder(builder: (context) {
        return IconButton(
            icon: Icon(item['icon'],
                color: Theme.of(context).iconTheme.color),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('${item['title']}登录'),
                    action: SnackBarAction(
                      label: '取消',
                      onPressed: () {},
                    )),
              );
            });
      }))
          .toList(),
    );
  }

  Widget buildOtherLoginText() {
    return Center(
      child: Text(
        '其他账号登录',
        style: TextStyle(color: Colors.grey, fontSize: rpx(20)),
      ),
    );
  }

  String url = "http://6a857704.r2.vip.cpolar.cn";
  Widget buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: rpx(60),
        width: rpx(270),
        child: ElevatedButton(
          style: ButtonStyle(
            // 设置圆角
              shape: MaterialStateProperty.all(const StadiumBorder(
                  side: BorderSide(style: BorderStyle.none)))),
          child:
          Text('登录', style: Theme.of(context).primaryTextTheme.headline5),
          onPressed: () async {
            //表单校验通过才会继续执行
            if ((_formKey.currentState as FormState).validate() &&
                _email != "" &&
                _password != "") {
              (_formKey.currentState as FormState).save();
              //TODO 访问后端（用户登录）
              var headers = {
                'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
              };
              var request =
              http.MultipartRequest('POST', Uri.parse(url + '/user_login'));
              request.fields.addAll({
                'user_id': _email,
                'user_password': _password,
              });
              request.headers.addAll(headers);
              http.StreamedResponse response = await request.send();
              if (response.statusCode == 200) {
                String responseContent =
                await response.stream.transform(utf8.decoder).join();
                setState(() {
                  session_id =
                      json.decode(responseContent)["session_id"].toString();
                });
                print("hello:" + session_id);
                if (session_id == "null") {
                  Fluttertoast.showToast(
                      msg: "登录失败，请检查账号和密码",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: const Color(0x000000),
                      textColor: Colors.black54,
                      fontSize: rpx(20.0));
                } else {
                  print("_email:"+_email);
                  Navigator.push<int>(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return MyApp2(session_id,_email);
                        // return Mine(_email, session_id);
                        //session_id, _email, "user_name"
                      }));
                }
                // print(await response.stream.bytesToString());
              } else {
                print(response.reasonPhrase);
                Fluttertoast.showToast(
                    msg: "登录失败，请检查网络连接",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: const Color(0x000000),
                    textColor: Colors.black54,
                    fontSize: rpx(20.0));
              }
            }
          },
        ),
      ),
    );
  }

  Widget buildForgetPasswordText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: rpx(8)),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {
            Navigator.push<int>(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return Forget_password();
                }));
          },
          child: Text("忘记密码？",
              style: TextStyle(fontSize: rpx(20), color: Colors.grey)),
        ),
      ),
    );
  }

  Widget buildPasswordTextField(BuildContext context) {
    return TextFormField(
        obscureText: _isObscure, // 是否显示文字
        onSaved: (v) => _password = v,
        validator: (v) {
          if (v.isEmpty) {
            return '请输入密码';
          }
          _password = v;
        },
        decoration: InputDecoration(
            labelText: "Password",
            suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeColor,
              ),
              onPressed: () {
                // 修改 state 内部变量, 且需要界面内容更新, 需要使用 setState()
                setState(() {
                  _isObscure = !_isObscure;
                  _eyeColor = (_isObscure
                      ? Colors.grey
                      : Theme.of(context).iconTheme.color);
                });
              },
            )));
  }

  Widget buildEmailTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'User_id'),
      validator: (v) {
        if (v.isEmpty) {
          return '请输入id';
        }
        _email = v;
      },
      onSaved: (v) => _email = v,
    );
  }

  Widget buildIcon() {
    return Container(
      child: Image.asset(
        "images/if-library@1x.jpg",
        width: rpx(90),
        height: rpx(90),
      ),
    );
  }
}
