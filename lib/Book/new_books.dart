import 'package:boosic/Service/book_service.dart';
import 'package:boosic/models/book_model.dart';
import 'package:boosic/utils/text_style.dart';
import 'package:flutter/material.dart';

class NewBooks extends StatefulWidget {
  const NewBooks({super.key});

  @override
  State<NewBooks> createState() => _NewBooksState();
}

class _NewBooksState extends State<NewBooks> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: BookService.harrypotter(),
      builder: ((context, snapshot) {
        double imageHeight = 105;
        double imageWidth = 72;

        if (snapshot.data != null) {
          List<BookModel> newbooks = snapshot.data!;

          return Expanded(
            child: ListView.separated(
                padding: const EdgeInsets.only(top: 20),
                scrollDirection: Axis.vertical,
                itemBuilder: (((context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("${newbooks[index].title}");
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
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: 220,
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
                                Text(
                                  newbooks[index].author.first,
                                  style: TextStructure.bookAuthor,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.bookmark_outline),
                        onPressed: () {},
                      ),
                    ],
                  );
                })),
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 20,
                  );
                },
                itemCount: newbooks.length),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
