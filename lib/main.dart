import 'package:boosic/Book/book_main.dart';
import 'package:boosic/Book/volumes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);

    return GetMaterialApp(
      title: 'Boosic',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const MainBook()),
        GetPage(name: '/volumes', page: () => const Volumes())
      ],
    );
  }
}
