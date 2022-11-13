import 'dart:convert';

BlogCatergory blogCatergoryFromJson(String str) =>
    BlogCatergory.fromJson(json.decode(str));

String blogCatergoryToJson(BlogCatergory data) => json.encode(data.toJson());

class BlogCatergory {
  BlogCatergory(
    this.received,
    this.data,
    this.code,
  );

  bool received;
  List<Data> data;
  int code;

  factory BlogCatergory.fromJson(Map<String, dynamic> json) => BlogCatergory(
        json["received"],
        List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        json["code"],
      );

  Map<String, dynamic> toJson() => {
        "received": received,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "code": code,
      };
}

class Data {
  Data(
    this.blogId,
    this.blogTitle,
    this.blogDescription,
    this.blogImage,
    this.blogCategory,
    this.blogView,
    this.blogAudio,
    this.blogDate,
  );

  int blogId;
  String blogTitle;
  String blogDescription;
  String blogImage;
  String blogCategory;
  String blogView;
  dynamic blogAudio;
  dynamic blogDate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        json["blog_id"],
        json["blog_title"],
        json["blog_description"],
        json["blog_image"],
        json["blog_category"],
        json["blog_view"],
        json["blog_audio"],
        json["blog_date"],
      );

  Map<String, dynamic> toJson() => {
        "blog_id": blogId,
        "blog_title": blogTitle,
        "blog_description": blogDescription,
        "blog_image": blogImage,
        "blog_category": blogCategory,
        "blog_view": blogView,
        "blog_audio": blogAudio,
        "blog_date": blogDate,
      };
}
