import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';

class Vip extends StatefulWidget{
  @override
  VipState createState() {
    return VipState();
  }
}

class VipState extends State<Vip> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text("会员中心", style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body:
      Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Center(
              child:  CircleAvatar(
                backgroundImage: AssetImage(
                  "images/beijin.jpg",
                ),
                minRadius: 28,
              ),

            ),
            SizedBox(height: rpx(20.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("我的积分", style: TextStyle(fontSize: rpx(25.0)),),
                    SizedBox(height: rpx(5.0),),
                    Text("311",
                      style: TextStyle(fontSize: rpx(18.0), color: Colors.orange),)
                  ],
                ),
                Column(
                  children: [
                    Text("我的会员", style: TextStyle(fontSize: rpx(25.0)),),
                    SizedBox(height: rpx(5.0),),
                    Text("已过期9天",
                      style: TextStyle(fontSize: rpx(18.0), color: Colors.black26),)
                  ],
                ),
                Column(
                  children: [
                    Text("兑换会员", style: TextStyle(fontSize: rpx(25.0)),),
                    SizedBox(height: rpx(5.0),),
                    Text("还差290积分",
                      style: TextStyle(fontSize: rpx(18.0), color: Colors.orange),)
                  ],
                ),
              ],
            ),
            SizedBox(height: rpx(15.0),),
            Text("了解更多兑换会员权益",
                style: TextStyle(fontSize: rpx(18.0), color: Colors.black26)),
            //第一条线
            Padding(
              padding: EdgeInsets.only(left: rpx(10.0), right: rpx(10.0)),
              child: Divider(
                color: Colors.black12,
              ),
            ),
            //会员标题
            Row(
              children: [
                Text("开通会员", style: TextStyle(fontSize: rpx(18.0)),),
                Padding(padding: EdgeInsets.only(left: rpx(5.0))),
                Text("活动截止时间2022-12-31 00：00",
                  style: TextStyle(fontSize: rpx(15.0), color: Colors.red),)
              ],
            ),
            SizedBox(height: rpx(5.0),),
            //会员类型按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  onPressed: () {},
                  height: rpx(120.0),
                  shape: const RoundedRectangleBorder(
                    //边框颜色
                    side: BorderSide(
                      color: Colors.black26,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text("终身会员", style: TextStyle(
                          fontSize: rpx(15.0), color: Colors.orange),),
                      SizedBox(height: rpx(10.0),),
                      Text("￥188",
                        style: TextStyle(fontSize: rpx(15.0), color: Colors.red),)
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  height: rpx(120.0),
                  shape: const RoundedRectangleBorder(
                    //边框颜色
                    side: BorderSide(
                      color: Colors.black26,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text("高级会员年卡", style: TextStyle(
                          fontSize: rpx(15.0), color: Colors.orange),),
                      SizedBox(height: rpx(10.0),),
                      Text("￥88",
                        style: TextStyle(fontSize: rpx(15.0), color: Colors.red),)
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  height: rpx(120.0),
                  shape: const RoundedRectangleBorder(
                    //边框颜色
                    side: BorderSide(
                      color: Colors.black26,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text("高级会员月卡", style: TextStyle(
                          fontSize: rpx(15.0), color: Colors.orange),),
                      SizedBox(height: rpx(10.0),),
                      Text("￥8",
                        style: TextStyle(fontSize: rpx(15.0), color: Colors.red),)
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: rpx(5.0),),
            //第二条线
            Padding(
              padding: EdgeInsets.only(left: rpx(10.0), right: rpx(10.0)),
              child: Divider(
                color: Colors.black26,
              ),
            ),
            //第三条线
            Padding(
              padding: EdgeInsets.only(left: rpx(10.0), right: rpx(10.0)),
              child: Divider(
                color: Colors.black26,
              ),
            ),
            //会员特权标题
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("会员特权", style: TextStyle(fontSize: rpx(18.0)),),
              ],
            ),
            SizedBox(height: rpx(10.0),),
            //特权图片
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "images/tequan1.png", width: rpx(120.0), height: rpx(120.0),),
                    Image.asset(
                      "images/tequan2.png", width: rpx(120.0), height: rpx(120.0),),
                    Image.asset(
                      "images/tequan3.png", width: rpx(120.0), height: rpx(120.0),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "images/tequan4.png", width: rpx(120.0), height: rpx(120.0),),
                    Padding(padding: EdgeInsets.only(left: rpx(70.0))),
                    Image.asset(
                      "images/tequan5.png", width: rpx(120.0), height: rpx(120.0),),
                  ],
                ),
              ],
            ),
            SizedBox(height:rpx(155.0),),
            //第四条线
            Padding(
              padding: EdgeInsets.only(left:rpx(10.0), right: rpx(10.0)),
              child: Divider(
                color: Colors.black26,
              ),
            ),
            //底部购买栏
            Row(
              children: [
                Padding(padding: EdgeInsets.only(left: rpx(20.0))),
                Text("￥ 1 8 8",
                  style: TextStyle(fontSize: rpx(20.0), color: Colors.red),),
                Padding(padding: EdgeInsets.only(left: 25.0)),
                Text("原价388",style: TextStyle(color:Colors.black26,decoration: TextDecoration.lineThrough,fontSize: 12.0),),
                Padding(padding: EdgeInsets.only(left: 110)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      height: 30.0,
                        onPressed: (){},
                        child: Text("立即开通"),
                        textColor: Colors.white,
                      color: Colors.red,
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}