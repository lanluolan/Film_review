import 'package:flutter/material.dart';
import 'package:film_review/model/book.dart';
import 'package:film_review/model/movie.dart';

List<book> searchbooks = [];
List<movie> searchmovies = [];
TextEditingController emailController =
new TextEditingController(); //声明controller
bool judge(List<book> ans, book a) {
  for (int i = 0; i < ans.length; i++) {
    // print("${ans[i]} ${a}");

    if (ans[i].book_id.toString() == a.book_id.toString()) {
      return false;
    }
  }
  return true;
}

class SearchPage extends StatefulWidget {
  int type;
  List<book> books = [];
  SearchPage({Key key, this.type, this.books}) : super(key: key);
  @override
  SearchPageState createState() => new SearchPageState(type, books);
}

class SearchPageState extends State<SearchPage> {
  int type;
  List<book> books = [];
  SearchPageState(this.type, this.books);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The search area here
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                onChanged: ((value) {
                  print("搜索");
                  List<book> lishi = [];
                  if (type == 0) //搜书
                      {
                    for (int i = 0; i < books.length; i++) {
                      if (books[i].book_name.contains(emailController.text)) {
                        if (judge(lishi, books[i])) {
                          lishi.add(books[i]);
                          print("添加书籍");
                        }
                      }
                    }
                  } else //搜电影
                      {}

                  searchbooks = lishi;
                  print(searchbooks.length);
                }),
                controller: emailController,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        searchbooks.clear();
                        emailController.text = "";
                        /* Clear the search field */
                      },
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none),
              ),
            ),
          )),
      body: Column(children: [ListSearch()]),
    );
  }
}

Widget ListSearch() {
  return new Expanded(
    child: new ListView.builder(
      padding: const EdgeInsets.all(16.0), // 设置padding
      itemBuilder: (context, index) {
        return ListItem(searchbooks[index]);
      },
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: searchbooks.length,
    ),
  );
}

Widget ListItem(book b1) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
        border:
        new Border.all(width: 1, color: Color.fromARGB(255, 79, 78, 78))),
    child: Row(
      children: [
        Image(
          image: AssetImage("images/${b1.book_picture}"),
          height: 80,
        ),
        Text("${b1.book_name}")
      ],
    ),
  );
}
