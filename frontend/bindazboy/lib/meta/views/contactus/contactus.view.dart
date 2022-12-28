import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/core/notifiers/contactus.notifier.dart';
import 'package:bindazboy/meta/utils/showsnackbar.utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/reportandcontact.arguments.dart';

class ContactusView extends StatefulWidget {
  final ReportandcontactArguments reportandcontactArguments;
  const ContactusView({required this.reportandcontactArguments});

  @override
  State<ContactusView> createState() => _ContactusViewState();
}

class _ContactusViewState extends State<ContactusView> {
  late TextEditingController _titletext;
  late TextEditingController _descriptiontext;
//  late TextEditingController _emailtext;
  @override
  void initState() {
    _titletext = TextEditingController();
    _descriptiontext = TextEditingController();
    // _emailtext = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titletext.dispose();
    //   _emailtext.dispose();
    _descriptiontext.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mheight = MediaQuery.of(context).size.height;
    final mwidth = MediaQuery.of(context).size.width;
    final contactusprovider =
        Provider.of<ContactusNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 11, 9, 19),
        centerTitle: true,
        title: Text(
          widget.reportandcontactArguments.isReport == false
              ? "Contact US"
              : "Report or Bug",
          style: TextStyle(
              color: BConstantColors.titleColor,
              fontSize: 19,
              fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: BConstantColors.backgroundColor,
      body: SizedBox(
        height: mheight,
        width: mwidth,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mheight * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: mheight * 0.02,
                ),
                labeltext("Name"),
                SizedBox(
                  height: mheight * 0.012,
                ),
                title(
                  controller: _titletext,
                  text: "Enter here",
                ),
                SizedBox(
                  height: mheight * 0.04,
                ),
                labeltext("Description"),
                SizedBox(
                  height: mheight * 0.012,
                ),
                description(controller: _descriptiontext, text: "Enter here"),
                SizedBox(
                  height: mheight * 0.04,
                ),
                Padding(
                  padding: EdgeInsets.only(left: mwidth * 0.33),
                  child: subitbutton(
                    text: "Submit",
                    onclick: () async {
                      if (_descriptiontext.text.isNotEmpty &&
                          _titletext.text.isNotEmpty) {
                        if (widget.reportandcontactArguments.isReport ==
                            false) {
                          print("contact us");
                          await contactusprovider.addContactus(
                              usname: _titletext.text,
                              context: context,
                              iscontactus: "true",
                              usmessage: _descriptiontext.text);
                        } else {
                          print("report or bug");
                          await contactusprovider.addContactus(
                              usname: _titletext.text,
                              context: context,
                              iscontactus: "false",
                              usmessage: _descriptiontext.text);
                        }
                      } else {
                        ShowsnackBarUtiltiy.showSnackbar(
                            message: "Fill the value", context: context);
                      }
                    },
                    color1: Color.fromARGB(255, 19, 19, 19),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget subitbutton({required String text, onclick, color1}) {
    return ElevatedButton(
      onPressed: onclick,
      style: ElevatedButton.styleFrom(
        backgroundColor: color1,
        minimumSize: const Size(125, 45),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(9)),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
            color: Color.fromARGB(255, 239, 245, 110), fontSize: 17),
      ),
    );
  }

  Widget labeltext(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3.0),
      child: Text(
        text,
        style: const TextStyle(
            color: Color.fromARGB(215, 10, 10, 10),
            fontSize: 19,
            fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget title({required text, required controller}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 59,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 239, 248, 117),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          maxLines: 2,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: text,
              hintStyle: const TextStyle(color: Colors.grey)),
        ),
      ),
    );
  }

  Widget description({required text, required controller}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 190,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 239, 248, 117),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          maxLines: null,
          style: const TextStyle(
              color: Color.fromARGB(255, 15, 15, 15), fontSize: 17),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: text,
            hintStyle: const TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
