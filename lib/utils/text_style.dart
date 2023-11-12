import 'package:flutter/material.dart';

class TextStructure {
  static TextStyle header = const TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: 'PoppinsRegular');

  static TextStyle title = const TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: 'PoppinsSemiBold');

  static TextStyle bookTitle = const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: "PoppinsRegular");

  static TextStyle bookAuthor = const TextStyle(
      color: Color.fromARGB(255, 110, 110, 110),
      fontSize: 12,
      fontWeight: FontWeight.w500,
      fontFamily: "PoppinsRegular");
}
