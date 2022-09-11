import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/meta/views/searchpage/components/searchblogcardlist.dart';
import 'package:flutter/material.dart';

class SearchBlogview extends StatefulWidget {
  SearchBlogview({Key? key}) : super(key: key);

  @override
  _SearchBlogviewState createState() => _SearchBlogviewState();
}

class _SearchBlogviewState extends State<SearchBlogview> {
  TextEditingController _titletext = TextEditingController();
  bool isSearchdata = false;
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
                    child: Text("Search",
                        style: TextStyle(
                            color: BConstantColors.appbartitleColor,
                            fontSize: 23,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: title(
                  text: "Search here",
                  controller: _titletext,
                  onclik: () {
                    if (_titletext.text.isNotEmpty) {
                      setState(() {
                        isSearchdata = true;
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: isSearchdata
                    ? SearchBlogcardlist(query: _titletext.text)
                    : Center(
                        child: Text(
                          "Search Post",
                          style: TextStyle(
                              fontSize: 17, color: BConstantColors.fullblack),
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
      height: 55,
      decoration: BoxDecoration(
          color: BConstantColors.yellow,
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          maxLines: 2,
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
              )),
        ),
      ),
    );
  }
}
