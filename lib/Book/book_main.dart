import 'package:boosic/Book/header1.dart';
import 'package:boosic/Book/home_screen.dart';
import 'package:boosic/Book/query.dart';
import 'package:boosic/Get/PageIndexController.dart';
import 'package:boosic/Get/SearchController.dart';
import 'package:boosic/Music/music.dart';
import 'package:boosic/utils/read_m_icons.dart';
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

  PageController pageController = PageController();

  void _onItemTapped(int index) {
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    Get.put(SearchListController());
    Get.put(PageIndexController());

    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(80), child: Header1()),
        body: GetBuilder<PageIndexController>(
          builder: (controller) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (controller.query_called) {
                _onItemTapped(controller.selectedIndex);
                controller.setQeuryCalled();
              }
            });
            return PageView(
              controller: pageController,
              onPageChanged: controller.setPageIndex,
              children: _pages,
            );
            // return _pages[controller.selectedIndex];
          },
        ),
        bottomNavigationBar: Transform.translate(
          offset: const Offset(0, -20),
          child:
              GetBuilder<PageIndexController>(builder: (pageindexcontroller) {
            return Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              decoration: BoxDecoration(
                boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 94, 94, 94)
                            .withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
              ),
              height: 72,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: BottomNavigationBar(
                  currentIndex: pageindexcontroller.selectedIndex,
                  onTap: _onItemTapped,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search_rounded),
                      label: "Search",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(ReadMIcons.music),
                      label: "Music",
                    ),
                  ],
                ),
              ),
            );
          }),
        ));
  }
}
