import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/app/routes/app.routes.dart';
import 'package:bindazboy/meta/utils/reportandcontact.arguments.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: BConstantColors.backgroundColor,
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.yellow[200],
                  borderRadius: BorderRadius.circular(14),
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.30), BlendMode.multiply),
                      image: AssetImage('assets/images/T1.jpg'),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            bulidMenuItem(
              text: 'Category',
              icon: Icons.category,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(
              height: 15,
            ),
            bulidMenuItem(
              text: 'Bookmark',
              icon: Icons.bookmark,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(
              height: 15,
            ),
            bulidMenuItem(
              text: 'Contactus',
              icon: Icons.people,
              onClicked: () => selectedItem(context, 2),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
                onTap: () {
                  final url =
                      'https://pages.flycricket.io/bindazboy-privacy/privacy.html';
                  openBrowserUrl(url: url, inApp: true);
                },
                child: bulidMenuItem(
                    text: 'Privacy Policy', icon: Icons.privacy_tip)),
          ],
        ),
      ),
    );
  }

  Future openBrowserUrl({required dynamic url, bool inApp = false}) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(
        url,
      );
    }
  }

  Widget bulidMenuItem(
      {required String text, required IconData icon, VoidCallback? onClicked}) {
    final color = Colors.brown[700];
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: ListTile(
        leading: Icon(
          icon,
          color: color,
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 7),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 17,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        onTap: onClicked,
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pushNamed(AppRoutes.CatergoryRoute);
        break;
      case 1:
        Navigator.of(context).pushNamed(AppRoutes.BookmarkRoute);
        break;

      case 2:
        Navigator.of(context).pushNamed(AppRoutes.ContactusRoute,
            arguments: ReportandcontactArguments(isReport: true));
        break;
    }
  }
}
