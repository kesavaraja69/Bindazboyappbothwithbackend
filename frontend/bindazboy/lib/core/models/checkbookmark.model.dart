import 'dart:convert';

CheckBookmark checkBookmarkFromJson(String str) =>
    CheckBookmark.fromJson(json.decode(str));

String checkBookmarkToJson(CheckBookmark data) => json.encode(data.toJson());

class CheckBookmark {
  CheckBookmark(
    this.code,
    this.bookmarked,
  );

  int code;
  bool bookmarked;

  factory CheckBookmark.fromJson(Map<String, dynamic> json) => CheckBookmark(
        json["code"],
        json["bookmarked"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "bookmarked": bookmarked,
      };
}
