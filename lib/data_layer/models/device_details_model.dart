/// MacAddress : "1233.222.45558Ac"
/// Language : 1
/// country : 33

class DeviceDetailsModel {
  DeviceDetailsModel({
    String? macAddress,
    String? language,
    String? country,
  }) {
    _macAddress = macAddress;
    _language = language;
    _country = country;
  }

  DeviceDetailsModel.fromJson(dynamic json) {
    _macAddress = json['MacAddress'];
    _language = json['Language'];
    _country = json['country'];
  }
  String? _macAddress;
  String? _language;
  String? _country;

  String? get macAddress => _macAddress;
  String? get language => _language;
  String? get country => _country;

  set macAddress(String? value) => _macAddress = value;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['MacAddress'] = _macAddress;
    map['Language'] = _language;
    map['country'] = _country;
    return map;
  }
}
