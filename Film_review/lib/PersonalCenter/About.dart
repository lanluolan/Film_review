import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';
import 'package:film_review/PersonalCenter/menu_item.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:film_review/PersonalCenter/about_details/UserAgreement.dart';
import 'package:film_review/PersonalCenter/about_details/Privacy.dart';
import 'package:film_review/PersonalCenter/about_details/Suggestions.dart';
import 'package:film_review/PersonalCenter/about_details/Contact.dart';

class About extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          title: Text("关于",style: TextStyle(color: Colors.white),),
          centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: rpx(5.0)),
                  child: Column(
                    children: <Widget>[
                      //用户协议
                      MenuItems(
                        icon: Icons.format_list_numbered,
                        title: '用户协议',
                        onPressed: (){
                          Navigator.push<int>(context, MaterialPageRoute(builder: (BuildContext context){
                            return UserAgreement();
                          }));
                        },
                      ),
                      //隐私政策
                      MenuItems(
                        icon: Icons.privacy_tip_outlined,
                        title: '隐私政策',
                        onPressed: () {
                          Navigator.push<int>(context, MaterialPageRoute(builder: (BuildContext context){
                            return Privacy();
                          }));
                        },
                      ),
                      //意见反馈
                      MenuItems(
                        icon: Icons.settings_suggest,
                        title: '意见反馈',
                        onPressed: () {
                          Navigator.push<int>(context, MaterialPageRoute(builder: (BuildContext context){
                            return Suggestions();
                          }));
                        },
                      ),
                      //联系我们
                      MenuItems(
                        icon: Icons.phone,
                        title: '联系我们',
                        onPressed: () {
                          Navigator.push<int>(context, MaterialPageRoute(builder: (BuildContext context){
                            return Contact();
                          }));
                        },
                      ),
                      //版本号
                      MenuItems(
                        icon: Icons.person,
                        title: '版本号',
                        onPressed: () {
                          Fluttertoast.showToast(
                              msg: "v3.3.4版本",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: const Color(0x000000),
                              textColor: Colors.black54,
                              fontSize: rpx(16.0)
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
