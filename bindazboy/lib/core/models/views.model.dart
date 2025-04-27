class FetchLike {
  FetchLike({required this.code, required this.data});

  final int code;
  final List<Datafl> data;

  factory FetchLike.fromJson(Map<String, dynamic> json) {
    return FetchLike(
      code: json['code'],
      data:
          (json['data'] as List<dynamic>)
              .map((e) => Datafl.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'data': data.map((e) => e.toJson()).toList()};
  }
}

class Datafl {
  Datafl({required this.likeId, required this.likeDate});

  final int likeId;
  final String likeDate;

  factory Datafl.fromJson(Map<String, dynamic> json) {
    return Datafl(likeId: json['like_id'], likeDate: json['like_date']);
  }

  Map<String, dynamic> toJson() {
    return {'like_id': likeId, 'like_date': likeDate};
  }
}
