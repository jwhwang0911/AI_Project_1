import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewService {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<List<String>> reviews(String id) async {
    List<String> temp = [];

    await db.collection("reviews").doc(id).get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        print(data);
      },
      onError: (e) => print("Error getting document: $e"),
    );

    return temp;
  }

  static Future<double> star(String id) async {
    late double star;

    await db.collection("reviews").doc(id).get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        star = data["star"];
        print(star);
      },
      onError: (e) {
        print("Error getting document: $e");
        star = 0.0;
      },
    );

    return star;
  }
}
