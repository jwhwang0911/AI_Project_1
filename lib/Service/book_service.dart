import 'package:boosic/Service/customDio.dart';
import 'package:boosic/models/book_model.dart';
import 'package:dio/dio.dart';

class BookService {
  static Future<List<BookModel>> harrypotter() async {
    BasicAPI dio = BasicAPI();

    String harryGoogle =
        "https://www.googleapis.com/books/v1/volumes?q=%ED%95%B4%EB%A6%AC+%ED%8F%AC%ED%84%B0&maxResults=3";

    Response response = await dio.GET(path: harryGoogle);

    List<BookModel> temp = [];

    for (var elem in response.data['items']) {
      temp.add(BookModel.fromJson(elem));
    }

    return temp;
  }
}
