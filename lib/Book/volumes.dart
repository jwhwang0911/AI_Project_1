import 'package:boosic/Book/header2.dart';
import 'package:boosic/Book/new_books.dart';
import 'package:boosic/models/book_model.dart';
import 'package:boosic/models/review_model.dart';
import 'package:boosic/utils/read_m_icons.dart';
import 'package:boosic/utils/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';

class Volumes extends StatefulWidget {
  const Volumes({super.key});

  @override
  State<Volumes> createState() => _VolumesState();
}

class _VolumesState extends State<Volumes> {
  final GlobalKey _widgetKey = GlobalKey();
  final GlobalKey _widgetKey2 = GlobalKey();

  FocusNode _focusNode = FocusNode();
  bool _isKeyboardOpen = false;

  ImagePicker picker = ImagePicker();
  XFile? image;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _isKeyboardOpen = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    // FocusNode 메모리 누수 방지를 위해 dispose에서 포커스 제거
    _focusNode.dispose();
    super.dispose();
  }

  final myController = TextEditingController();

  Future<void> sendImage(bool isCamera) async {
    Get.back();
    final img = await picker.pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
      maxHeight: 75,
      maxWidth: 75,
      imageQuality: 30,
    );

    if (img != null) {
      setState(() {
        image = img;
      });
    }
  }

  void openSnackbar(BookModel elem) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Image.asset("assets/images/Skeleton.jpg"),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 319,
                  child: Text(
                      'Take a picture of the page where you like the most ! AI will recommend the song that best suits the book.',
                      style: TextStructure.volumeAuthor),
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await sendImage(true);

                        await Get.toNamed('loading', arguments: {
                          "title": elem.title,
                          "summary": elem.description,
                          'image_file': await MultipartFile.fromFile(
                            image!.path,
                          )
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 94, 94, 94)
                                  .withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          color: Colors.black,
                          border: Border.all(color: Colors.white),
                          borderRadius: const BorderRadius.all(
                              Radius.circular(20.0) // POINT
                              ),
                        ),
                        width: 150,
                        height: 66,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              ReadMIcons.camera,
                              color: Colors.white,
                              size: 32,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Picture",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "PoppinsRegular"),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        sendImage(false);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 94, 94, 94)
                                  .withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          color: Colors.black,
                          border: Border.all(color: Colors.white),
                          borderRadius: const BorderRadius.all(
                              Radius.circular(20.0) // POINT
                              ),
                        ),
                        width: 150,
                        height: 66,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_search,
                              color: Colors.white,
                              size: 32,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Gallery",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "PoppinsRegular"),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    BookModel elem = Get.arguments['volumeInfo'] ?? BookModel();

    double imageHeight = 284;
    double imageWidth = 194;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Header2(),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          GestureDetector(
            onTap: () {
              _focusNode.unfocus();
            },
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                                Text(
                                  "${elem.author.first}\n${elem.author[1]}",
                                  style: TextStructure.volumeAuthor,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(width: 12),
                              ],
                            )
                          : elem.author.isNotEmpty
                              ? Text(elem.author.first,
                                  style: TextStructure.volumeAuthor)
                              : Container(),
                      FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection("reviews")
                            .doc(elem.id)
                            .get()
                            .then((DocumentSnapshot doc) {
                          final data = doc.data() as Map<String, dynamic>;

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
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        key: _widgetKey,
                        child: elem.description != ""
                            ? Text(
                                elem.description,
                                style: TextStructure.volumeAuthor,
                              )
                            : Container(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        key: _widgetKey2,
                        height: MediaQuery.of(context).size.height,
                        child: FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection("reviews")
                              .doc(elem.id)
                              .get()
                              .then((DocumentSnapshot doc) {
                            final data = doc.data() as Map<String, dynamic>;

                            return data;
                          }),
                          builder: (context, snapshot) {
                            if (snapshot.data != null) {
                              List<ReviewModel> review = [];

                              for (var elem in snapshot.data!["reviews"]) {
                                review.add(ReviewModel.fromJson(elem));
                              }

                              return Column(
                                children: [
                                  TextField(
                                    focusNode: _focusNode,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Review 작성',
                                    ),
                                    controller: myController,
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      review.add(
                                          ReviewModel(myController.text, 0));

                                      List<Map<String, dynamic>> json = [];

                                      double totalScore = 0.0;

                                      for (ReviewModel js in review) {
                                        json.add({
                                          "element": js.element,
                                          "star": js.star
                                        });
                                        totalScore = totalScore +
                                            js.star / review.length;
                                      }

                                      await FirebaseFirestore.instance
                                          .collection("reviews")
                                          .doc(elem.id)
                                          .set({
                                        "reviews": json,
                                        "star": totalScore
                                      });
                                    },
                                    child: const Text("제출"),
                                  ),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    padding: const EdgeInsets.only(top: 20),
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("익명"),
                                          StarRating(
                                              review[index].star, false, 20),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(review[index].element),
                                        ],
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const Divider();
                                    },
                                    itemCount: review.length,
                                  )
                                ],
                              );
                            } else {
                              List<ReviewModel> review = [];
                              return Column(
                                children: [
                                  TextField(
                                    focusNode: _focusNode,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Review 작성',
                                    ),
                                    controller: myController,
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      review.add(
                                          ReviewModel(myController.text, 0));

                                      List<Map<String, dynamic>> json = [];

                                      double totalScore = 0.0;

                                      for (ReviewModel js in review) {
                                        json.add({
                                          "element": js.element,
                                          "star": js.star
                                        });
                                        totalScore = totalScore +
                                            js.star / review.length;
                                      }

                                      await FirebaseFirestore.instance
                                          .collection("reviews")
                                          .doc(elem.id)
                                          .set({
                                        "reviews": json,
                                        "star": totalScore
                                      });
                                    },
                                    child: const Text("제출"),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 170,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                width: 320,
                height: 44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Scrollable.ensureVisible(_widgetKey.currentContext!,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            alignment: 0);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 94, 94, 94)
                                  .withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 32,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(color: Colors.white),
                          borderRadius: const BorderRadius.all(
                              Radius.circular(8.0) // POINT
                              ),
                        ),
                        width: 154,
                        height: 44,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              ReadMIcons.preview,
                              color: Colors.black,
                              size: 24,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Preview",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "PoppinsRegular"),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Scrollable.ensureVisible(_widgetKey2.currentContext!,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            alignment: 0);
                      },
                      child: Container(
                        width: 154,
                        height: 44,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 94, 94, 94)
                                  .withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 32,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          color: Colors.white,
                          border: Border.all(color: Colors.white),
                          borderRadius: const BorderRadius.all(
                              Radius.circular(8.0) // POINT
                              ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              ReadMIcons.review,
                              color: Colors.black,
                              size: 24,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Review",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "PoppinsRegular"),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  _isKeyboardOpen ? null : openSnackbar(elem);
                },
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 94, 94, 94)
                            .withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    color: Colors.black,
                    border: Border.all(color: Colors.white),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(20.0) // POINT
                            ),
                  ),
                  width: 335,
                  height: 66,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        ReadMIcons.music_add,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "READM Start",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: "PoppinsRegular"),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          )
        ],
      ),
    );
  }
}
