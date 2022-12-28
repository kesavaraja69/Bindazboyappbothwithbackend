class Blogdetails {
  final Datadetails? data;
  final bool? received;
  final int? code;

  Blogdetails({
    this.data,
    this.received,
    this.code,
  });

  Blogdetails.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as Map<String, dynamic>?) != null
            ? Datadetails.fromJson(json['data'] as Map<String, dynamic>)
            : null,
        received = json['received'] as bool?,
        code = json['code'] as int?;

  Map<String, dynamic> toJson() =>
      {'data': data?.toJson(), 'received': received, 'code': code};
}

class Datadetails {
  final int? blogId;
  final String? blogTitle;
  final String? blogDescription;
  final String? blogImage;
  final String? blogView;
  final String? blogCategory;
  final String? blogAudio;
  final List<String>? blogImages;
  final String? blogDate;

  Datadetails({
    this.blogId,
    this.blogTitle,
    this.blogDescription,
    this.blogImage,
    this.blogView,
    this.blogCategory,
    this.blogAudio,
    this.blogImages,
    this.blogDate,
  });

  Datadetails.fromJson(Map<String, dynamic> json)
      : blogId = json['blog_id'] as int?,
        blogTitle = json['blog_title'] as String?,
        blogDescription = json['blog_description'] as String?,
        blogImage = json['blog_image'] as String?,
        blogView = json['blog_view'] as String?,
        blogCategory = json['blog_category'] as String?,
        blogAudio = json['blog_audio'] as String?,
        blogImages = (json['blog_images'] as List?)
            ?.map((dynamic e) => e as String)
            .toList(),
        blogDate = json['blog_date'] as String?;

  Map<String, dynamic> toJson() => {
        'blog_id': blogId,
        'blog_title': blogTitle,
        'blog_description': blogDescription,
        'blog_image': blogImage,
        'blog_view': blogView,
        'blog_category': blogCategory,
        'blog_audio': blogAudio,
        'blog_images': blogImages,
        'blog_date': blogDate
      };
}
