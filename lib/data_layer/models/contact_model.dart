/// id : "51"
/// name : "facebook_url"
/// value : "http://www.facebook.com"
/// created_at : "2018-04-27 00:00:00"
/// updated_at : "2022-04-26 02:48:59"

class ContactModel {
  ContactModel({
      String? id, 
      String? name, 
      String? value, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _value = value;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  ContactModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _value = json['value'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _name;
  String? _value;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;
  String? get name => _name;
  String? get value => _value;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['value'] = _value;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}