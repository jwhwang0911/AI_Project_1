import 'package:boosic/Service/book_service.dart';
import 'package:boosic/models/book_model.dart';
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
      future: BookService.harrypotter(),
      builder: ((context, snapshot) {
        if (snapshot.data != null) {
          List<BookModel> popularBook = snapshot.data!;

          return Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (((context, index) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        // Image.network(popularBook[index].image_link),
                        Text(popularBook[index].title),
                      ],
                    ),
                  );
                })),
                itemCount: popularBook.length),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
