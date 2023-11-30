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

  // static Future<double> star(String id) async {
  //   final snapshot = db.collection("reviews").doc(id).get().then(
  //     (DocumentSnapshot doc) {
  //       final data = doc.data() as Map<String, dynamic>;

  //       return data["star"];
  //     }
  //   )
  // }
}
