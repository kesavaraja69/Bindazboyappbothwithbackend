class Imagespostmodel {
  final int? code;
  final String? message;
  final int? imagedatalength;
  final List<String>? data;
  final bool? recivied;

  Imagespostmodel({
    this.code,
    this.message,
    this.imagedatalength,
    this.data,
    this.recivied,
  });

  Imagespostmodel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        message = json['message'] as String?,
        imagedatalength = json['imagedatalength'] as int?,
        data =
            (json['data'] as List?)?.map((dynamic e) => e as String).toList(),
        recivied = json['recivied'] as bool?;

  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'imagedatalength': imagedatalength,
        'data': data,
        'recivied': recivied
      };
}
