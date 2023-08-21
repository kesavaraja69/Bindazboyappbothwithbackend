import 'dart:async';
import 'package:bindazboyadminapp/app/routes/app.routes.dart';
import 'package:bindazboyadminapp/core/models/blogdetails.model.dart';
import 'package:bindazboyadminapp/core/notifiers/blog.notifier.dart';
import 'package:bindazboyadminapp/core/notifiers/category.notifier.dart';
import 'package:bindazboyadminapp/core/notifiers/utility.notifer.dart';
import 'package:bindazboyadminapp/meta/utils/blogdetail.arguments.dart';
import 'package:bindazboyadminapp/meta/views/addblog/catergorycomponents/catergorylist.dart';
import 'package:bindazboyadminapp/meta/views/addblog/showmodel/showmodel.view.dart';
import 'package:bindazboyadminapp/meta/views/updateblog/images/imagesList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class UpdateBlog extends StatefulWidget {
  final BlogDetailArguments blogDetailArguments;
  const UpdateBlog({required this.blogDetailArguments});

  @override
  _UpdateBlogState createState() => _UpdateBlogState();
}

class _UpdateBlogState extends State<UpdateBlog> {
  late TextEditingController _titletext;
  late TextEditingController _descriptiontext;
  late TextEditingController _catgorytext;
  late TextEditingController _mainimageurltext;
  DateTime selectedDate = DateTime.now();
  var selected = 1;
  dynamic catergorytitle = "வழிபாடு";
  final pageController = PageController();
  final fristdate = DateTime(1990, 1);
  final lastdate = DateTime(3000, 1);
  late Future<dynamic> data;
  late Future<dynamic> data1;
  Timer? _timer;
  @override
  void initState() {
    super.initState();

    _catgorytext = TextEditingController();
    _mainimageurltext = TextEditingController();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    selectedDate = DateTime.parse(widget.blogDetailArguments.blogDate);
    _titletext =
        TextEditingController(text: widget.blogDetailArguments.blogTitle);
    _descriptiontext =
        TextEditingController(text: widget.blogDetailArguments.blogDescription);
  }

