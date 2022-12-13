import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:film_review/model/movie.dart';
import 'package:film_review/model/moviedan.dart';
import 'package:film_review/model/movielist.dart';
import 'package:film_review/model/watch.dart';
import 'package:film_review/model/watchlist.dart';
import 'package:film_review/widgets/message/dianying.dart';
import 'timelinerItem.dart';
import 'package:film_review/model/texticon.dart';
/*
movie list = movie(
    movie_id: "1",
    movie_name: "扫黑除恶",
    director: "1",
    scriptwriter: "1",
    main_performer: "1",
    language: "1",
    movie_type: "1",
    producer_country: "1",
    description: "1");*/

class shijianzhou extends StatelessWidget {
  List<movie> movies;
  List<watch> watchs;
  List<moviedan> yingdans = [];
  String session_id;
  String userid;
  shijianzhou(
      {Key key, this.movies, this.watchs, this.yingdans, this.session_id,this.userid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int cnt = movies.length;
    return   ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _buildItem(context, index);
            },
            itemCount: cnt + 1,

       )  ;
  }

  Widget _buildItem(BuildContext context, int i) {
    return SingleChildScrollView(
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(border: BorderTimeLine(i)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                  //   Divider(color: Colors.grey.shade300, thickness: 40),
                  if (i == 0)
                    Center(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: TextIconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => dianying(
                                      session_id: session_id,
                                  userid: userid,
                                    )));
                          },
                          textSpanText: "添加已看电影",
                          icon: Icons.add,
                          iconColor: Color.fromARGB(137, 32, 72, 183),
                        ),
                      ),
                    ),

                  if (i != 0)
                    MovieListItem(movies[i - 1], watchs[i - 1], movies,
                        yingdans, session_id,userid),

                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                ]),
          )),
    );
  }
}

class BorderTimeLine extends BorderDirectional {
  int position;

  BorderTimeLine(this.position);

  double radius = 10;
  double margin = 20;
  Paint _paint = Paint()
    ..color = Color(0xFFDDDDDD)
    ..strokeWidth = 1;

  @override
  void paint(Canvas canvas, Rect rect,
      {TextDirection textDirection,
      BoxShape shape = BoxShape.rectangle,
      BorderRadius borderRadius}) {
    if (position != 0) {
      canvas.drawLine(Offset(rect.left + margin + radius / 2, rect.top),
          Offset(rect.left + margin + radius / 2, rect.bottom), _strokePaint());
      canvas.drawCircle(
          Offset(rect.left + margin + radius / 2, rect.top + radius * 2),
          radius,
          _fillPaint());
      canvas.drawCircle(
          Offset(rect.left + margin + radius / 2, rect.top + radius * 2),
          radius,
          _strokePaint());
    } else {
      canvas.drawLine(
          Offset(rect.left + margin + radius / 2, rect.top + radius * 2),
          Offset(rect.left + margin + radius / 2, rect.bottom),
          _strokePaint());
      canvas.drawCircle(
          Offset(rect.left + margin + radius / 2, rect.top + radius * 2),
          radius,
          _fillPaint());
      canvas.drawCircle(
          Offset(rect.left + margin + radius / 2, rect.top + radius * 2),
          radius,
          _strokePaint());
      canvas.drawCircle(
          Offset(rect.left + margin + radius / 2, rect.top + radius * 2),
          radius / 2,
          _strokePaint());
    }
  }

  Paint _fillPaint() {
    _paint.color = Color.fromARGB(255, 13, 111, 192);
    _paint.style = PaintingStyle.fill;
    return _paint;
  }

  Paint _strokePaint() {
    _paint.color = Color.fromARGB(255, 13, 111, 192);
    _paint.style = PaintingStyle.stroke;
    return _paint;
  }
}
