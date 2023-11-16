import 'package:boosic/Service/customDio.dart';
import 'package:boosic/models/book_model.dart';
import 'package:dio/dio.dart';

class BookService {
  static Future<List<BookModel>> query_google_api(String query) async {
    BasicAPI dio = BasicAPI();

    String apiCall =
        "https://www.googleapis.com/books/v1/volumes?q=$query&maxResults=40";

    Response response = await dio.GET(path: apiCall);

    List<BookModel> temp = [];

    for (var elem in response.data['items']) {
      temp.add(BookModel.fromJson(elem));
    }

    return temp;
  }
}
