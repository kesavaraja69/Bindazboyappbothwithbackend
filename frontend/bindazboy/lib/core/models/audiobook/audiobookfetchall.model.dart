class AudioBookFetchAll {
  final bool? received;
  final List<Dataftadal>? data;
  final String? message;
  final int? code;

  AudioBookFetchAll({
    this.received,
    this.data,
    this.message,
    this.code,
  });

  AudioBookFetchAll.fromJson(Map<String, dynamic> json)
      : received = json['received'] as bool?,
        data = (json['data'] as List?)
            ?.map((dynamic e) => Dataftadal.fromJson(e as Map<String, dynamic>))
            .toList(),
        message = json['message'] as String?,
        code = json['code'] as int?;

  Map<String, dynamic> toJson() => {
        'received': received,
        'data': data?.map((e) => e.toJson()).toList(),
        'message': message,
        'code': code
      };
}

class Dataftadal {
  final int? audiobookId;
  final String? audiobookTitle;
  final String? audiobookDescription;
  final String? audiobookImagecover;
  final String? audiobookAuthor;
  final String? audiobookDate;

  Dataftadal({
    this.audiobookId,
    this.audiobookTitle,
    this.audiobookDescription,
    this.audiobookImagecover,
    this.audiobookAuthor,
    this.audiobookDate,
  });

  Dataftadal.fromJson(Map<String, dynamic> json)
      : audiobookId = json['audiobook_id'] as int?,
        audiobookTitle = json['audiobook_title'] as String?,
        audiobookDescription = json['audiobook_description'] as String?,
        audiobookImagecover = json['audiobook_imagecover'] as String?,
        audiobookAuthor = json['audiobook_author'] as String?,
        audiobookDate = json['audiobook_date'] as String?;

  Map<String, dynamic> toJson() => {
        'audiobook_id': audiobookId,
        'audiobook_title': audiobookTitle,
        'audiobook_description': audiobookDescription,
        'audiobook_imagecover': audiobookImagecover,
        'audiobook_author': audiobookAuthor,
        'audiobook_date': audiobookDate
      };
}
