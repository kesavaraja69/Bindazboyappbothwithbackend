import 'dart:convert';

CategorybyBlogs categorybyBlogsFromJson(String str) =>
    CategorybyBlogs.fromJson(json.decode(str));

String categorybyBlogsToJson(CategorybyBlogs data) =>
    json.encode(data.toJson());

class CategorybyBlogs {
  CategorybyBlogs(
    this.data,
    this.code,
    this.received,
  );

  List<DataBlog> data;
  int code;
  bool received;

  factory CategorybyBlogs.fromJson(Map<String, dynamic> json) =>
      CategorybyBlogs(
        List<DataBlog>.from(json["data"].map((x) => DataBlog.fromJson(x))),
        json["code"],
        json["received"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "code": code,
        "received": received,
      };
}

class DataBlog {
  DataBlog(
    this.catergoryId,
    this.catergoryTitle,
    this.blogs,
  );

  int catergoryId;
  String catergoryTitle;
  List<Blog> blogs;

  factory DataBlog.fromJson(Map<String, dynamic> json) => DataBlog(
        json["catergory_id"],
        json["catergory_title"],
        List<Blog>.from(json["blogs"].map((x) => Blog.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "catergory_id": catergoryId,
        "catergory_title": catergoryTitle,
        "blogs": List<dynamic>.from(blogs.map((x) => x.toJson())),
      };
}

class Blog {
  Blog(
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

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
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
