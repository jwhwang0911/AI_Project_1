import 'package:boosic/Book/header2.dart';
import 'package:boosic/models/book_model.dart';
import 'package:boosic/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Volumes extends StatefulWidget {
  const Volumes({super.key});

  @override
  State<Volumes> createState() => _VolumesState();
}

class _VolumesState extends State<Volumes> {
  @override
  Widget build(BuildContext context) {
    BookModel elem = Get.arguments['volumeInfo'] as BookModel;

    double imageHeight = 284;
    double imageWidth = 194;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 80, 20, 63),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Header2(),
              const SizedBox(
                height: 40,
              ),
              elem.has_image_link
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        elem.image_link,
                        scale: 0.65,
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 238, 237, 237),
                        border: Border.all(color: Colors.white),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0) // POINT
                                ),
                      ),
                      height: imageHeight,
                      width: imageWidth,
                      child: Image.asset(
                        'assets/images/logo_black.png',
                      )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 300,
                child: Text(
                  elem.title,
                  style: TextStructure.volumeTitle,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              elem.author.length > 1
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(elem.author.first,
                            style: TextStructure.volumeAuthor),
                        const SizedBox(width: 12),
                        Text(elem.author[1], style: TextStructure.volumeAuthor),
                      ],
                    )
                  : Text(elem.author.first, style: TextStructure.volumeAuthor),
              const SizedBox(
                height: 20,
              ),
              Text(
                elem.description,
                style: TextStructure.volumeAuthor,
              ),
              const SizedBox(
                height: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
