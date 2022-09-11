import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category(
    this.data,
    this.code,
    this.received,
  );

  List<Data> data;
  int code;
  bool received;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        json["code"],
        json["received"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "code": code,
        "received": received,
      };
}

class Data {
  Data(
    this.catergoryId,
    this.catergoryTitle,
  );

  int catergoryId;
  String catergoryTitle;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        json["catergory_id"],
        json["catergory_title"],
      );

  Map<String, dynamic> toJson() => {
        "catergory_id": catergoryId,
        "catergory_title": catergoryTitle,
      };
}
