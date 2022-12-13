import 'package:film_review/model/book.dart';
import 'package:film_review/model/movie.dart';

class movielist {
  List<movie> movies;
  movielist({
    this.movies,
  });
  factory movielist.fromJson(List<dynamic> parsedJson) {
    List<movie> ms;

    ms = parsedJson.map((i) => movie.fromJson(i)).toList();
    return new movielist(
      movies: ms,
    );
  }
}
