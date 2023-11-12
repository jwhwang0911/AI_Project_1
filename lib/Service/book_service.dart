import 'package:boosic/Service/customDio.dart';
import 'package:boosic/models/book_model.dart';
import 'package:dio/dio.dart';

class BookService {
  static Future<List<BookModel>> harrypotter() async {
    BasicAPI dio = BasicAPI();

    String harryGoogle =
        "https://www.googleapis.com/books/v1/volumes?q=harry+potter&maxResults=10";
    Response response = await dio.GET(path: harryGoogle);

    List<BookModel> temp = [];

    // print(response.data['items'][2]['volumeInfo']);

    for (var elem in response.data['items']) {
      temp.add(BookModel.fromJson(elem));
    }
    // temp.add(BookModel.fromJson(response.data['items'][2]));

    return temp;
  }

  static Future<List<BookModel>> loard_of_the_Rings() async {
    BasicAPI dio = BasicAPI();

    String harryGoogle =
        "https://www.googleapis.com/books/v1/volumes?q=%EB%B0%98%EC%A7%80%EC%9D%98_%EC%A0%9C%EC%99%95&maxResults=10";

    Response response = await dio.GET(path: harryGoogle);

    List<BookModel> temp = [];

    // print(response.data['items'][2]['volumeInfo']);

    for (var elem in response.data['items']) {
      temp.add(BookModel.fromJson(elem));
    }
    // temp.add(BookModel.fromJson(response.data['items'][2]));

    return temp;
  }
}
