// ignore_for_file: non_constant_identifier_names

class BookModel {
  final String id;
  final List<dynamic> author;
  final String title;
  final String language;
  String image_link = "";
  bool has_image_link = false;
  final String description;

  BookModel()
      : id = "",
        author = ["장원"],
        title = "teassedf",
        language = "en",
        description = "옛날옛날";

  BookModel.fromJson(Map<String, dynamic>? json)
      : id = json!["id"],
        author = json["volumeInfo"]["authors"] ?? [],
        title = json["volumeInfo"]["title"] ?? "",
        language = json["volumeInfo"]["language"] ?? "",
        description = json["volumeInfo"]["description"] ?? "" {
    if (json["volumeInfo"]["imageLinks"] != null) {
      image_link = json["volumeInfo"]["imageLinks"]["thumbnail"];
      has_image_link = true;
    }
  }
}
