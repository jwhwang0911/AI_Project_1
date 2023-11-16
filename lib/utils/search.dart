import 'package:boosic/Get/PageIndexController.dart';
import 'package:boosic/Get/SearchController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Get.back();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return GetBuilder<PageIndexController>(builder: (cont) {
      return GetBuilder<SearchListController>(
        builder: (controller) {
          controller.add(query);
          Future.delayed(const Duration(milliseconds: 5), () {
            cont.set_one();

            Get.toNamed(
              "/",
            );
          });

          return Container();
        },
      );
    });
  }

  Search()
      : super(
          searchFieldLabel: "검색어를 입력해주세요",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  @override
  Widget buildSuggestions(BuildContext context) {
    return GetBuilder<SearchListController>(
      builder: (controller) {
        return ListView.builder(
          itemCount: controller.recentList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                controller.recentList[controller.recentList.length - 1 - index],
              ),
              leading: query.isEmpty
                  ? const Icon(Icons.access_time)
                  : const SizedBox(),
              onTap: () {
                query = controller
                    .recentList[controller.recentList.length - 1 - index];
                showResults(context);
              },
            );
          },
        );
      },
    );
  }
}
