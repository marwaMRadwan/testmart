/// id : "53"
/// title : "Order status update"
/// message : "Order status has been updated"
/// user_id : "125"
/// category_id : "3"
/// market_id : "117"
/// is_seen : "0"
/// is_updated : "0"
/// flag : "1"
/// created_at : "0000-00-00 00:00:00"
/// updated_at : "0000-00-00 00:00:00"
/// order_id : "185"
/// theme : "0"
/// categories_name : "Herbs and spices"

class BackendNotificationModel {
  BackendNotificationModel({
    String? id,
    String? title,
    String? message,
    String? userId,
    String? categoryId,
    String? marketId,
    String? isSeen,
    String? isUpdated,
    String? flag,
    String? createdAt,
    String? updatedAt,
    String? orderId,
    String? theme,
    String? categoriesName,
  }) {
    _id = id;
    _title = title;
    _message = message;
    _userId = userId;
    _categoryId = categoryId;
    _marketId = marketId;
    _isSeen = isSeen;
    _isUpdated = isUpdated;
    _flag = flag;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _orderId = orderId;
    _theme = theme;
    _categoriesName = categoriesName;
  }

  BackendNotificationModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _message = json['message'];
    _userId = json['user_id'];
    _categoryId = json['category_id'];
    _marketId = json['market_id'];
    _isSeen = json['is_seen'];
    _isUpdated = json['is_updated'];
    _flag = json['flag'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _orderId = json['order_id'];
    _theme = json['theme'];
    _categoriesName = json['categories_name'];
  }
  String? _id;
  String? _title;
  String? _message;
  String? _userId;
  String? _categoryId;
  String? _marketId;
  String? _isSeen;
  String? _isUpdated;
  String? _flag;
  String? _createdAt;
  String? _updatedAt;
  String? _orderId;
  String? _theme;
  String? _categoriesName;

  String? get id => _id;
  String? get title => _title;
  String? get message => _message;
  String? get userId => _userId;
  String? get categoryId => _categoryId;
  String? get marketId => _marketId;
  String? get isSeen => _isSeen;
  String? get isUpdated => _isUpdated;
  String? get flag => _flag;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get orderId => _orderId;
  String? get theme => _theme;
  String? get categoriesName => _categoriesName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['message'] = _message;
    map['user_id'] = _userId;
    map['category_id'] = _categoryId;
    map['market_id'] = _marketId;
    map['is_seen'] = _isSeen;
    map['is_updated'] = _isUpdated;
    map['flag'] = _flag;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['order_id'] = _orderId;
    map['theme'] = _theme;
    map['categories_name'] = _categoriesName;
    return map;
  }
}
