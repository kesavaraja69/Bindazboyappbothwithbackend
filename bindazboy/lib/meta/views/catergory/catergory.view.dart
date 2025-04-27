import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/meta/views/catergory/components/catergorybloglistview.dart';
import 'package:flutter/material.dart';
import 'components/catergoryList.dart';

class CatergoryView extends StatefulWidget {
  const CatergoryView({super.key});

  @override
  _CatergoryViewState createState() => _CatergoryViewState();
}

class _CatergoryViewState extends State<CatergoryView> {
  var selected = 1;
  dynamic catergorytitle = "வழிபாடு";
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BConstantColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Catergory",
                    style: TextStyle(
                      color: BConstantColors.appbartitleColor,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            CatergoryList(
              callback: (int index, dynamic title) {
                setState(() {
                  selected = index;
                  catergorytitle = title;
                  print("fristpage is $selected");
                  print("Title is $title");
                });
                //pageController.jumpToPage(index);
              },
              selected: selected,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.78,
              child: CatergoryBloglistView(
                callback: (int index) {
                  setState(() {
                    selected = index;
                    print(selected);
                  });
                },
                selected: selected,
                pageController: pageController,
                catergorytitle: catergorytitle,
              ),
            ),
            // Expanded(
            //   child: CatergoryBloglistView(
            //     callback: (int index) {
            //       setState(() {
            //         selected = index;
            //         print(selected);
            //       });
            //     },
            //     selected: selected,
            //     pageController: pageController,
            //     catergorytitle: catergorytitle,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
