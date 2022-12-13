import 'package:flutter/material.dart';
import 'package:film_review/model/movie.dart';
import 'package:film_review/model/moviedan.dart';
import 'package:film_review/widgets/message/addbangdan.dart';
import 'package:film_review/widgets/message/yingdanxiangqing.dart';

class bangdan extends StatelessWidget {
  List<moviedan> bangdans;
  List<movie> movies;
  String session_id;
  String userid;
  bangdan({Key key, this.bangdans, this.movies, this.session_id,this.userid})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.only(top: 20, left: 30, right: 30),
          alignment: Alignment(0, 1),
          child: bangdanlist()),
    );
  }

  Widget bangdanlist() {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (index != bangdans.length)
          return wenbeng(context, index);
        else
          return Column(
            children: [
              SizedBox(
                height: 20,
              ),
              addbutton(context)
            ],
          );
      },
      itemCount: bangdans.length + 1,
    );
  }

  Widget wenbeng(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 30),
      decoration: BoxDecoration(
          border: new Border.all(
              width: 1, color: Color.fromARGB(255, 185, 180, 180))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("${bangdans[index].movielist_name}",
              //textDirection: TextDirection.ltr,
              style: TextStyle(color: Colors.black, fontSize: 15)),
          SizedBox(
            height: 5,
          ),
          getimage(bangdans[index], movies),
          SizedBox(
            height: 5,
          ),
          gerlabel(context, index)
        ],
      ),
    );
  }

  Widget addbutton(BuildContext context) {
    return Container(
      alignment: Alignment(0, -1),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Color.fromARGB(255, 151, 157, 164)),
        color: Color.fromARGB(255, 206, 206, 199),
        shape: BoxShape.rectangle,
      ),
      child: IconButton(
        iconSize: 70,
        icon: const Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => addbangdan(
                    session_id: session_id,
                  )));
        },
      ),
    );
  }

  Widget gerlabel(BuildContext context, int index) {
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
                      bangdan1: bangdans[index],
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

  Widget getimage(moviedan ans, List<movie> res) {
    int k1 = 0;
    int k2 = 0;
    for (int j = 0; j < movies.length; j++) {
      if (movies[j].movie_id.toString() == ans.movie_id[0].toString()) {
        k1 = j;

        print(k1);
      }
      if (movies[j].movie_id.toString() == ans.movie_id[1].toString()) {
        k2 = j;

        print(k2);
      }
    }
    String url = "images/${res[k1].movie_picture}";
    String url2 = "images/saohei.webp";
    String url3 = "images/${res[k2].movie_picture}";
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
