// ignore_for_file: non_constant_identifier_names

class BookModel {
  final String id;
  final List<dynamic> author;
  final String title;
  String image_link = "";
  bool has_image_link = false;
  final String description;

  BookModel.fromJson(Map<String, dynamic>? json)
      : id = json!["id"],
        author = json["volumeInfo"]["authors"] ?? [],
        title = json["volumeInfo"]["title"] ?? "",
        description = json["volumeInfo"]["description"] ?? "" {
    if (json["volumeInfo"]["imageLinks"] != null) {
      image_link = json["volumeInfo"]["imageLinks"]["thumbnail"];
      has_image_link = true;
    }
  }
}
