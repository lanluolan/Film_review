import 'package:flutter/material.dart';

class ThemePage extends StatefulWidget{
  @override
  ThemePageState createState() {
    return ThemePageState();
  }
}

class ThemePageState extends State<ThemePage> {
  Widget build(BuildContext context){
   return Scaffold(
     appBar:AppBar(
       title: Text("主题活动",style: TextStyle(color: Colors.white),),
       centerTitle: true,
     ),
     body: Column(
       children: [
          Image.asset("images/15721c7b3e0b031e744e464f32e48e3.png",fit: BoxFit.fill,)
       ],
     ),
   );
  }
}