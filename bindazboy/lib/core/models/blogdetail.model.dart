// To parse this JSON data, do
//
//     final blogdetails = blogdetailsFromJson(jsonString);

import 'dart:convert';

Blogdetails blogdetailsFromJson(String str) =>
    Blogdetails.fromJson(json.decode(str));

String blogdetailsToJson(Blogdetails data) => json.encode(data.toJson());

class Blogdetails {
  Datadetails data;
  bool received;
  int code;

  Blogdetails(this.data, this.received, this.code);

  factory Blogdetails.fromJson(Map<String, dynamic> json) => Blogdetails(
    Datadetails.fromJson(json["data"]),
    json["received"],
    json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "received": received,
    "code": code,
  };
}

class Datadetails {
  Datadetails(
    this.blogId,
    this.blogTitle,
    this.blogDescription,
    this.blogImage,
    this.blogCategory,
    this.blogView,
    this.blogDate, [
    this.blogAudio,
    this.blogImages,
  ]);

  int blogId;
  String blogTitle;
  String blogDescription;
  String blogImage;
  String blogCategory;
  String blogView;
  dynamic blogDate;
  String? blogAudio;
  List<String>? blogImages;

  factory Datadetails.fromJson(Map<String, dynamic> json) => Datadetails(
    json["blog_id"],
    json["blog_title"],
    json["blog_description"],
    json["blog_image"],
    json["blog_category"],
    json["blog_view"],
    json["blog_date"],
    json["blog_audio"],
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
    "blog_view": blogView,
    "blog_date": blogDate.toString().split('').reversed.join(),
    "blog_audio": blogAudio,
    "blog_images":
        blogImages == null
            ? null
            : List<dynamic>.from(blogImages!.map((x) => x)),
  };
}
