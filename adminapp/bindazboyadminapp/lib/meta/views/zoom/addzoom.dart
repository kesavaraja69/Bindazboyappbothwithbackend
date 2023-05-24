import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ZoomAddDetailsView extends StatefulWidget {
  const ZoomAddDetailsView();

  @override
  State<ZoomAddDetailsView> createState() => _ZoomAddDetailsViewState();
}

class _ZoomAddDetailsViewState extends State<ZoomAddDetailsView> {
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
    _titletext = TextEditingController();
    _zoomIDtext = TextEditingController();
    _zoomPasswordtext = TextEditingController();
    _zoomurltext = TextEditingController();
    _zoomTotalslottext = TextEditingController();
    _zoomAvailaibleslottext = TextEditingController();
    _zoomDateandTimetext = TextEditingController();
    _zoomUpComingdatetext = TextEditingController();
    super.initState();
  }

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
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: SingleChildScrollView(
        child: Column(
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
                  "Add Zoom",
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
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 3.0),
              child: title(
                  text: 'ZoomAvAilableSlot',
                  controller: _zoomAvailaibleslottext),
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
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 3.0),
              child: title(
                  text: '16 Apr 23 at 6.00 pm',
                  controller: _zoomUpComingdatetext),
            ),
            SizedBox(
              height: 25,
            ),
            subitbutton(text: "Submit", onclick: () {})
          ],
        ),
      ),
    );
  }

  Widget subitbutton({required String text, onclick}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 120),
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
      width: MediaQuery.of(context).size.width,
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
