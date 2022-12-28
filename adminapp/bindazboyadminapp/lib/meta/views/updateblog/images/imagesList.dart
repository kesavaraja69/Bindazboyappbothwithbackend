import 'package:bindazboyadminapp/core/notifiers/blog.notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class ImageList extends StatelessWidget {
  final List<String>? images;
  final Function onclick;
  final dynamic blogid;
  const ImageList(
      {Key? key, required this.images, required this.onclick, this.blogid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blogNotifer = Provider.of<BlogNotifer>(context, listen: false);
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 165,
      child: Stack(
        children: [
          ListView.builder(
            itemCount: images?.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: 9, right: 4, left: 9, bottom: 7),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 230, 230, 230),
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(images![index]),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 3,
                    top: 3,
                    child: InkWell(
                      onTap: () async {
                        EasyLoading.show(status: 'Deleteing..Wait..');
                        await blogNotifer.removeBlogfile(
                            context: context,
                            filetype: "images",
                            filename:
                                "${images![index].split('/').toList().last}",
                            deleteid: blogid,
                            fileindex: index);

                        // await blogNotifer.updateimagesBlog(
                        //     context: context,
                        //     blog_id: blogid,
                        //     blog_images: images!.isEmpty ? null : images);

                        // utilityNotifer
                        //     .deleteblogImages(
                        //         context: context,
                        //         urls: widget
                        //             .blogDetailArguments
                        //             .blogImages)
                        //     .whenComplete(() => );
                        EasyLoading.dismiss();
                        onclick();
                      },
                      child: Container(
                        height: 29,
                        width: 29,
                        child: Center(
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
