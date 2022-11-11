class FetchLike {
  FetchLike({
    required this.code,
    required this.data,
  });
  late final int code;
  late final List<Datafl> data;

  FetchLike.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = List.from(json['data']).map((e) => Datafl.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Datafl {
  Datafl({
    required this.likeId,
    required this.likeDate,
  });
  late final int likeId;
  late final String likeDate;

  Datafl.fromJson(Map<String, dynamic> json) {
    likeId = json['like_id'];
    likeDate = json['like_date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['like_id'] = likeId;
    _data['like_date'] = likeDate;
    return _data;
  }
}
