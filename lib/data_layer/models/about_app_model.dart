/// title : "Privacy Policy"
/// content : "Privacy Policy agreements inform users what information is collected from them. This includes information users voluntarily and actively provide when they register to use services, as well as information that may be collected from them automatically, such as through the use of cookies.\r\n\r\nYou can define how you classify information e.g. public, private, or personal information. This helps the user know exactly what these terms means in the rest of the Privacy Policy document."

class AboutAppInfoModel {
  AboutAppInfoModel({
    String? title,
    String? content,
  }) {
    _title = title;
    _content = content;
  }

  AboutAppInfoModel.fromJson(dynamic json) {
    _title = json['title'];
    _content = json['content'];
  }

  String? _title;
  String? _content;

  String? get title => _title;

  String? get content => _content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['content'] = _content;
    return map;
  }
}
