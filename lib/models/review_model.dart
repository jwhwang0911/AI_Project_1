// ignore_for_file: non_constant_identifier_names

class BookModel {
  final String element;
  final double star;

  BookModel.fromJson(Map<String, dynamic>? json) 
  :element = json!["element"], 
  star = json["star"]; 
}
