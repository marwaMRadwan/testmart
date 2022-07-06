/// name : "MartizoomUserMobile"
/// email : "asd@aas"
/// phone : "01546"
/// message : "Message Mobile goes here!"

class ContactMessageModel {
  ContactMessageModel({
      String? name, 
      String? email, 
      String? phone, 
      String? message,}){
    _name = name;
    _email = email;
    _phone = phone;
    _message = message;
}

  ContactMessageModel.fromJson(dynamic json) {
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _message = json['message'];
  }
  String? _name;
  String? _email;
  String? _phone;
  String? _message;

  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['email'] = _email;
    map['phone'] = _phone;
    map['message'] = _message;
    return map;
  }

}