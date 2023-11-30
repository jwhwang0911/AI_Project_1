import 'dart:convert';

import 'package:boosic/Get/MusicLinkController.dart';
import 'package:boosic/Get/PageIndexController.dart';
import 'package:boosic/utils/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:boosic/Service/customIntercepter.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // 애니메이션 컨트롤러 초기화
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    // 애니메이션 반복 설정
    _controller.repeat(reverse: true);
  }

  Widget _buildVibratingImage() {
    // 이미지 위젯을 AnimatedBuilder로 감싸서 애니메이션 적용
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(10 * _controller.value, 0),
          child: Image.asset(
            'assets/images/logo.png',
            height: 150,
            width: 150,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*Get.toNamed('loading', arguments: {
            "title": elem.title,
                          "summary": elem.description,
                          'image_file': await MultipartFile.fromFile(
                            image!.path,
                          )
                        });*/
    //XFile? image;
    // BookModel elem = Get.arguments['volumeInfo'] as BookModel;
    String title = Get.arguments['title'];
    String summary = Get.arguments['summary'];
    MultipartFile multipartFile = Get.arguments['image_file'];

    return Scaffold(
      body: Center(
        child: GetBuilder<PageIndexController>(builder: (pagecontroller) {
          return GetBuilder<MusicLinkController>(
            builder: (controller) {
              Dio dio = Dio(BaseOptions(
                baseUrl: "https://api.readm.store",
                connectTimeout: Duration(seconds: 200),
                receiveTimeout: Duration(seconds: 200),
                sendTimeout: Duration(seconds: 200),
              ));

              dio.interceptors.add(
                custrom_interceptor,
              );

              var formdata = FormData.fromMap({
                "title": title,
                "summary": summary != "" ? summary : title,
                'image_file': multipartFile
              });

              dio.post("/ocr-music-url/", data: formdata).then((response) {
                Map<String, dynamic> temp = response.data;
                print(temp);
                controller.addAudio_List(temp["music"].toString());
                pagecontroller.setPageIndex(2);
                pagecontroller.setQeuryCalled();

                Get.back();
                Get.back();
              });

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildVibratingImage(),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Loading", style: TextStructure.title),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
