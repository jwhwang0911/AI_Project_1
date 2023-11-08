class BookModel {
  final String id;
  final List<dynamic> author;
  final String title;
  // ignore: non_constant_identifier_names
  final BookImageModel image_link;
  String description;

  BookModel.fromJson(Map<String, dynamic>? json)
      : id = json!["id"],
        image_link = json["volumeInfo"]["imageLinks"] ?? BookImageModel(),
        author = json["volumeInfo"]["authors"] ?? "",
        title = json["volumeInfo"]["title"] ?? "",
        description = json["volumeInfo"]["description"] ?? "";
}

class BookImageModel {
  final String thumbnail;

  BookImageModel() : thumbnail = "";

  BookImageModel.fromJson(Map<String, dynamic>? json) : thumbnail = "" ?? "";
}
