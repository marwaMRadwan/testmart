/// flag : 1
/// category_id : "3"
/// user_id : "119"
/// is_updated : 0
/// market_id : "117"
/// notification_id : 9
/// title : "Order status update"
/// message : "Order status has been updated"
/// is_seen : 0
/// order_id : "179"

class FirebaseNotificationModel {
  FirebaseNotificationModel({
      int? flag, 
      String? categoryId, 
      String? userId, 
      int? isUpdated, 
      String? marketId, 
      int? notificationId, 
      String? title, 
      String? message, 
      int? isSeen, 
      String? orderId,}){
    _flag = flag;
    _categoryId = categoryId;
    _userId = userId;
    _isUpdated = isUpdated;
    _marketId = marketId;
    _notificationId = notificationId;
    _title = title;
    _message = message;
    _isSeen = isSeen;
    _orderId = orderId;
}

  FirebaseNotificationModel.fromJson(dynamic json) {
    _flag = json['flag'];
    _categoryId = json['category_id'];
    _userId = json['user_id'];
    _isUpdated = json['is_updated'];
    _marketId = json['market_id'];
    _notificationId = json['notification_id'];
    _title = json['title'];
    _message = json['message'];
    _isSeen = json['is_seen'];
    _orderId = json['order_id'];
  }
  int? _flag;
  String? _categoryId;
  String? _userId;
  int? _isUpdated;
  String? _marketId;
  int? _notificationId;
  String? _title;
  String? _message;
  int? _isSeen;
  String? _orderId;

  int? get flag => _flag;
  String? get categoryId => _categoryId;
  String? get userId => _userId;
  int? get isUpdated => _isUpdated;
  String? get marketId => _marketId;
  int? get notificationId => _notificationId;
  String? get title => _title;
  String? get message => _message;
  int? get isSeen => _isSeen;
  String? get orderId => _orderId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['flag'] = _flag;
    map['category_id'] = _categoryId;
    map['user_id'] = _userId;
    map['is_updated'] = _isUpdated;
    map['market_id'] = _marketId;
    map['notification_id'] = _notificationId;
    map['title'] = _title;
    map['message'] = _message;
    map['is_seen'] = _isSeen;
    map['order_id'] = _orderId;
    return map;
  }

}