import 'package:boosic/Book/new_books.dart';
import 'package:boosic/Book/popular_books.dart';
import 'package:boosic/utils/text_style.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
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
