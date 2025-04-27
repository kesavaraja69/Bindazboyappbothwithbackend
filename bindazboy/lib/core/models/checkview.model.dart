class CheckLikeModel {
  final int? code;
  final String? data;
  final Message? message;
  final bool? isViewed;

  CheckLikeModel({
    this.code,
    this.data,
    this.message,
    this.isViewed,
  });

  CheckLikeModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        data = json['data'] as String?,
        message = (json['message'] as Map<String, dynamic>?) != null
            ? Message.fromJson(json['message'] as Map<String, dynamic>)
            : null,
        isViewed = json['isViewed'] as bool?;

  Map<String, dynamic> toJson() => {
        'code': code,
        'data': data,
        'message': message?.toJson(),
        'isViewed': isViewed
      };
}

class Message {
  final int? viewId;

  Message({
    this.viewId,
  });

  Message.fromJson(Map<String, dynamic> json)
      : viewId = json['view_id'] as int?;

  Map<String, dynamic> toJson() => {'view_id': viewId};
}
