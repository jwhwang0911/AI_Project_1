import 'package:boosic/Service/book_service.dart';
import 'package:boosic/models/book_model.dart';
import 'package:boosic/utils/text_style.dart';
import 'package:flutter/material.dart';

class PopularBook extends StatefulWidget {
  const PopularBook({super.key});

  @override
  State<PopularBook> createState() => _PopularBookState();
}

class _PopularBookState extends State<PopularBook> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: BookService.loard_of_the_Rings(),
      builder: ((context, snapshot) {
        double imageHeight = 192;
        double imageWidth = 131;

        if (snapshot.data != null) {
          List<BookModel> popularBook = snapshot.data!;

          return Expanded(
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (((context, index) {
                  return GestureDetector(
                    onTap: () {
                      print("${popularBook[index].title}");
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        popularBook[index].has_image_link
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  popularBook[index].image_link,
                                  height: imageHeight,
                                  width: imageWidth,
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 238, 237, 237),
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
                          height: 20,
                        ),
                        SizedBox(
                          width: imageWidth,
                          height: 20,
                          child: Text(
                            popularBook[index].title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStructure.bookTitle,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          popularBook[index].author.first,
                          style: TextStructure.bookAuthor,
                        )
                      ],
                    ),
                  );
                })),
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 24,
                  );
                },
                itemCount: popularBook.length),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
