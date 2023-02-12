import 'package:bindazboyadminapp/app/constant/colors.dart';
import 'package:bindazboyadminapp/app/routes/app.routes.dart';
import 'package:bindazboyadminapp/core/notifiers/authentication.notifer.dart';
import 'package:bindazboyadminapp/core/notifiers/blog.notifier.dart';
import 'package:bindazboyadminapp/core/notifiers/cache.notifier.dart';
import 'package:bindazboyadminapp/core/services/socket_methods.dart';
import 'package:bindazboyadminapp/meta/views/home/components/bloglist.view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeblogView extends StatefulWidget {
  @override
  State<HomeblogView> createState() => _HomeblogViewState();
}

class _HomeblogViewState extends State<HomeblogView> {
  late Future<dynamic> data;
  SocketMethods socketMethods = SocketMethods();

  loadblog() async {
    await Future.delayed(Duration(seconds: 1));

    data = Provider.of<BlogNotifer>(context, listen: false)
        .fetchBlogswithlimit(context: context, pageno: 1);
    return data;
  }

  Future loadblog1() async {
    setState(() {
      data = Provider.of<BlogNotifer>(context, listen: false)
          .fetchBlogswithlimit(context: context, pageno: 1);
    });
  }

  @override
  void initState() {
    super.initState();
    socketMethods.fetchUserOnline(context);
    data = loadblog();
  }

  @override
  void dispose() {
    super.dispose();
    socketMethods.endSocket();
  }

  @override
  Widget build(BuildContext context) {
    final userprovider =
        Provider.of<AuthenticationNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: BConstantColors.backgroundColor,
      body: Stack(
        children: [
          Column(
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
                        child: iconcontainer(
                            context, Icons.add, Colors.yellow, 24.0),
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 11),
                child: Column(
                  children: [
                    Text(
                      "Online Users ${userprovider.numberofcount.toString()}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.70,
                child: RefreshIndicator(
                    onRefresh: () async {
                      setState(() {
                        loadblog1();
                      });
                    },
                    child: Bloglist()),
              ),
            ],
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
