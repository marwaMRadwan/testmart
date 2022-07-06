class UpdateUserModel {
  UpdateUserModel({
    String? firstName,
    String? lastName,
    String? gender,
    String? phone,
    String? email,
    String? dob,
  }) {
    _firstName = firstName;
    _lastName = lastName;
    _gender = gender;
    _telePhone = phone;
    _email = email;
    _dob = dob;
  }

  String? _firstName;
  String? _lastName;
  String? _email;
  String? _dob;
  String? _gender;
  String? _telePhone;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get gender => _gender;

  dynamic get phone => _telePhone;

  String? get email => _email;

  String? get dob => _dob;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstname'] = _firstName;
    map['lastname'] = _lastName;
    map['gender'] = _gender;
    map['telephone'] = _telePhone;
    map['email'] = _email;
    map['dob'] = _dob;
    return map;
  }
}
