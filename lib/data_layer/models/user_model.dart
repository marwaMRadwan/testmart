/// id : 119
/// role_id : "2"
/// user_name : "asd1_asd1"
/// first_name : "asd1"
/// last_name : "asd1"
/// gender : "male"
/// phone : "01141469882"
/// email : "asd1@asd.com"
/// fcm_token : "erQBC8v71Z_hTKpA5NxvxV:APA91bFU0Hk2oxggb0MKq9K81Fi6ueseVrVStdLYAy7li3pjIzKDcKBilMLWFI-gt9I0C4CX_yK6_DDwoTBkQrRXeJ_kDieRCfdFYV6_Ro1Np26nLqiOoQwH9q7ngDLs8lx_TRu8Rw_3"
/// country : "65"
/// country_code : "eg"
/// language : "4"
/// language_name : "ar"
/// language_code : "ar"
/// profileImage : "http://martizoom.com/"
/// dob : "2022/05/10"
/// viewSettings : "2d"
/// defaultAddress : {"id":"40","zone_id":"21","address":"aaa","location":"https://www.google.com/maps/place/30%C2%B005'09.4%22N+31%C2%B018'27.8%22E/@30.085952,31.3099097,17z/data=!3m1!4b1!4m6!3m5!1s0x0:0x0!7e2!8m2!3d30.085952!4d31.3077206"}

class UserModel {
  UserModel({
      int? id, 
      String? roleId, 
      String? userName, 
      String? firstName, 
      String? lastName, 
      String? gender, 
      String? phone, 
      String? email, 
      String? fcmToken, 
      String? country, 
      String? countryCode, 
      String? language, 
      String? languageName, 
      String? languageCode, 
      String? profileImage, 
      String? dob, 
      String? viewSettings, 
      DefaultAddress? defaultAddress,}){
    _id = id;
    _roleId = roleId;
    _userName = userName;
    _firstName = firstName;
    _lastName = lastName;
    _gender = gender;
    _phone = phone;
    _email = email;
    _fcmToken = fcmToken;
    _country = country;
    _countryCode = countryCode;
    _language = language;
    _languageName = languageName;
    _languageCode = languageCode;
    _profileImage = profileImage;
    _dob = dob;
    _viewSettings = viewSettings;
    _defaultAddress = defaultAddress;
}

  UserModel.fromJson(dynamic json) {
    _id = json['id'];
    _roleId = json['role_id'];
    _userName = json['user_name'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _gender = json['gender'];
    _phone = json['phone'];
    _email = json['email'];
    _fcmToken = json['fcm_token'];
    _country = json['country'];
    _countryCode = json['country_code'];
    _language = json['language'];
    _languageName = json['language_name'];
    _languageCode = json['language_code'];
    _profileImage = json['profileImage'];
    _dob = json['dob'];
    _viewSettings = json['viewSettings'];
    _defaultAddress = json['defaultAddress'] != null ? DefaultAddress.fromJson(json['defaultAddress']) : null;
  }
  int? _id;
  String? _roleId;
  String? _userName;
  String? _firstName;
  String? _lastName;
  String? _gender;
  String? _phone;
  String? _email;
  String? _fcmToken;
  String? _country;
  String? _countryCode;
  String? _language;
  String? _languageName;
  String? _languageCode;
  String? _profileImage;
  String? _dob;
  String? _viewSettings;
  DefaultAddress? _defaultAddress;

  int? get id => _id;
  String? get roleId => _roleId;
  String? get userName => _userName;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get gender => _gender;
  String? get phone => _phone;
  String? get email => _email;
  String? get fcmToken => _fcmToken;
  String? get country => _country;
  String? get countryCode => _countryCode;
  String? get language => _language;
  String? get languageName => _languageName;
  String? get languageCode => _languageCode;
  String? get profileImage => _profileImage;
  String? get dob => _dob;
  String? get viewSettings => _viewSettings;
  DefaultAddress? get defaultAddress => _defaultAddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['role_id'] = _roleId;
    map['user_name'] = _userName;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['gender'] = _gender;
    map['phone'] = _phone;
    map['email'] = _email;
    map['fcm_token'] = _fcmToken;
    map['country'] = _country;
    map['country_code'] = _countryCode;
    map['language'] = _language;
    map['language_name'] = _languageName;
    map['language_code'] = _languageCode;
    map['profileImage'] = _profileImage;
    map['dob'] = _dob;
    map['viewSettings'] = _viewSettings;
    if (_defaultAddress != null) {
      map['defaultAddress'] = _defaultAddress?.toJson();
    }
    return map;
  }

}

/// id : "40"
/// zone_id : "21"
/// address : "aaa"
/// location : "https://www.google.com/maps/place/30%C2%B005'09.4%22N+31%C2%B018'27.8%22E/@30.085952,31.3099097,17z/data=!3m1!4b1!4m6!3m5!1s0x0:0x0!7e2!8m2!3d30.085952!4d31.3077206"

class DefaultAddress {
  DefaultAddress({
      String? id, 
      String? zoneId, 
      String? address, 
      String? location,}){
    _id = id;
    _zoneId = zoneId;
    _address = address;
    _location = location;
}

  DefaultAddress.fromJson(dynamic json) {
    _id = json['id'];
    _zoneId = json['zone_id'];
    _address = json['address'];
    _location = json['location'];
  }
  String? _id;
  String? _zoneId;
  String? _address;
  String? _location;

  String? get id => _id;
  String? get zoneId => _zoneId;
  String? get address => _address;
  String? get location => _location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['zone_id'] = _zoneId;
    map['address'] = _address;
    map['location'] = _location;
    return map;
  }

}