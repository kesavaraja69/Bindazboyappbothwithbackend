import 'package:adminbindazboyapp/app/constant/colors.dart';
import 'package:adminbindazboyapp/app/routes/app.routes.dart';
import 'package:adminbindazboyapp/core/models/zoomdetails.model.dart';
import 'package:adminbindazboyapp/core/notifiers/authentication.notifer.dart';
import 'package:adminbindazboyapp/core/notifiers/blog.notifier.dart';
import 'package:adminbindazboyapp/core/notifiers/cache.notifier.dart';
import 'package:adminbindazboyapp/core/notifiers/zoom.notifier.dart';
import 'package:adminbindazboyapp/core/services/socket_methods.dart';
import 'package:adminbindazboyapp/meta/views/home/components/bloglist.view.dart';
import 'package:adminbindazboyapp/meta/views/zoom/updatezoom.dart';
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
    final zoomProvider = Provider.of<ZoomNoitifer>(context, listen: false);
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
                    SizedBox(
                      width: 4.0,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final zoomProvider =
                            Provider.of<ZoomNoitifer>(context, listen: false);

                        final data = await zoomProvider.fetchzoomDetail(
                            context: context);

                        final fndata = data as ZoomDetailsData;

                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ZoomUpdateDetailsView(
                            zoomtitle: fndata.zoomMeetTopic,
                            zoommtId: fndata.zoomMeetId,
                            zoommtpwd: fndata.zoomMeetPassword,
                            zoomurl: fndata.zoommeetURL,
                            zoomtotalslot: fndata.zoomTotalSlots,
                            zoomAvaliabeslot: fndata.zoomAvailableSlots,
                            zoomDatetime: fndata.zoommeetdateandtime,
                            zoomupcomingDatetime: fndata.zoommeetupcomingdate,
                          );
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: iconcontainer(
                            context,
                            Icons.video_camera_front_rounded,
                            Colors.yellow,
                            24.0),
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
              labeltext("Zoomenable"),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2,
                    ),
                    child: subitbutton(
                        text: "EnableZoom",
                        onclick: () async {
                          await zoomProvider.updateZoomIseanble(
                              context: context,
                              zoomid: 1,
                              zoomMeetIsEnable: "true");
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2,
                    ),
                    child: subitbutton(
                        text: "DisableZoom",
                        onclick: () async {
                          await zoomProvider.updateZoomIseanble(
                              context: context,
                              zoomid: 1,
                              zoomMeetIsEnable: null);
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
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
                height: MediaQuery.of(context).size.height * 0.65,
                child: Bloglist(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget subitbutton({required String text, onclick}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ElevatedButton(
        onPressed: onclick,
        child: Text(
          text,
          style: TextStyle(color: Colors.yellow),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          minimumSize: Size(88, 36),
          padding: EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(7)),
          ),
        ),
      ),
    );
  }

  Widget labeltext(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 3.0),
      child: Text(
        text,
        style: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget title({required text, required controller}) {
    return Container(
      width: 190,
      height: 60,
      decoration: BoxDecoration(
          color: Colors.yellow[200], borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          maxLines: 4,
          decoration:
              new InputDecoration(border: InputBorder.none, hintText: text),
        ),
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
