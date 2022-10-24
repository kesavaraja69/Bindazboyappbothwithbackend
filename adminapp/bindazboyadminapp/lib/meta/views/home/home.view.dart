import 'package:bindazboyadminapp/app/constant/colors.dart';
import 'package:bindazboyadminapp/app/routes/app.routes.dart';
import 'package:bindazboyadminapp/core/notifiers/blog.notifier.dart';
import 'package:bindazboyadminapp/core/notifiers/cache.notifier.dart';
import 'package:bindazboyadminapp/meta/views/home/components/bloglist.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class HomeblogView extends StatefulWidget {
  @override
  State<HomeblogView> createState() => _HomeblogViewState();
}

class _HomeblogViewState extends State<HomeblogView> {
  late Future<dynamic> data;

  Future loadblog() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      this.data = Provider.of<BlogNotifer>(context, listen: false)
          .fetchBlogs(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BlogNotifer>(context, listen: false);
    return Scaffold(
      backgroundColor: BConstantColors.backgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Bindaz Boy Admin App",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 4.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed<dynamic>(AppRoutes.AddblogRoute);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        iconcontainer(context, Icons.add, Colors.yellow, 24.0),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<CacheNotifer>(context, listen: false)
                        .deleteCache(key: "jwtdata");
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.LoginRoute, (route) => false);
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.brown[800],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: loadblog,
              backgroundColor: Colors.black,
              color: Colors.yellow,
              child: FutureBuilder(
                  future: provider.fetchBlogs(context: context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: SpinKitFadingCircle(
                        color: Colors.black,
                        size: 50.0,
                      ));
                    }
                    if (snapshot.data != null) {
                      var _snapshot = snapshot.data as List;
                      if (_snapshot.isEmpty) {
                        return Center(
                          child: Text("Add Blogs"),
                        );
                      }
                      return Bloglist(snapshot: _snapshot);
                    }
                    return Center(
                      child: Text("something went wrong try again"),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget iconcontainer(BuildContext context, icon, color2, size) => Container(
        height: 35,
        width: 35,
        child: Center(
          child: Icon(
            icon,
            color: color2,
            size: size,
          ),
        ),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(12.0)),
      );
}
