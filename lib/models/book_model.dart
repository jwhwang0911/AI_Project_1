// ignore_for_file: non_constant_identifier_names

class BookModel {
  late String id;
  late List<dynamic> author;
  late String title;
  late String language;
  String image_link = "";
  bool has_image_link = false;
  late String description;

  BookModel() {
    id = "else";
    author = [];
    title = "";
    language = "";
    description = "";
  }

  BookModel.fromJson(Map<String, dynamic>? json)
      : id = json!["id"],
        author = json["volumeInfo"]["authors"] ?? [],
        title = json["volumeInfo"]["title"] ?? "",
        language = json["volumeInfo"]["language"] ?? "",
        description = json["volumeInfo"]["description"] ??
            ""
                "" {
    if (json["volumeInfo"]["imageLinks"] != null) {
      image_link = json["volumeInfo"]["imageLinks"]["thumbnail"];
      has_image_link = true;
    }
  }
}