  Future loadblog() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      this.data = Provider.of<BlogNotifer>(context, listen: false)
          .fetchBlogs(context: context);
    });
  }

  Future loadblogdetail() async {
    setState(() {
      this.data1 = Provider.of<BlogNotifer>(context, listen: false)
          .loadingBlogsDetail(
              context: context, detailid: widget.blogDetailArguments.id);
    });
  }

  @override
  void dispose() {
    _catgorytext.dispose();
    _descriptiontext.dispose();
    _mainimageurltext.dispose();
    _titletext.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final utilityNotifer = Provider.of<UtilityNotifer>(context, listen: true);
    final catgoryNotifer = Provider.of<CategoryNotifer>(context, listen: false);
    final blogNotifer = Provider.of<BlogNotifer>(context, listen: false);
    return Scaffold(
      body: Container(
        color: Colors.yellow[100],
        child: SingleChildScrollView(
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
                    "Edit Blog",
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
              labeltext("Description"),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 3.0),
                child: description(
                    text: "Description", controller: _descriptiontext),
              ),
              SizedBox(
                height: 12,
              ),
              labeltext("Select Date"),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 3.0),
                child: date(),
              ),
              SizedBox(
                height: 12,
              ),
              labeltext("Enter Background Image Url"),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 3.0),
                child: title(text: 'Imageurl', controller: _mainimageurltext),
              ),
              SizedBox(
                height: 12,
              ),
              labeltext("(OR)"),
              SizedBox(
                height: 6,
              ),
              labeltext("Select Background Image"),
              SizedBox(
                height: 4,
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 3.0),
                  child: Provider.of<UtilityNotifer>(context, listen: true)
                              .previewblogimage !=
                          null
                      ? imagecontainer(
                          image: utilityNotifer.previewblogimage!,
                          onclick: () {
                            utilityNotifer.pickblogimage(context);
                          })
                      : iconcontainer(
                          onclick: () async {
                            await blogNotifer.removeBlogfile(
                              context: context,
                              filetype: "image",
                              filename:
                                  "${widget.blogDetailArguments.blogImage.split('/').toList().last}",
                            );
                            await utilityNotifer.pickblogimage(context);
                            // await utilityNotifer
                            //     .deleteblogImage(
                            //         context: context,
                            //         url: widget.blogDetailArguments.blogImage)
                            //     .whenComplete(() =>
                            //         utilityNotifer.pickblogimage(context));
                          },
                          context: context)),
              SizedBox(
                height: 12,
              ),
              Column(
                children: [
                  labeltext("Add Category"),
                  SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 3.0),
                    child: title(text: '(Optional)', controller: _catgorytext),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  subitbutton(
                      text: "Add",
                      onclick: () async {
                        var catgory = _catgorytext.text;
                        if (catgory.isNotEmpty) {
                          await catgoryNotifer.addCategory(
                              context: context, catergory: catgory);
                        }
                      }),
                  SizedBox(
                    height: 12,
                  ),
                  labeltext("Select Category"),
                  SizedBox(
                    height: 4,
                  ),
                  CatergoryList(
                    callback: (int index, dynamic title) {
                      setState(() {
                        selected = index;
                        catergorytitle = title;
                        print("fristpage is $selected");
                        print("Title is $catergorytitle");
                      });
                      //pageController.jumpToPage(index);
                    },
                    selected: selected,
                  ),
                ],
              ),
              SizedBox(
                height: 9,
              ),
              SizedBox(
                height: 12,
              ),
              labeltext("Optional Select Images"),
              SizedBox(
                height: 4,
              ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
              //   child: filename(text: "Images File Name", size: 16.0),
              // ),
              Center(
                child: subitbutton(
                    text: "Upload Images",
                    onclick: () {
                      showMaterialModalBottomSheet(
                        expand: false,
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)),
                        ),
                        builder: (context) => ShowbottomView(
                          refreshonclick: () async {
                            await loadblog();
                            await loadblogdetail();
                          },
                        ),
                      );
                    }),
              ),
              widget.blogDetailArguments.blogImages != null
                  ? FutureBuilder(
                      future: blogNotifer.loadingBlogsDetail(
                          context: context,
                          detailid: widget.blogDetailArguments.id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          );
                        }
                        if (snapshot.data != null) {
                          var blogdetialdata = snapshot.data as dynamic;
                          Datadetails datadetails = blogdetialdata;
                          return datadetails.blogImages != null &&
                                  datadetails.blogImages!.isNotEmpty
                              ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      ImageList(
                                        blogid: widget.blogDetailArguments.id,
                                        images: datadetails.blogImages,
                                        onclick: () async {
                                          // await loadblog();
                                          await loadblogdetail();
                                        },
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.symmetric(
                                      //       horizontal: 5.0, vertical: 4.0),
                                      //   child:
                                      //       // InkWell(
                                      //       // onTap: () async {
                                      //       //   EasyLoading.show(
                                      //       //       status: 'Deleteing..Wait..');
                                      //       //   await blogNotifer.updateimagesBlog(
                                      //       //       context: context,
                                      //       //       blog_id: widget
                                      //       //           .blogDetailArguments.id,
                                      //       //       blog_images: null);
                                      //       //   // utilityNotifer
                                      //       //   //     .deleteblogImages(
                                      //       //   //         context: context,
                                      //       //   //         urls: widget
                                      //       //   //             .blogDetailArguments
                                      //       //   //             .blogImages)
                                      //       //   //     .whenComplete(() => );
                                      //       //   EasyLoading.dismiss();
                                      //       //   loadblog();
                                      //       // },
                                      //       // child:
                                      //       Container(
                                      //     height: 35,
                                      //     width: 35,
                                      //     child: Center(
                                      //       child: Icon(
                                      //         Icons.delete,
                                      //         color: Colors.yellow,
                                      //       ),
                                      //     ),
                                      //     decoration: BoxDecoration(
                                      //         color: Colors.black,
                                      //         borderRadius:
                                      //             BorderRadius.circular(12)),
                                      //   ),
                                      //   // ),
                                      // ),
                                    ],
                                  ),
                                )
                              : Container();
                        }
                        return Container();
                      })
                  : Container(),
              SizedBox(
                height: 12,
              ),
              labeltext("Optional Select Audio"),
              SizedBox(
                height: 6,
              ),
              Center(
                child: subitbutton(
                    text: "Select Audio",
                    onclick: () {
                      if (utilityNotifer.previewblogaudio == null) {
                        utilityNotifer.pickblogaudio(context);
                      }
                    }),
              ),
              SizedBox(
                height: 6,
              ),
              FutureBuilder(
                  future: blogNotifer.loadingBlogsDetail(
                      context: context,
                      detailid: widget.blogDetailArguments.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      );
                    } else {
                      var blogdetialdata = snapshot.data as dynamic;
                      Datadetails datadetails = blogdetialdata;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 7.0),
                        child: datadetails.blogAudio != null ||
                                utilityNotifer.audioName != null
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0, horizontal: 3.0),
                                    child: filename(
                                        text: "${utilityNotifer.audioName}",
                                        size: 16.0),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 4.0),
                                    child: InkWell(
                                      onTap: () {
                                        if (utilityNotifer.audioName != null) {
                                          utilityNotifer.pickblogaudio(context);
                                        }
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        child: Center(
                                          child: Icon(
                                            Icons.replay_outlined,
                                            color: Colors.yellow,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 4.0),
                                    child: InkWell(
                                      onTap: () async {
                                        EasyLoading.show(
                                            status: 'Deleteing..Wait..');
                                        print(
                                            "${datadetails.blogAudio!.split('/').toList().last}");
                                        await blogNotifer.removeBlogfile(
                                            context: context,
                                            filetype: "audio",
                                            filename:
                                                "${datadetails.blogAudio!.split('/').toList().last}");
                                        await blogNotifer.updateaudioBlog(
                                            context: context,
                                            blog_id:
                                                widget.blogDetailArguments.id,
                                            blog_audio: null);
                                        EasyLoading.dismiss();
                                        utilityNotifer.removeaudioname();
                                        // loadblog();

                                        //     .whenComplete(() {

                                        // });
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        child: Center(
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.yellow,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : SizedBox(
                                height: 2,
                              ),
                      );
                    }
                  }),
              SizedBox(
                height: 11,
              ),
              FutureBuilder(
                  future: blogNotifer.loadingBlogsDetail(
                      context: context,
                      detailid: widget.blogDetailArguments.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      );
                    } else {
                      var blogdetialdata = snapshot.data as dynamic;
                      Datadetails datadetails = blogdetialdata;
                      return Center(
                        child: subitbutton(
                            text: "Update",
                            onclick: () async {
                              // final datafn = utilityNotifer.myListdatafnimages!.isEmpty
                              //     ? widget.blogDetailArguments.blogImages == null
                              //         ? null
                              //         : widget.blogDetailArguments.blogImages
                              //     : utilityNotifer.myListdatafnimages;

                              // print("list of image $datafn");

                              // print(
                              //     "list wgt ${widget.blogDetailArguments.blogImages}");

                              var title = _titletext.text;
                              var description = _descriptiontext.text;
                              if (_mainimageurltext.text.isEmpty &&
                                  widget
                                      .blogDetailArguments.blogImage!.isEmpty) {
                                await utilityNotifer.addAllTypeFile(
                                    context: context);
                              }
                              EasyLoading.show(status: 'Updating..Wait..');
                              Future.delayed(Duration(seconds: 6))
                                  .whenComplete(() async {
                                if (utilityNotifer.audioName != null &&
                                    utilityNotifer.audioName!.isNotEmpty) {
                                  await utilityNotifer.addAllTypeFile(
                                      context: context, filetype: "audio");
                                  print(utilityNotifer.audioURL);
                                }
                                await blogNotifer
                                    .updateBlogs(
                                        context: context,
                                        blog_id: widget.blogDetailArguments.id,
                                        blog_title: title,
                                        blog_description: description,
                                        blog_image: _mainimageurltext
                                                .text.isEmpty
                                            ? utilityNotifer.imageURL != null
                                                ? utilityNotifer.imageURL
                                                : widget.blogDetailArguments
                                                    .blogImage
                                            : _mainimageurltext.text,
                                        blog_category: catergorytitle,
                                        blog_audio:
                                            utilityNotifer.audioURL == null
                                                ? datadetails.blogAudio == null
                                                    ? null
                                                    : datadetails.blogAudio
                                                : utilityNotifer.audioURL,
                                        blog_images: utilityNotifer
                                                .myListdatafnimages!.isEmpty
                                            ? datadetails.blogImages == null
                                                ? null
                                                : datadetails.blogImages
                                            : utilityNotifer.myListdatafnimages,
                                        blog_date: selectedDate
                                            .toString()
                                            .split(' ')[0])
                                    .whenComplete(() async {
                                  utilityNotifer.removepreviewimages();
                                  utilityNotifer.removeimgall();
                                  EasyLoading.showSuccess(
                                      'Updated Successfully!');
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      AppRoutes.HomeRoute, (route) => false);
                                  EasyLoading.dismiss();
                                });
                              });
                            }),
                        // FutureBuilder(
                        //     future: blogNotifer.loadingBlogsDetail(
                        //         context: context,
                        //         detailid: widget.blogDetailArguments.id),
                        //     builder: (context, snapshot) {
                        //       if (snapshot.connectionState == ConnectionState.waiting) {
                        //         return Center(
                        //           child: CircularProgressIndicator(
                        //             color: Colors.black,
                        //           ),
                        //         );
                        //       } else {
                        //         final blogdetialdata = snapshot.data as dynamic;
                        //         Datadetails datadetails = blogdetialdata;

                        //         // final blogaudiodata = utilityNotifer.audioURL == null
                        //         //     ? widget.blogDetailArguments.blog_audio == null
                        //         //         ? null
                        //         //         : datadetails.blogAudio
                        //         //     : utilityNotifer.audioURL;

                        //         // final blogimagesdata =
                        //         //     utilityNotifer.myListfnimages == null
                        //         //         ? widget.blogDetailArguments.blogImages == null
                        //         //             ? null
                        //         //             : datadetails.blogImages
                        //         //         : utilityNotifer.myListfnimages;
                        //         return subitbutton(
                        //             text: "Update",
                        //             onclick: () async {
                        //               var title = _titletext.text;
                        //               var description = _descriptiontext.text;
                        //               if (_mainimageurltext.text.isEmpty &&
                        //                   datadetails.blogImage!.isEmpty) {
                        //                 await utilityNotifer.addAllTypeFile(
                        //                     context: context);
                        //               }
                        //               EasyLoading.show(status: 'Updating..Wait..');
                        //               Future.delayed(Duration(seconds: 6))
                        //                   .whenComplete(() async {
                        //                 if (utilityNotifer.audioName != null &&
                        //                     utilityNotifer.audioName!.isNotEmpty) {
                        //                   await utilityNotifer.addAllTypeFile(
                        //                       context: context, filetype: "audio");
                        //                   print(utilityNotifer.audioURL);
                        //                 }
                        //                 await blogNotifer
                        //                     .updateBlogs(
                        //                         context: context,
                        //                         blog_id: widget.blogDetailArguments.id,
                        //                         blog_title: title,
                        //                         blog_description: description,
                        //                         blog_image: _mainimageurltext
                        //                                 .text.isEmpty
                        //                             ? utilityNotifer.imageURL != null
                        //                                 ? utilityNotifer.imageURL
                        //                                 : widget.blogDetailArguments
                        //                                     .blogImage
                        //                             : _mainimageurltext.text,
                        //                         blog_category: catergorytitle,
                        //                         blog_audio:
                        //                             utilityNotifer.audioURL == null
                        //                                 ? datadetails.blogAudio == null
                        //                                     ? null
                        //                                     : datadetails.blogAudio
                        //                                 : utilityNotifer.audioURL,
                        //                         blog_images:
                        //                             utilityNotifer.myListfnimages ==
                        //                                         null &&
                        //                                     utilityNotifer
                        //                                         .myListfnimages!.isEmpty
                        //                                 ? datadetails.blogImages == null
                        //                                     ? null
                        //                                     : datadetails.blogImages
                        //                                 : utilityNotifer.myListfnimages,
                        //                         blog_date: selectedDate
                        //                             .toString()
                        //                             .split(' ')[0])
                        //                     .whenComplete(() async {
                        //                   EasyLoading.showSuccess(
                        //                       'Updated Successfully!');
                        //                   Navigator.of(context).pushNamedAndRemoveUntil(
                        //                       AppRoutes.HomeRoute, (route) => false);
                        //                   EasyLoading.dismiss();
                        //                 });
                        //               });
                        //             });
                        //       }
                        //     }),
                      );
                    }
                  }),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget filename({required text, required size}) {
    return Container(
      width: 250,
      height: 60,
      decoration: BoxDecoration(
          color: Colors.yellow[200], borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            text,
            maxLines: 2,
            style: TextStyle(color: Colors.black45, fontSize: size),
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

  Widget title({required text, required controller}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
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

  Widget date() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.yellow[200], borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                  onTap: () => _openDatepicker(context),
                  child: Icon(CupertinoIcons.calendar)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text('$selectedDate'.split(' ')[0]),
            ),
          ],
        ),
      ),
    );
  }

  Widget imagecontainer({required image, required onclick}) {
    final utilityNotifer = Provider.of<UtilityNotifer>(context, listen: true);
    final provider = Provider.of<BlogNotifer>(context, listen: false);
    return Stack(children: [
      Container(
        width: MediaQuery.of(context).size.width,
        height: 190,
        decoration: BoxDecoration(
          color: Colors.yellow[200],
          borderRadius: BorderRadius.circular(14),
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.30), BlendMode.multiply),
              image: FileImage(image),
              fit: BoxFit.cover),
        ),
      ),
      Positioned(
        bottom: 9.0,
        left: 9.0,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: GestureDetector(
              onTap: onclick,
              child: Icon(
                CupertinoIcons.photo,
                color: Colors.yellow,
              ),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 9.0,
        right: 9.0,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: GestureDetector(
              onTap: () {
                utilityNotifer
                    .addAllTypeFile(context: context)
                    .whenComplete(() {
                  provider.updateimageBlog(
                      context: context,
                      blog_id: widget.blogDetailArguments.id,
                      blog_image: utilityNotifer.imageURL);
                }).whenComplete(() => iconcontainer(
                        onclick: () async {
                          // await utilityNotifer
                          //     .deleteblogImage(
                          //         context: context,
                          //         url: widget.blogDetailArguments.blogImage)
                          //     .whenComplete(
                          //         () => utilityNotifer.pickblogimage(context));
                        },
                        context: context));
              },
              child: Icon(
                CupertinoIcons.cloud_upload,
                color: Colors.yellow,
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget iconcontainer({required onclick, required context}) {
    final provider = Provider.of<BlogNotifer>(context, listen: false);
    return FutureBuilder(
        future: provider.loadingBlogsDetail(
            context: context, detailid: widget.blogDetailArguments.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          } else {
            var blogdetialdata = snapshot.data as dynamic;
            Datadetails datadetails = blogdetialdata;
            return Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 190,
                decoration: BoxDecoration(
                    color: Colors.yellow[200],
                    borderRadius: BorderRadius.circular(14),
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.30), BlendMode.multiply),
                        image: NetworkImage(datadetails.blogImage.toString()),
                        fit: BoxFit.cover)),
              ),
              Positioned(
                bottom: 9.0,
                right: 9.0,
                child: InkWell(
                  onTap: onclick,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.delete,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                ),
              )
            ]);
          }
        });
  }

  Widget description({required text, required controller}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 190,
      decoration: BoxDecoration(
          color: Colors.yellow[200], borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          maxLines: null,
          style: TextStyle(color: Colors.black, fontSize: 17),
          decoration: new InputDecoration(
            border: InputBorder.none,
            labelText: text,
            labelStyle: TextStyle(color: Colors.black38),
          ),
        ),
      ),
    );
  }

  _openDatepicker(BuildContext context) async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: fristdate,
        lastDate: lastdate);

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }
}
