// ignore_for_file: non_constant_identifier_names

class ReviewModel {
  late String element;
  late double star;

  ReviewModel(String elem, double st) {
    element = elem;
    star = st;
  }

  ReviewModel.fromJson(Map<String, dynamic>? json)
      : element = json!["element"],
        star = json["star"].toDouble();
}
