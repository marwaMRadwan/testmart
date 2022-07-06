class LanguageModel {
  LanguageModel({
    String? languagesId,
    String? name,
    String? code,
  }) {
    _languagesId = languagesId;
    _name = name;
    _code = code;
  }

  LanguageModel.fromJson(dynamic json) {
    _languagesId = json['languages_id'];
    _name = json['name'];
    _code = json['code'];
  }
  String? _languagesId;
  String? _name;
  String? _code;

  String? get languagesId => _languagesId;
  String? get name => _name;
  String? get code => _code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['languages_id'] = _languagesId;
    map['name'] = _name;
    map['code'] = _code;
    return map;
  }
}
