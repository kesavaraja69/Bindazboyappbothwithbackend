class BlogDetailArguments {
  final dynamic id;
  final dynamic blogTitle;
  final dynamic blogDescription;
  final dynamic blogCategroy;
  final dynamic blogDate;
  final dynamic blogImage;
  final String? blog_audio;
  final List<String>? blogImages;

  const BlogDetailArguments(
      {required this.blogTitle,
      required this.blogDescription,
      required this.blogCategroy,
      required this.blogDate,
      required this.blogImage,
      required this.id,
      required this.blog_audio,
      required this.blogImages});
}
