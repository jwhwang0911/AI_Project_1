import 'package:boosic/Service/book_service.dart';
import 'package:boosic/models/book_model.dart';
import 'package:boosic/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewBooks extends StatefulWidget {
  const NewBooks({super.key});

  @override
  State<NewBooks> createState() => _NewBooksState();
}

class _NewBooksState extends State<NewBooks> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return FutureBuilder(
      future: BookService.query_google_api("해리 포터"),
      builder: ((context, snapshot) {
        double imageHeight = 110;
        double imageWidth = 90;

        if (snapshot.data != null) {
          List<BookModel> newbooks = snapshot.data!;

          return ListView.separated(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.only(top: 20),
              scrollDirection: Axis.vertical,
              itemBuilder: (((context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/volumes', arguments: {
                          "volumeInfo": newbooks[index],
                        });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          newbooks[index].has_image_link
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    newbooks[index].image_link,
                                    height: imageHeight,
                                    width: imageWidth,
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 238, 237, 237),
                                    border: Border.all(color: Colors.white),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8.0) // POINT
                                        ),
                                  ),
                                  height: imageHeight,
                                  width: imageWidth,
                                  child: Image.asset(
                                    'assets/images/logo_black.png',
                                  )),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: width - 210,
                                height: 20,
                                child: Text(
                                  newbooks[index].title,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStructure.bookTitle,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: width - 210,
                                    height: 20,
                                    child: Text(
                                      newbooks[index].author.isEmpty
                                          ? Container()
                                          : newbooks[index].author.first,
                                      style: TextStructure.bookAuthor,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.bookmark_outline),
                          onPressed: () {},
                        ),
                        Transform.translate(
                          offset: const Offset(-5, 15),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 235, 235, 235),
                              border: Border.all(color: Colors.white),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(8.0) // POINT
                                  ),
                            ),
                            width: 30,
                            child: Text(
                              newbooks[index].language,
                              style: TextStructure.bookAuthor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                );
              })),
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 20,
                );
              },
              itemCount: newbooks.length);
        } else {
          return Container();
        }
      }),
    );
  }
}
