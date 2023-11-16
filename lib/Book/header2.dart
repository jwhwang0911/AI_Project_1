import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Header2 extends StatefulWidget {
  const Header2({super.key});

  @override
  State<Header2> createState() => _Header2State();
}

class _Header2State extends State<Header2> {
  @override
  Widget build(BuildContext context) {
    // return const Placeholder(
    //   fallbackHeight: 90,
    // );
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 100,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Get.toNamed("/");
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              size: 24,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.bookmark_border_rounded,
                  size: 26,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  size: 26,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
