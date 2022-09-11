class AudioDetailwithChapter {
  final bool? received;
  final Dataadwch? data;
  final String? message;
  final int? code;

  AudioDetailwithChapter({
    this.received,
    this.data,
    this.message,
    this.code,
  });

  AudioDetailwithChapter.fromJson(Map<String, dynamic> json)
      : received = json['received'] as bool?,
        data = (json['data'] as Map<String, dynamic>?) != null
            ? Dataadwch.fromJson(json['data'] as Map<String, dynamic>)
            : null,
        message = json['message'] as String?,
        code = json['code'] as int?;

  Map<String, dynamic> toJson() => {
        'received': received,
        'data': data?.toJson(),
        'message': message,
        'code': code
      };
}

class Dataadwch {
  final int? audiobookId;
  final String? audiobookTitle;
  final String? audiobookDescription;
  final String? audiobookImagecover;
  final String? audiobookAuthor;
  final String? audiobookDate;
  final List<Audiochapter>? audiochapter;

  Dataadwch({
    this.audiobookId,
    this.audiobookTitle,
    this.audiobookDescription,
    this.audiobookImagecover,
    this.audiobookAuthor,
    this.audiobookDate,
    this.audiochapter,
  });

  Dataadwch.fromJson(Map<String, dynamic> json)
      : audiobookId = json['audiobook_id'] as int?,
        audiobookTitle = json['audiobook_title'] as String?,
        audiobookDescription = json['audiobook_description'] as String?,
        audiobookImagecover = json['audiobook_imagecover'] as String?,
        audiobookAuthor = json['audiobook_author'] as String?,
        audiobookDate = json['audiobook_date'] as String?,
        audiochapter = (json['audiochapter'] as List?)
            ?.map(
                (dynamic e) => Audiochapter.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'audiobook_id': audiobookId,
        'audiobook_title': audiobookTitle,
        'audiobook_description': audiobookDescription,
        'audiobook_imagecover': audiobookImagecover,
        'audiobook_author': audiobookAuthor,
        'audiobook_date': audiobookDate,
        'audiochapter': audiochapter?.map((e) => e.toJson()).toList()
      };
}

class Audiochapter {
  final int? audiobookchapterId;
  final String? audiobookchapterTitle;
  final String? audiobookchapterDescription;
  final String? audiobookchapterAudiourl;

  Audiochapter({
    this.audiobookchapterId,
    this.audiobookchapterTitle,
    this.audiobookchapterDescription,
    this.audiobookchapterAudiourl,
  });

  Audiochapter.fromJson(Map<String, dynamic> json)
      : audiobookchapterId = json['audiobookchapter_id'] as int?,
        audiobookchapterTitle = json['audiobookchapter_title'] as String?,
        audiobookchapterDescription =
            json['audiobookchapter_description'] as String?,
        audiobookchapterAudiourl = json['audiobookchapter_audiourl'] as String?;

  Map<String, dynamic> toJson() => {
        'audiobookchapter_id': audiobookchapterId,
        'audiobookchapter_title': audiobookchapterTitle,
        'audiobookchapter_description': audiobookchapterDescription,
        'audiobookchapter_audiourl': audiobookchapterAudiourl
      };
}
