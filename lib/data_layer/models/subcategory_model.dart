/// id : "1"
/// image : "http://marwaradwan.co/Subcategoris/625ecd3bb58651.png"
/// status : "1"
/// title : "asd"

class SubcategoryModel {
  SubcategoryModel({
    String? id,
    String? image,
    String? status,
    String? title,
  }) {
    _id = id;
    _image = image;
    _status = status;
    _title = title;
  }

  SubcategoryModel.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _status = json['status'];
    _title = json['title'];
  }
  String? _id;
  String? _image;
  String? _status;
  String? _title;
  SubcategoryModel copyWith({
    String? id,
    String? image,
    String? status,
    String? title,
  }) =>
      SubcategoryModel(
        id: id ?? _id,
        image: image ?? _image,
        status: status ?? _status,
        title: title ?? _title,
      );
  String? get id => _id;
  String? get image => _image;
  String? get status => _status;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['status'] = _status;
    map['title'] = _title;
    return map;
  }
}
