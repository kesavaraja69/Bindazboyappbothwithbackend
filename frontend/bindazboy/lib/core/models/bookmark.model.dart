import 'dart:convert';

Bookmark bookmarkFromJson(String str) => Bookmark.fromJson(json.decode(str));

String bookmarkToJson(Bookmark data) => json.encode(data.toJson());

class Bookmark {
  Bookmark(
    this.code,
    this.data,
  );

  int code;
  List<BookmarkData> data;

  factory Bookmark.fromJson(Map<String, dynamic> json) => Bookmark(
        json["code"],
        List<BookmarkData>.from(
            json["data"].map((x) => BookmarkData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BookmarkData {
  BookmarkData(
    this.bookmarkId,
    this.bookmarkBlogdata,
  );

  int bookmarkId;
  BookmarkBlogdata bookmarkBlogdata;

  factory BookmarkData.fromJson(Map<String, dynamic> json) => BookmarkData(
        json["bookmark_id"],
        BookmarkBlogdata.fromJson(json["bookmark_blogdata"]),
      );

  Map<String, dynamic> toJson() => {
        "bookmark_id": bookmarkId,
        "bookmark_blogdata": bookmarkBlogdata.toJson(),
      };
}

class BookmarkBlogdata {
  BookmarkBlogdata(
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

  factory BookmarkBlogdata.fromJson(Map<String, dynamic> json) =>
      BookmarkBlogdata(
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
