/// id : "29"
/// user_id : "99"
/// zone_id : "19"
/// is_default : "1"
/// additionalAddressInfo : "asd"
/// location : "https://www.google.com/maps/place/30%C2%B005'09.4%22N+31%C2%B018'27.8%22E/@30.085952,31.3099097,17z/data=!3m1!4b1!4m6!3m5!1s0x0:0x0!7e2!8m2!3d30.085952!4d31.3077206"
/// governorate : "asd"
/// neighbourHood : "asd"
/// street : "asd"
/// building : "asd"
/// floor : "asd"
/// apartment : "asd"
/// addressNieckName : "asd"
/// address_book_id : "0"
/// flag : "0"
/// gov_id : "3222"
/// zone_name : "Plav Municipality"

class AddressModel {
  AddressModel({
    String? id,
    String? userId,
    String? zoneId,
    String? isDefault,
    String? additionalAddressInfo,
    String? location,
    String? neighbourHood,
    String? street,
    String? building,
    String? floor,
    String? apartment,
    String? addressNieckName,
    String? addressBookId,
    String? flag,
    String? govId,
    String? zoneName,
  }) {
    _id = id;
    _userId = userId;
    _zoneId = zoneId;
    _isDefault = isDefault;
    _additionalAddressInfo = additionalAddressInfo;
    _location = location;
    _neighbourHood = neighbourHood;
    _street = street;
    _building = building;
    _floor = floor;
    _apartment = apartment;
    _addressNieckName = addressNieckName;
    _addressBookId = addressBookId;
    _flag = flag;
    _govId = govId;
    _zoneName = zoneName;
  }

  AddressModel.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _zoneId = json['zone_id'];
    _isDefault = json['is_default'];
    _additionalAddressInfo = json['address'];
    _location = json['location'];
    _neighbourHood = json['neighbourHood'];
    _street = json['street'];
    _building = json['building'];
    _floor = json['floor'];
    _apartment = json['apartment'];
    _addressNieckName = json['addressNieckName'];
    _addressBookId = json['address_book_id'];
    _flag = json['flag'];
    _govId = json['gov_id'];
    _zoneName = json['zone_name'];
  }

  String? _id;
  String? _userId;
  String? _zoneId;
  String? _isDefault;
  String? _additionalAddressInfo;
  String? _location;
  String? _neighbourHood;
  String? _street;
  String? _building;
  String? _floor;
  String? _apartment;
  String? _addressNieckName;
  String? _addressBookId;
  String? _flag;
  String? _govId;
  String? _zoneName;

  String? get id => _id;

  String? get userId => _userId;

  String? get zoneId => _zoneId;

  String? get isDefault => _isDefault;

  String? get additionalAddressInfo => _additionalAddressInfo;

  String? get location => _location;

  String? get neighbourHood => _neighbourHood;

  String? get street => _street;

  String? get building => _building;

  String? get floor => _floor;

  String? get apartment => _apartment;

  String? get addressNieckName => _addressNieckName;

  String? get addressBookId => _addressBookId;

  String? get flag => _flag;

  String? get govId => _govId;

  String? get zoneName => _zoneName;

  set isDefault(String? value) => _isDefault = value;

  set zoneId(String? value) => _zoneId = value;

  set location(String? value) => _location = value;

  set neighbourHood(String? value) => _neighbourHood = value;

  set street(String? value) => _street = value;

  set building(String? value) => _building = value;

  set floor(String? value) => _floor = value;

  set apartment(String? value) => _apartment = value;

  set addressNieckName(String? value) => _addressNieckName = value;

  set additionalAddressInfo(String? value) => _additionalAddressInfo = value;

  set govId(String? value) => _govId = value;

  Map<String, dynamic> toUpdateJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['zone_id'] = _zoneId;
    map['is_default'] = _isDefault;
    map['location'] = _location;
    map['neighbourHood'] = _neighbourHood;
    map['street'] = _street;
    map['building'] = _building;
    map['floor'] = _floor;
    map['apartment'] = _apartment;
    map['addressNieckName'] = _addressNieckName;
    map['additionalAddressInfo'] = _additionalAddressInfo;
    map['address_book_id'] = _addressBookId;
    map['flag'] = _flag;
    map['gov_id'] = _govId;
    map['zone_name'] = _zoneName;
    return map;
  }

  Map<String, dynamic> toAddJson() {
    final map = <String, dynamic>{};
    map['zone_id'] = _zoneId;
    map['is_default'] = _isDefault;
    map['location'] = _location;
    map['neighbourHood'] = _neighbourHood;
    map['street'] = _street;
    map['building'] = _building;
    map['floor'] = _floor;
    map['apartment'] = _apartment;
    map['addressNieckName'] = _addressNieckName;
    map['additionalAddressInfo'] = _additionalAddressInfo;
    map['address_book_id'] = _addressBookId;
    map['flag'] = _flag;
    map['gov_id'] = _govId;
    map['zone_name'] = _zoneName;
    return map;
  }
}
