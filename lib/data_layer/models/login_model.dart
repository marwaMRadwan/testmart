/// access_token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vdGVjaHNleHBlcnRzLnNpdGUvYXBpL2F1dGgvTG9naW4iLCJpYXQiOjE2NDc4NzIyMjQsIm5iZiI6MTY0Nzg3MjIyNCwianRpIjoiMGlUbU5IaW5taDVQTU9IUyIsInN1YiI6NjAsInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.1eIhHFF1GyVRKJGZDEg42QFSYta9WFSgb-aANRVl68U"
/// country : "65"
/// language : "1"
/// token_type : "bearer"

class LoginModel {
  LoginModel({
    String? accessToken,
    String? country,
    String? language,
    String? tokenType,
  }) {
    _accessToken = accessToken;
    _country = country;
    _language = language;
    _tokenType = tokenType;
  }

  LoginModel.fromJson(dynamic json) {
    _accessToken = json['access_token'];
    _country = json['country'];
    _language = json['language'];
    _tokenType = json['token_type'];
  }
  String? _accessToken;
  String? _country;
  String? _language;
  String? _tokenType;

  String? get accessToken => _accessToken;
  String? get country => _country;
  String? get language => _language;
  String? get tokenType => _tokenType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = _accessToken;
    map['country'] = _country;
    map['language'] = _language;
    map['token_type'] = _tokenType;
    return map;
  }
}
