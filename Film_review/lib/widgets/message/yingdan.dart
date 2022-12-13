import 'package:flutter/material.dart';
import 'package:film_review/model/movie.dart';
import 'package:film_review/model/moviedan.dart';
import 'package:film_review/widgets/message/addbangdan.dart';
import 'package:film_review/widgets/message/yingdanxiangqing.dart';

class yingdan extends StatelessWidget {
  moviedan m1;
  List<movie> movies;
  String session_id;
  String userid;
  yingdan({Key key, this.m1, this.movies, this.session_id,this.userid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border:
              new Border.all(width: 1, color: Color.fromARGB(255, 79, 78, 78))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        wenbeng(context),
      ]),
    );
  }

  Widget wenbeng(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("${m1.movielist_name}",
            //textDirection: TextDirection.ltr,
            style: TextStyle(color: Colors.black, fontSize: 15)),
        SizedBox(
          height: 5,
        ),
        getimage(),
        SizedBox(
          height: 5,
        ),
        gerlabel(context)
      ],
    );
  }

  Widget gerlabel(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Spacer(),
        RawChip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => yingdanxiangqing(
                      bangdan1: m1,
                      movies: movies,
                      session_id: session_id,
                  userid: userid,
                    )));
          },
          label: Text(
            "更多",
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          backgroundColor: Color.fromARGB(255, 121, 170, 230),
        )
      ],
    );
  }

  Widget getimage() {
    int k1 = 0;
    int k2 = 0;
    for (int j = 0; j < movies.length; j++) {
      if (movies[j].movie_id.toString() == m1.movie_id[0].toString()) {
        k1 = j;

        print(k1);
      }
      if (movies[j].movie_id.toString() == m1.movie_id[1].toString()) {
        k2 = j;

        print(k2);
      }
    }
    String url = "images/${movies[k1].movie_picture}";
    String url2 = "images/saohei.webp";
    String url3 = "images/${movies[k2].movie_picture}";
    String url4 = "images/saohei.webp";
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            height: 120,
            width: 80,
            child: Image.asset(
              url == "images/" ? url2 : url,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            height: 120,
            width: 80,
            child: Image.asset(
              url3 == "images/" ? url4 : url3,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
