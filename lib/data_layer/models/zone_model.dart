/// zone_id : "3222"
/// name : "Kafr el-Sheikh Governorate"
/// zone_name : "كفر الشيخ"
/// zone_code : "KFS"

class ZoneModel {
  ZoneModel({
      String? zoneId, 
      String? name, 
      String? zoneName, 
      String? zoneCode,}){
    _zoneId = zoneId;
    _name = name;
    _zoneName = zoneName;
    _zoneCode = zoneCode;
}

  ZoneModel.fromJson(dynamic json) {
    _zoneId = json['zone_id'];
    _name = json['name'];
    _zoneName = json['zone_name'];
    _zoneCode = json['zone_code'];
  }
  String? _zoneId;
  String? _name;
  String? _zoneName;
  String? _zoneCode;

  String? get zoneId => _zoneId;
  String? get name => _name;
  String? get zoneName => _zoneName;
  String? get zoneCode => _zoneCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['zone_id'] = _zoneId;
    map['name'] = _name;
    map['zone_name'] = _zoneName;
    map['zone_code'] = _zoneCode;
    return map;
  }

}