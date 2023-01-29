import 'dart:convert';

Blogs blogsFromJson(String str) => Blogs.fromJson(json.decode(str));

String blogsToJson(Blogs data) => json.encode(data.toJson());

class Blogs {
  Blogs(
    this.received,
    this.data,
    this.code,
    this.totalcount,
  );

  bool received;
  List<Data> data;
  int code;
  int totalcount;

  factory Blogs.fromJson(Map<String, dynamic> json) => Blogs(
      json["received"],
      List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      json["code"],
      json["totalcount"]);

  Map<String, dynamic> toJson() => {
        "received": received,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "code": code,
        "totalcount": totalcount,
      };
}

class Data {
  Data(
    this.blogId,
    this.blogTitle,
    this.blogDescription,
    this.blogImage,
    this.blogCategory,
    this.blogDate, [
    this.blogAudio,
    this.blogImages,
  ]);

  int blogId;
  String blogTitle;
  String blogDescription;
  String blogImage;
  String blogCategory;
  dynamic blogDate;
  String? blogAudio;
  List<String>? blogImages;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        json["blog_id"],
        json["blog_title"],
        json["blog_description"],
        json["blog_image"],
        json["blog_category"],
        json["blog_date"],
        json["blog_audio"] == null ? null : json["blog_audio"],
        json["blog_images"] == null
            ? null
            : List<String>.from(json["blog_images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "blog_id": blogId,
        "blog_title": blogTitle,
        "blog_description": blogDescription,
        "blog_image": blogImage,
        "blog_category": blogCategory,
        "blog_date": blogDate,
        "blog_audio": blogAudio == null ? null : blogAudio,
        "blog_images": blogImages == null
            ? null
            : List<dynamic>.from(blogImages!.map((x) => x)),
      };
}
