import 'package:boosic/Get/SearchController.dart';
import 'package:boosic/Service/book_service.dart';
import 'package:boosic/models/book_model.dart';
import 'package:boosic/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Query extends StatefulWidget {
  const Query({super.key});

  @override
  State<Query> createState() => _QueryState();
}

class _QueryState extends State<Query> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder<SearchListController>(builder: (controller) {
              return FutureBuilder(
                future:
                    BookService.query_google_api(controller.recentQuery.value),
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
                                            borderRadius:
                                                BorderRadius.circular(8.0),
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
                                              border: Border.all(
                                                  color: Colors.white),
                                              borderRadius: const BorderRadius
                                                  .all(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        SizedBox(
                                          width: width - 210,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: width - 280,
                                                height: 20,
                                                child: newbooks[index]
                                                        .author
                                                        .isEmpty
                                                    ? Container()
                                                    : Text(
                                                        newbooks[index]
                                                            .author
                                                            .first,
                                                        style: TextStructure
                                                            .bookAuthor,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                              ),
                                            ],
                                          ),
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
                                    offset: const Offset(0, 30),
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 235, 235, 235),
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
            }),
          ],
        ),
      ),
    );
  }
}
