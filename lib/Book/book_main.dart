import 'package:boosic/Book/header1.dart';
import 'package:boosic/Book/home_screen.dart';
import 'package:boosic/Book/query.dart';
import 'package:boosic/Get/PageIndexController.dart';
import 'package:boosic/Get/SearchController.dart';
import 'package:boosic/Music/music.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBook extends StatefulWidget {
  const MainBook({super.key});

  @override
  State<MainBook> createState() => _MainBookState();
}

class _MainBookState extends State<MainBook> {
  final List<Widget> _pages = [
    const HomeScreen(),
    const Query(),
    const MusicScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(SearchListController());
    Get.put(PageIndexController());

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80), child: Header1()),
      body: GetBuilder<PageIndexController>(
        builder: (controller) {
          return _pages[controller.selectedIndex];
        },
      ),
      bottomNavigationBar: Transform.translate(
        offset: const Offset(0, -5),
        child: BottomAppBar(
            shadowColor: Colors.transparent,
            shape: const CircularNotchedRectangle(),
            child: GetBuilder<PageIndexController>(builder: (controller) {
              return Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 238, 237, 237),
                  border: Border.all(color: Colors.white),
                  borderRadius:
                      const BorderRadius.all(Radius.circular(8.0) // POINT
                          ),
                ),
                height: 60,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.home),
                      onPressed: () {
                        controller.set_zero();
                      },
                    ),
                    const SizedBox(
                      width: 70,
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite),
                      onPressed: () {
                        controller.set_one();
                      },
                    ),
                    const SizedBox(
                      width: 70,
                    ),
                    IconButton(
                      icon: const Icon(Icons.person),
                      onPressed: () {
                        controller.set_two();
                      },
                    ),
                  ],
                ),
              );
            })),
      ),
    );
  }
}
