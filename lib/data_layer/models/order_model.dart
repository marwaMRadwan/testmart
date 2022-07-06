/// orders_id : "155"
/// market_id : "62"
/// customers_name : "Nouran Ahmed"
/// email : "nouran@gmail.com"
/// total_price : 185
/// governorateName : "Kafr el-Sheikh Governorate"
/// cityName : "Desouk"
/// orders_status : "Pending"

class OrderModel {
  OrderModel({
      String? ordersId, 
      String? marketId, 
      String? customersName, 
      String? email, 
      int? totalPrice, 
      String? governorateName, 
      String? cityName, 
      String? ordersStatus,}){
    _ordersId = ordersId;
    _marketId = marketId;
    _customersName = customersName;
    _email = email;
    _totalPrice = totalPrice;
    _governorateName = governorateName;
    _cityName = cityName;
    _ordersStatus = ordersStatus;
}

  OrderModel.fromJson(dynamic json) {
    _ordersId = json['orders_id'];
    _marketId = json['market_id'];
    _customersName = json['customers_name'];
    _email = json['email'];
    _totalPrice = json['total_price'];
    _governorateName = json['governorateName'];
    _cityName = json['cityName'];
    _ordersStatus = json['orders_status'];
  }
  String? _ordersId;
  String? _marketId;
  String? _customersName;
  String? _email;
  int? _totalPrice;
  String? _governorateName;
  String? _cityName;
  String? _ordersStatus;

  String? get ordersId => _ordersId;
  String? get marketId => _marketId;
  String? get customersName => _customersName;
  String? get email => _email;
  int? get totalPrice => _totalPrice;
  String? get governorateName => _governorateName;
  String? get cityName => _cityName;
  String? get ordersStatus => _ordersStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orders_id'] = _ordersId;
    map['market_id'] = _marketId;
    map['customers_name'] = _customersName;
    map['email'] = _email;
    map['total_price'] = _totalPrice;
    map['governorateName'] = _governorateName;
    map['cityName'] = _cityName;
    map['orders_status'] = _ordersStatus;
    return map;
  }

}