import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/core/services/local_notification_service.dart';
import 'package:bindazboy/meta/views/bookmark/bookmark.view.dart';
import 'package:bindazboy/meta/views/catergory/catergory.view.dart';
import 'package:bindazboy/meta/views/home/components/homeblog.view.dart';
import 'package:bindazboy/meta/views/home/components/navigationdrawer.view.dart';
import 'package:bindazboy/meta/views/searchpage/search.view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();

    LocalNotificationService.initialize(context);

    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {});
    FirebaseMessaging.instance.subscribeToTopic("bindazboy");

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
      }
      LocalNotificationService.display(message);
    });

    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // final routeFromMessage = message.data["route"];
      //  Navigator.of(context).pushNamed(routeFromMessage);
    });
  }

  int _index = 0;
  List<IconData> data = [
    Icons.home_filled,
    Icons.category_sharp,
    Icons.bookmark,
    Icons.search_outlined
  ];
  final PageController _pageController = new PageController();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BConstantColors.backgroundColor,
      drawer: NavigationDrawerWidget(),
      key: _globalKey,
      body: Stack(children: [
        PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (newIndex) {
            setState(() {
              _index = newIndex;
            });
            _pageController.jumpToPage(newIndex);
          },
          children: [
            HomeBlogs(keys: () {
              _globalKey.currentState!.openDrawer();
            }),
            CatergoryView(),
            BookmarkView(),
            SearchBlogview()
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(20),
              color: BConstantColors.fullblack,
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(1),
                child: ListView.builder(
                  itemCount: data.length,
                  padding: const EdgeInsets.only(left: 10),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(right: 20, left: 15),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _index = index;
                        });
                        _pageController.jumpToPage(
                          _index,
                        );
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 250),
                        width: MediaQuery.of(context).size.width * 0.08,
                        decoration: BoxDecoration(
                            border: index == _index
                                ? Border(
                                    top: BorderSide(
                                        width: 3.0,
                                        color: BConstantColors.yellow))
                                : null,
                            gradient: index == _index
                                ? LinearGradient(
                                    colors: [
                                        BConstantColors.darkgrey,
                                        BConstantColors.black
                                      ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter)
                                : null),
                        child: Icon(
                          data[index],
                          size: 30,
                          color: index == _index
                              ? BConstantColors.yellow
                              : BConstantColors.lightgrey,
                        ),
                      ),
                    ),
                  ),
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
