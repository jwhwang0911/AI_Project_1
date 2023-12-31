import 'package:boosic/utils/search.dart';
import 'package:boosic/utils/text_style.dart';
import 'package:flutter/material.dart';

class Header1 extends StatefulWidget {
  const Header1({super.key});

  @override
  State<Header1> createState() => _Header1State();
}

class _Header1State extends State<Header1> {
  @override
  Widget build(BuildContext context) {
    // return const Placeholder(
    //   fallbackHeight: 90,
    // );
    return AppBar(
      automaticallyImplyLeading: false,
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
                  "Hi, ReadM",
                  style: TextStructure.header,
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Search());
              },
              icon: const Icon(
                Icons.search,
                size: 30,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        )
      ],
    );
  }
}
