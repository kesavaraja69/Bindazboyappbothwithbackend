import 'package:adminbindazboyapp/core/notifiers/utility.notifer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class ShowbottomView extends StatefulWidget {
  final refreshonclick;
  const ShowbottomView({super.key, this.refreshonclick});

  @override
  State<ShowbottomView> createState() => _ShowbottomViewState();
}

class _ShowbottomViewState extends State<ShowbottomView> {
  @override
  Widget build(BuildContext context) {
    final utilityNotifer = Provider.of<UtilityNotifer>(context, listen: true);
    chooseimage() async {
      setState(() {
        utilityNotifer.pickblogimages(context);
      });
    }

    //  final List<File>? images = utilityNotifer.previewlistblogimages;
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.yellow[200],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 9.0),
            subitbutton(
              text: "select Images",
              onclick: () {
                chooseimage();
              },
            ),
            SizedBox(height: 3.0),
            utilityNotifer.previewlistblogimages != null
                ? Column(
                  children: [
                    SizedBox(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: utilityNotifer.previewlistblogimages?.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                        itemBuilder: (context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9.0,
                              vertical: 7.0,
                            ),
                            child: Container(
                              child: Image.file(
                                utilityNotifer.previewlistblogimages![index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 9.0),
                    subitbutton(
                      text: "Upload",
                      onclick: () async {
                        EasyLoading.show(status: 'Uploadling..Wait..');
                        await utilityNotifer
                            .addimagefiles(context: context)
                            .whenComplete(() async {
                              await widget.refreshonclick();
                              Navigator.of(context).pop();
                              EasyLoading.showSuccess("Uploaded Sucessfully");
                              EasyLoading.dismiss();
                            });
                      },
                    ),
                  ],
                )
                : Container(),
            SizedBox(height: 4.0),
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
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          minimumSize: Size(88, 36),
          padding: EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(7)),
          ),
        ),
        child: Text(text, style: TextStyle(color: Colors.yellow)),
      ),
    );
  }
}
