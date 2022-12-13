import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import '../main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';


bool isButtonEnable=true;      //按钮初始状态  是否可点击
String buttonText='发送验证码';   //初始文本
int count=60;                     //初始倒计时时间
Timer timer;                       //倒计时的计时器
TextEditingController mController=TextEditingController();


class Forget_password extends StatefulWidget {
  const Forget_password({Key key}) : super(key: key);

  @override
  State<Forget_password> createState() => _Forget_passwordState();
}

class _Forget_passwordState extends State<Forget_password> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.push<int>(context, MaterialPageRoute(builder: (BuildContext context){
            return MyApp();
          })); },
          icon: Icon(Icons.backspace),
        ),
        title: Text("忘记密码",style: TextStyle(color: Colors.black),),
        backgroundColor:Colors.transparent,
        elevation: 0,
      ),
      body: const MyBody(),
    );
  }
}

class MyBody extends StatefulWidget {
  const MyBody({Key key}) : super(key: key);

  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody>{
  final GlobalKey _formKey = GlobalKey<FormState>();
  String _email="", _password="",_passwordagain="",scode="";
  String url="http://6a857704.r2.vip.cpolar.cn";

  Widget build(BuildContext context){
    return Scaffold(
      body: Form(
        key: _formKey, // 设置globalKey，用于后面获取FormStat
        autovalidateMode: AutovalidateMode.onUserInteraction,

        child: ListView(
          padding:EdgeInsets.symmetric(horizontal: rpx(20)),
          children: [
            const SizedBox(height: kToolbarHeight), // 距离顶部一个工具栏的高度
            Container(
              child:const Center(
                child:Text("注意：仅限绑定过邮箱的用户",style:TextStyle(color:Colors.grey)),
              )
            ),
            SizedBox(height: rpx(30)),
            buildEmailTextField(),
            SizedBox(height: rpx(30)),
            buildPasswordTextField(context),
            SizedBox(height: rpx(30)),
            buildPasswordagainTextField(context),
            SizedBox(height: rpx(20)),
            buildScodeTextField(context),
          ],
        ),
      ),
    );
  }

  Widget buildPasswordTextField(BuildContext context) {
    return TextFormField(
        onSaved: (v) => _password = v,
        validator: (v) {
          if (v.isEmpty) {
            return '请输入密码';
          }
          _password=v;
        },
        decoration: const InputDecoration(hintText: "请输入新密码"),
    );
  }

  Widget buildPasswordagainTextField(BuildContext context) {
    return TextFormField(
        onSaved: (v) => _passwordagain = v,
        validator: (v) {
          if (v.isEmpty) {
            return '请输入正确的新密码';
          }
          if (v.compareTo(_password)!=0) {
            return '请输入正确的新密码';
          }
          _passwordagain=v;
        },
        decoration: InputDecoration(hintText: "请再次输入新密码")
    );
  }

  Widget buildEmailTextField() {
    return TextFormField(
      decoration: const InputDecoration(hintText: '请输入账号'),
      validator: (v) {
        if (v.isEmpty) {
          return '请输入正确的账号';
        }
        _email=v;
      },
      onSaved: (v) => _email = v,
    );
  }

  /// showModalBottomSheet：Material风格的底部弹窗
  showModalBottomSheetFunction(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(rpx(10)),
          color: Colors.white,
          height: rpx(240),
          width: double.infinity,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height:rpx(55),
                child: Text(
                  "收到信息",
                  style: TextStyle(fontSize: rpx(16), fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text(
                  "验证码为：$scode",
                  style: TextStyle(fontSize: rpx(14)),
                ),
              ),
              SizedBox(
                height: rpx(65),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        child: const Text("确定"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  Widget buildScodeTextField(context){
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              textBaseline: TextBaseline.ideographic,
              children: <Widget>[
                Expanded(
                  child: Padding(padding: EdgeInsets.only(right: rpx(15)),
                    child: TextFormField(
                      maxLines: 1,
                      onSaved: (value) { },
                      controller: mController,
                      textAlign: TextAlign.start,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9]")),    //只允许输入0-9的数字
                        LengthLimitingTextInputFormatter(6)                     //最大输入长度为6
                      ],
                      decoration: const InputDecoration(
                        hintText: ('填写验证码'),
                        alignLabelWithHint: true,
                      ),
                      validator:(v){
                        var scodeReg = RegExp("[0-9]");
                        if (!scodeReg.hasMatch(v) || v.compareTo(scode)!=0) {
                          return '请输入正确的验证码';
                        }
                      },
                    ),),
                ),
                SizedBox(
                  width: rpx(120),
                  child: MaterialButton(
                    disabledColor: Colors.grey.withOpacity(0.1),     //按钮禁用时的颜色
                    disabledTextColor: Colors.white,                   //按钮禁用时的文本颜色
                    textColor:isButtonEnable?Colors.white:Colors.black.withOpacity(0.2),                           //文本颜色
                    color: isButtonEnable?const Color(0xff44c5fe):Colors.grey.withOpacity(0.1),                          //按钮的颜色
                    splashColor: isButtonEnable?Colors.white.withOpacity(0.1):Colors.transparent,
                    shape:const StadiumBorder(side: BorderSide.none),
                    onPressed: () async {
                      if(isButtonEnable){
                        var headers = {
                          'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
                        };
                        var request = http.MultipartRequest('POST', Uri.parse('$url/user_code_send'));
                        request.fields.addAll({
                          'user_id': _email,
                        });
                        request.headers.addAll(headers);
                        http.StreamedResponse response = await request.send();

                        if (response.statusCode == 200) {
                          // response.stream.transform(utf8.decoder).join().then((String string) {
                          //   debugPrint(string);
                          // });
                          // print(await response.stream.bytesToString());
                          String responseContent=await response.stream.transform(utf8.decoder).join();
                          scode=json.decode(responseContent)["code"].toString();
                          debugPrint("scode:"+scode);
                          showModalBottomSheetFunction(context);
                        }
                        else {
                          print(response.reasonPhrase);
                        }
                        // debugPrint('$isButtonEnable');
                        setState(() {
                          _buttonClickListen();
                        });
                      }},
                    child:Text(buttonText,style:TextStyle(fontSize: rpx(13),),),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: rpx(45),
            margin: EdgeInsets.only(top: rpx(50),left: rpx(10),right:rpx(10)),
            child: ElevatedButton(
              onPressed: () async {
                var headers = {
                  'User-Agent': 'Apifox/1.0.0 (https://www.apifox.cn)'
                };
                var requestSubmitt = http.MultipartRequest('POST', Uri.parse('$url/user_pwd_change'));
                requestSubmitt.fields.addAll({
                  'user_id': _email,
                  'verified_code': scode,
                  'user_password': _password,
                });
                requestSubmitt.headers.addAll(headers);
                http.StreamedResponse responseSubmitt = await requestSubmitt.send();
                if (responseSubmitt.statusCode == 200) {
                  // print(await response.stream.bytesToString());
                  // String responseContentSubmitt=await responseSubmitt.stream.transform(utf8.decoder).join();
                  // String codeSubmitt=json.decode(responseContentSubmitt)["code"].toString();
                  // debugPrint("scode:"+codeSubmitt);
                  Fluttertoast.showToast(
                      msg: "提交成功",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: const Color(0x000000),
                      textColor: Colors.black54,
                      fontSize: rpx(16.0)
                  );
                }
                else {
                  Fluttertoast.showToast(
                      msg: "提交失败",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: const Color(0x000000),
                      textColor: Colors.black54,
                      fontSize: rpx(16.0)
                  );

                  print(responseSubmitt.reasonPhrase);
                }
              },

              style: ButtonStyle(
                backgroundColor:MaterialStateProperty.all(const Color(0xff44c5fe)),
                shape: MaterialStateProperty.all(const StadiumBorder(side: BorderSide.none)),//圆角弧度
              ),
              child:Text('提交', style: TextStyle(color: Colors.white,fontSize: rpx(20)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _buttonClickListen(){
    setState(() {
      if(isButtonEnable){         //当按钮可点击时
        isButtonEnable=false;   //按钮状态标记
        _initTimer();
      }
    });
  }

  void _initTimer(){
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      count--;
      setState(() {
        if(count==0){
          timer.cancel();             //倒计时结束取消定时器
          isButtonEnable=true;        //按钮可点击
          count=60;                   //重置时间
          buttonText='发送验证码';     //重置按钮文本
        }else{
          buttonText='重新发送($count)';  //更新文本内容
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();      //销毁计时器
    timer=null;
    mController?.dispose();
    super.dispose();
  }
}