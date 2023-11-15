import 'package:boosic/Book/new_books.dart';
import 'package:boosic/Book/popular_books.dart';
import 'package:boosic/Get/SearchController.dart';
import 'package:boosic/utils/search.dart';
import 'package:boosic/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBook extends StatefulWidget {
  MainBook({super.key});

  @override
  State<MainBook> createState() => _MainBookState();
}

class _MainBookState extends State<MainBook> {
  @override
  Widget build(BuildContext context) {
    Get.put(SearchListController());

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        title: Container(
          constraints: const BoxConstraints(
            maxHeight: 100,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(
                    width: 23,
                  ),
                  Text(
                    "Hi, Dustin",
                    style: TextStructure.header,
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search());
            },
            icon: const Icon(
              Icons.search,
              size: 30,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 63),
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
      ),
    );
  }
}
