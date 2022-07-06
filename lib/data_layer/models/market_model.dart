/// id : "117"
/// Name : "Metro"
/// image : "http://martizoom.com/adminImages/1650889525.png"
/// is_open : 0

class MarketModel {
  MarketModel({
      String? id, 
      String? name, 
      String? image, 
      int? isOpen,}){
    _id = id;
    _name = name;
    _image = image;
    _isOpen = isOpen;
}

  MarketModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['Name'];
    _image = json['image'];
    _isOpen = json['is_open'];
  }
  String? _id;
  String? _name;
  String? _image;
  int? _isOpen;

  String? get id => _id;
  String? get name => _name;
  String? get image => _image;
  int? get isOpen => _isOpen;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['Name'] = _name;
    map['image'] = _image;
    map['is_open'] = _isOpen;
    return map;
  }

}