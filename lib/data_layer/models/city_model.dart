/// id : "20"
/// name : "Desouk"

class CityModel {
  CityModel({
    String? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  CityModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;

  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}
