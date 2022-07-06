/// id : "2"
/// title : "stand 6"
/// 2dimage : "http://marwaradwan.co/stands/1650318675.jpg"

class StandModel {
  StandModel({
    String? id,
    String? title,
    String? dimage,
  }) {
    _id = id;
    _title = title;
    _dimage = dimage;
  }

  StandModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _dimage = json['2dimage'];
  }
  String? _id;
  String? _title;
  String? _dimage;
  StandModel copyWith({
    String? id,
    String? title,
    String? dimage,
  }) =>
      StandModel(
        id: id ?? _id,
        title: title ?? _title,
        dimage: dimage ?? _dimage,
      );
  String? get id => _id;
  String? get title => _title;
  String? get dimage => _dimage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['2dimage'] = _dimage;
    return map;
  }
}
