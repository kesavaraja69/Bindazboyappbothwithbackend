import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/core/notifiers/blogs.notifier.dart';
import 'package:bindazboy/meta/views/searchpage/components/searchblogcardlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBlogview extends StatefulWidget {
  const SearchBlogview({super.key});

  @override
  _SearchBlogviewState createState() => _SearchBlogviewState();
}

class _SearchBlogviewState extends State<SearchBlogview> {
  late TextEditingController _titletext;
  bool isSearchdata = false;
  late Future<dynamic> data1;

  @override
  void initState() {
    _titletext = TextEditingController();
    super.initState();
  }

  loadblog() {
    //Data fullscreendata = widget.snapshot;

    final provider = Provider.of<BlogNotifer>(context, listen: false);
    final data = provider.searchBlog(context: context, query: _titletext.text);
    return data;
  }

  @override
  void dispose() {
    _titletext.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: BConstantColors.backgroundColor,
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Search",
                      style: TextStyle(
                        color: BConstantColors.appbartitleColor,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: title(
                  text: "Search here",
                  controller: _titletext,
                  onclik: () {
                    if (_titletext.text.isNotEmpty) {
                      setState(() {
                        isSearchdata = true;
                        data1 = loadblog();
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                child:
                    isSearchdata
                        ? SearchBlogcardlist(query: data1)
                        : Center(
                          child: Text(
                            "Search Post",
                            style: TextStyle(
                              fontSize: 17,
                              color: BConstantColors.fullblack,
                            ),
                          ),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget title({required text, required controller, required onclik}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: BConstantColors.yellow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9),
        child: Center(
          child: TextFormField(
            controller: controller,
            maxLines: 1,
            onChanged: (value) {
              if (_titletext.text.isNotEmpty) {
                isSearchdata = true;
                setState(() {
                  data1 = loadblog();
                });
              } else {
                setState(() {
                  isSearchdata = false;
                });
              }
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: text,
              suffixIcon: InkWell(
                onTap: onclik,
                child: Icon(
                  Icons.search_outlined,
                  size: 26,
                  color: BConstantColors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
