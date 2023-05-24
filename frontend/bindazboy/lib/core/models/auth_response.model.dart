class AuthResponse {
  final String? user;
  final dynamic authentication;
  final String? message;
  final int? code;

  AuthResponse({
    this.user,
    this.authentication,
    this.message,
    this.code,
  });

  AuthResponse.fromJson(Map<String, dynamic> json)
      : user = json['user'] as String?,
        authentication = json['authentication'] as dynamic,
        message = json['message'] as String?,
        code = json['code'] as int?;

  Map<String, dynamic> toJson() => {
        'user': user,
        'authentication': authentication,
        'message': message,
        'code': code
      };
}
