/// id : 20
/// name : "Debra Shannon"
/// slug : "debra-shannon"
/// image : "https://marwaradwan.co/categories/images/16495385281047252520.png"
/// icon : "https://marwaradwan.co/categories/icons/1649538528384257463.png"
/// theme : "0"
/// color : null

class CategoryModel {
  CategoryModel({
    int? id,
    String? name,
    String? slug,
    String? image,
    String? icon,
    String? theme,
    dynamic color,
  }) {
    _id = id;
    _name = name;
    _slug = slug;
    _image = image;
    _icon = icon;
    _theme = theme;
    _color = color;
  }

  CategoryModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _image = json['image'];
    _icon = json['icon'];
    _theme = json['theme'];
    _color = json['color'];
  }
  int? _id;
  String? _name;
  String? _slug;
  String? _image;
  String? _icon;
  String? _theme;
  dynamic _color;

  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  String? get image => _image;
  String? get icon => _icon;
  String? get theme => _theme;
  dynamic get color => _color;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    map['image'] = _image;
    map['icon'] = _icon;
    map['theme'] = _theme;
    map['color'] = _color;
    return map;
  }
}
