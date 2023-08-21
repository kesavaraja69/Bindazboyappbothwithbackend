import 'package:bindazboyadminapp/core/models/zoomdetails.model.dart';
import 'package:bindazboyadminapp/core/notifiers/zoom.notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ZoomUpdateDetailsView extends StatefulWidget {
  final dynamic zoomtitle;
  final dynamic zoommtId;
  final dynamic zoommtpwd;
  final dynamic zoomurl;
  final dynamic zoomtotalslot;
  final dynamic zoomAvaliabeslot;
  final dynamic zoomDatetime;
  final dynamic zoomupcomingDatetime;
  ZoomUpdateDetailsView(
      {this.zoomtitle,
      this.zoommtId,
      this.zoommtpwd,
      this.zoomurl,
      this.zoomtotalslot,
      this.zoomAvaliabeslot,
      this.zoomDatetime,
      this.zoomupcomingDatetime});

  @override
  State<ZoomUpdateDetailsView> createState() => _ZoomUpdateDetailsViewState();
}

class _ZoomUpdateDetailsViewState extends State<ZoomUpdateDetailsView> {
  late TextEditingController _titletext;
  late TextEditingController _zoomIDtext;
  late TextEditingController _zoomPasswordtext;
  late TextEditingController _zoomurltext;
  late TextEditingController _zoomTotalslottext;
  late TextEditingController _zoomAvailaibleslottext;
  late TextEditingController _zoomDateandTimetext;
  late TextEditingController _zoomUpComingdatetext;

  @override
  void initState() {
    super.initState();
    _titletext = TextEditingController(text: widget.zoomtitle);
    _zoomIDtext = TextEditingController(text: widget.zoommtId);
    _zoomPasswordtext = TextEditingController(text: widget.zoommtpwd);
    _zoomurltext = TextEditingController(text: widget.zoomurl);
    _zoomTotalslottext =
        TextEditingController(text: widget.zoomtotalslot.toString());
    _zoomAvailaibleslottext =
        TextEditingController(text: widget.zoomAvaliabeslot.toString());
    _zoomDateandTimetext = TextEditingController(text: widget.zoomDatetime);
    _zoomUpComingdatetext =
        TextEditingController(text: widget.zoomupcomingDatetime);
    // fetchzoomdetails();
  }

  // fetchzoomdetails() async {
  //   final zoomProvider = Provider.of<ZoomNoitifer>(context, listen: false);

  //   final data =
  //       await zoomProvider.fetchzoomDetail(context: context) as ZoomDetailsData;

  //   _titletext = TextEditingController(text: data.zoomMeetTopic);
  //   _zoomIDtext = TextEditingController(text: data.zoomMeetId);
  //   _zoomPasswordtext = TextEditingController(text: data.zoomMeetPassword);
  //   _zoomurltext = TextEditingController(text: data.zoommeetURL);
  //   _zoomTotalslottext =
  //       TextEditingController(text: data.zoomTotalSlots.toString());
  //   _zoomAvailaibleslottext =
  //       TextEditingController(text: data.zoomAvailableSlots.toString());
  //   _zoomDateandTimetext =
  //       TextEditingController(text: data.zoommeetdateandtime);
  //   _zoomUpComingdatetext =
  //       TextEditingController(text: data.zoommeetupcomingdate);
  // }

  @override
  void dispose() {
    _zoomIDtext.dispose();
    _zoomPasswordtext.dispose();
    _zoomurltext.dispose();
    _zoomTotalslottext.dispose();
    _zoomAvailaibleslottext.dispose();
    _zoomDateandTimetext.dispose();
    _titletext.dispose();
    _zoomUpComingdatetext.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final zoomProvider = Provider.of<ZoomNoitifer>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    CupertinoIcons.arrow_left,
                  ),
                ),
                SizedBox(
                  width: 30.0,
                ),
                Text(
                  "Update Zoom",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 15,
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
            labeltext("Title"),
            SizedBox(
              height: 4,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 3.0),
              child: title(text: 'title', controller: _titletext),
            ),
            SizedBox(
              height: 12,
            ),
            labeltext("ZoomID"),
            SizedBox(
              height: 4,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 3.0),
              child: title(text: 'ZoomID', controller: _zoomIDtext),
            ),
            SizedBox(
              height: 12,
            ),
            labeltext("ZoomPassword"),
            SizedBox(
              height: 4,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 3.0),
              child: title(text: 'ZoomPassword', controller: _zoomPasswordtext),
            ),
            SizedBox(
              height: 12,
            ),
            labeltext("ZoomURL"),
            SizedBox(
              height: 4,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 3.0),
              child: title(text: 'ZoomURL', controller: _zoomurltext),
            ),
            SizedBox(
              height: 12,
            ),
            labeltext("ZoomAvAilableSlot"),
            SizedBox(
              height: 4,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 3.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2,
                    ),
                    child: title(
                        text: 'ZoomAvAilableSlot',
                        controller: _zoomAvailaibleslottext),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: subitbutton(
                        text: "Update Slot",
                        onclick: () async {
                          await zoomProvider
                              .updateZoomavailable(
                                  context: context,
                                  zoomid: 1,
                                  zoomAvaibleSlot: int.parse(
                                      "${_zoomAvailaibleslottext.text}"))
                              .then((value) => Navigator.of(context).pop());
                        }),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            labeltext("ZoomTotalSlot"),
            SizedBox(
              height: 4,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 3.0),
              child:
                  title(text: 'ZoomTotalSlot', controller: _zoomTotalslottext),
            ),
            SizedBox(
              height: 12,
            ),
            labeltext("ZoomDateandTime"),
            SizedBox(
              height: 4,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 3.0),
              child: title(
                  text: '16 Apr 23 at 6.00 pm',
                  controller: _zoomDateandTimetext),
            ),
            SizedBox(
              height: 12,
            ),
            labeltext("ZoomUpComingdate"),
            SizedBox(
              height: 4,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 3.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 2, vertical: 3.0),
                    child: title(
                        text: '16 Apr 23 at 6.00 pm',
                        controller: _zoomUpComingdatetext),
                  ),
                  subitbutton(
                      text: "Update Date",
                      onclick: () async {
                        await zoomProvider
                            .updateZoomdate(
                                context: context,
                                zoomid: 1,
                                zoomUpCompingDate: _zoomUpComingdatetext.text)
                            .then((value) => Navigator.of(context).pop());
                      }),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            labeltext("RestUser"),
            SizedBox(
              height: 4,
            ),
            subitbutton(
                text: "Reset All User",
                onclick: () async {
                  await zoomProvider.removeAllUsers(context: context);
                }),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 25,
            ),
            subitbutton(
                text: "Submit",
                onclick: () async {
                  await zoomProvider
                      .updateregisterZoom(
                        context: context,
                        zoomid: 1,
                        zoomMtPwd: _zoomPasswordtext.text,
                        zoomMtID: _zoomIDtext.text,
                        zoomMtTitle: _titletext.text,
                        zoomAvaibleSlot:
                            int.parse("${_zoomAvailaibleslottext.text}"),
                        zoomTotalSlot: int.parse("${_zoomTotalslottext.text}"),
                        zoomMtUrl: _zoomurltext.text,
                        zoomdateandtime: _zoomDateandTimetext.text,
                        zoomUpCompingDate: _zoomUpComingdatetext.text,
                      )
                      .then((value) => Navigator.of(context).pop());
                }),
            SizedBox(
              height: 55,
            ),
          ],
        ),
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
}
