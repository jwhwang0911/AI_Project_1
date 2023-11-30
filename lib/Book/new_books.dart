import 'package:boosic/Service/book_service.dart';
import 'package:boosic/models/book_model.dart';
import 'package:boosic/utils/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
      future: BookService.query_google_api("반지의 제왕"),
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
                        print(newbooks[index].id);
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
                              FutureBuilder(
                                future: FirebaseFirestore.instance
                                    .collection("reviews")
                                    .doc(newbooks[index].id)
                                    .get()
                                    .then((DocumentSnapshot doc) {
                                  final data =
                                      doc.data() as Map<String, dynamic>;

                                  return data["star"];
                                }),
                                builder: (context, snapshot) {
                                  if (snapshot.data != null) {
                                    double temp = snapshot.data.toDouble();
                                    return StarRating(temp, false, 20);
                                  } else {
                                    return StarRating(0.0, false, 20);
                                  }
                                },
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

// ignore: must_be_immutable
class StarRating extends StatefulWidget {
  late double score;
  late bool isSelected;
  late double itemSize;

  StarRating(this.score, this.isSelected, this.itemSize, {super.key});

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      ignoreGestures: !widget.isSelected,
      initialRating: widget.score,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: widget.itemSize,
      itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star_rounded,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        if (widget.isSelected) {
          setState(() {
            widget.score = rating;
          });
        }
      },
    );
  }
}
