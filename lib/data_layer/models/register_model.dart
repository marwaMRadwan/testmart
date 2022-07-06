/// firstName : "asd"
/// lastName : "asd"
/// gender : "male"
/// email : "asd@asd.com"
/// password : "123456"
/// re_password : "123456"
/// MacAddress : "1233.222.45558Ac"

class RegisterModel {
  RegisterModel({
    String? firstName,
    String? lastName,
    String? gender,
    String? email,
    String? password,
    String? phone,
    String? macAddress,
  }) {
    _firstName = firstName;
    _lastName = lastName;
    _gender = gender;
    _email = email;
    _password = password;
    _phone = phone;
    _macAddress = macAddress;
  }

  RegisterModel.fromJson(dynamic json) {
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _gender = json['gender'];
    _email = json['email'];
    _password = json['password'];
    _phone = json['re_password'];
    _macAddress = json['MacAddress'];
  }

  String? _firstName;
  String? _lastName;
  String? _gender;
  String? _email;
  String? _password;
  String? _phone;
  String? _macAddress;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get gender => _gender;

  String? get email => _email;

  String? get password => _password;

  String? get phone => _phone;

  String? get macAddress => _macAddress;

  set macAddress(String? value) => _macAddress = value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['email'] = _email;
    map['password'] = _password;
    map['re_password'] = _password;
    map['telephone'] = _phone;
    map['MacAddress'] = _macAddress;
    return map;
  }
}
