import 'dart:convert';

Searchblog searchblogFromJson(String str) =>
    Searchblog.fromJson(json.decode(str));

String searchblogToJson(Searchblog data) => json.encode(data.toJson());

class Searchblog {
  Searchblog(
    this.code,
    this.data,
  );

  int code;
  List<Searchdata> data;

  factory Searchblog.fromJson(Map<String, dynamic> json) => Searchblog(
        json["code"],
        List<Searchdata>.from(json["data"].map((x) => Searchdata.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Searchdata {
  Searchdata(
    this.blogId,
    this.blogTitle,
    this.blogDescription,
    this.blogImage,
    this.blogCategory,
    this.blogAudio,
    this.blogDate,
  );

  int blogId;
  String blogTitle;
  String blogDescription;
  String blogImage;
  String blogCategory;
  dynamic blogAudio;
  dynamic blogDate;

  factory Searchdata.fromJson(Map<String, dynamic> json) => Searchdata(
        json["blog_id"],
        json["blog_title"],
        json["blog_description"],
        json["blog_image"],
        json["blog_category"],
        json["blog_audio"],
        json["blog_date"],
      );

  Map<String, dynamic> toJson() => {
        "blog_id": blogId,
        "blog_title": blogTitle,
        "blog_description": blogDescription,
        "blog_image": blogImage,
        "blog_category": blogCategory,
        "blog_audio": blogAudio,
        "blog_date": blogDate,
      };
}
