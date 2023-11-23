import 'package:boosic/Book/header2.dart';
import 'package:boosic/Service/review_service.dart';
import 'package:boosic/models/book_model.dart';
import 'package:boosic/utils/read_m_icons.dart';
import 'package:boosic/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Volumes extends StatefulWidget {
  const Volumes({super.key});

  @override
  State<Volumes> createState() => _VolumesState();
}

class _VolumesState extends State<Volumes> {
  final GlobalKey _widgetKey = GlobalKey();

  ImagePicker picker = ImagePicker();
  XFile? image;

  @override
  void initState() {
    super.initState();
  }

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
        print(image!.path);
      });
    }
  }

  void openSnackbar() {
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
                      onTap: () {
                        sendImage(true);
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
    BookModel elem = Get.arguments['volumeInfo'] as BookModel;

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
          Container(
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
                            Text(elem.author.first,
                                style: TextStructure.volumeAuthor),
                            const SizedBox(width: 12),
                            Text(elem.author[1],
                                style: TextStructure.volumeAuthor),
                          ],
                        )
                      : elem.author.isNotEmpty
                          ? Text(elem.author.first,
                              style: TextStructure.volumeAuthor)
                          : Container(),
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
                    height: 170,
                  ),
                ],
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
                      onTap: () {},
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
                  openSnackbar();
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
              FutureBuilder(
                  future: ReviewService.reviews(elem.id),
                  builder: ((context, snapshot) {
                    return Container();
                  }))
            ],
          )
        ],
      ),
    );
  }
}
