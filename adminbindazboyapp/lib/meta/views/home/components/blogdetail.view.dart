import 'package:adminbindazboyapp/core/models/blogdetails.model.dart';
import 'package:adminbindazboyapp/core/notifiers/blog.notifier.dart';
import 'package:adminbindazboyapp/meta/utils/blogdetail.arguments.dart';
import 'package:adminbindazboyapp/meta/views/home/components/lowerdetail.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Blogdetailsview extends StatefulWidget {
  final BlogDetailArguments blogDetailArguments;
  const Blogdetailsview({super.key, required this.blogDetailArguments});

  @override
  _BlogdetailsviewState createState() => _BlogdetailsviewState();
}

class _BlogdetailsviewState extends State<Blogdetailsview> {
  @override
  Widget build(BuildContext context) {
    final planeHeightclosed = MediaQuery.of(context).size.height * 0.65;
    final planeHeightopen = MediaQuery.of(context).size.height * 0.65;
    final provider = Provider.of<BlogNotifer>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: FutureBuilder(
        future: provider.loadingBlogsDetail(
          context: context,
          detailid: widget.blogDetailArguments.id,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitFadingCircle(color: Colors.black, size: 50.0),
            );
          } else {
            var blogdetialdata = snapshot.data as dynamic;
            Datadetails datadetails = blogdetialdata;
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.network(
                  datadetails.blogImage.toString(),
                  fit: BoxFit.cover,
                  color: Colors.black54.withOpacity(0.50),
                  colorBlendMode: BlendMode.darken,
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: iconcontainer(
                      context,
                      Icons.arrow_back_ios_new_sharp,
                      Colors.white,
                      24.0,
                    ),
                  ),
                ),
                Positioned(
                  top: 225,
                  right: 10,
                  child: titletext(
                    context,
                    "Posted On ${datadetails.blogDate.toString().split('-').reversed.join('-')}",
                    12.0,
                    FontWeight.w500,
                  ),
                ),

                Positioned(
                  top: 225,
                  left: 10,
                  child: titletext(
                    context,
                    "Category by ${datadetails.blogCategory}",
                    12.0,
                    FontWeight.w500,
                  ),
                ),
                Positioned(
                  top: 90,
                  left: 50,
                  right: 50,
                  child: titletext(
                    context,
                    datadetails.blogTitle,
                    16.0,
                    FontWeight.bold,
                  ),
                ),
                SlidingUpPanel(
                  color: Colors.black.withOpacity(0.30),
                  maxHeight: planeHeightopen,
                  minHeight: planeHeightclosed,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25.0),
                  ),
                  panelBuilder:
                      (controller) => LowerPlane(
                        blogdetails: datadetails.blogDescription.toString(),
                        controller: controller,
                      ),
                ),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [

                //   ],
                // )
              ],
            );
          }
        },
      ),
    );
  }

  Widget titletext(BuildContext context, title, size, weight) => Padding(
    padding: const EdgeInsets.all(4.0),
    child: Text(
      title,
      style: TextStyle(color: Colors.white, fontSize: size, fontWeight: weight),
    ),
  );

  Widget iconcontainer(BuildContext context, icon, color2, size) => Container(
    height: 35,
    width: 35,
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.60),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Center(child: Icon(icon, color: color2, size: size)),
  );
}
