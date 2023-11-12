import 'package:boosic/Book/header1.dart';
import 'package:boosic/Book/new_books.dart';
import 'package:boosic/Book/popular_books.dart';
import 'package:boosic/utils/text_style.dart';
import 'package:flutter/material.dart';

class MainBook extends StatelessWidget {
  const MainBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 80, 0, 63),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header1(),
            const SizedBox(height: 40),
            Text("Popular Books", style: TextStructure.title),
            const SizedBox(height: 20),
            const PopularBook(),
            Text("Newest", style: TextStructure.title),
            const NewBooks(),
          ],
        ),
      ),
    );
  }
}
