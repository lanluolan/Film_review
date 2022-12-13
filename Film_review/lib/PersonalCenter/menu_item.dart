import 'package:film_review/rpx.dart';
import 'package:flutter/material.dart';

class MenuItems extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;
  MenuItems({Key key,this.icon, this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onPressed,
      child:  Column(
        children: <Widget>[
          Padding(
              padding:EdgeInsets.only(
                left:rpx(20.0),
                top:rpx(12.0),
                right: rpx(20.0),
                bottom: rpx(10.0),
              ),
              child: Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(
                      right: rpx(8.0),
                    ),
                    child:Icon(
                      icon,
                      color: Colors.black54,
                    ),
                  ),
                  Expanded(
                      child: Text(
                        title,
                        style: TextStyle(color: Colors.black54,fontSize: rpx(16.0)),
                      )
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  )
                ],
              )
          ),
          Padding(padding: EdgeInsets.only(left: rpx(20.0),right: rpx(20.0)),
            child: Divider(
              color: Colors.black12,
            ),
          )
        ],
      ),
    );
  }
}
