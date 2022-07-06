/// orders_id : "175"
/// market_id : "59"
/// customers_name : "asd2 asd2"
/// email : "asd2@asd.com"
/// products_price : 150
/// shipping_price : 50
/// copoun : false
/// copounValue : 0
/// total_price : 200
/// governorateName : "Kafr el-Sheikh Governorate"
/// cityName : "Batltiem"
/// completed : 0
/// is_canceled : 0
/// statusess : [{"status":"Pending","date_added":"2022-04-25 09:21:10"},{"status":"Completed","date_added":null},{"status":"Cancel","date_added":null},{"status":"Return","date_added":null},{"status":"Inprocess","date_added":null},{"status":"Online","date_added":null},{"status":"Free for Delivery","date_added":null},{"status":"Online Busy With Delivery","date_added":null},{"status":"Offline","date_added":null},{"status":"Delivered","date_added":null}]
/// products : [{"orders_products_id":"162","orders_id":"175","products_id":"37","products_model":null,"products_name":"product 1","products_price":"50.00","final_price":"150.00","products_tax":"0","products_quantity":"3","model":null}]

class SingleOrderModel {
  SingleOrderModel({
    String? ordersId,
    String? marketId,
    String? customersName,
    String? email,
    int? productsPrice,
    int? shippingPrice,
    bool? copoun,
    int? copounValue,
    int? totalPrice,
    String? governorateName,
    String? cityName,
    int? completed,
    int? isCanceled,
    List<Statusess>? statusess,
    List<OrderProductModel>? products,
  }) {
    _ordersId = ordersId;
    _marketId = marketId;
    _customersName = customersName;
    _email = email;
    _productsPrice = productsPrice;
    _shippingPrice = shippingPrice;
    _copoun = copoun;
    _copounValue = copounValue;
    _totalPrice = totalPrice;
    _governorateName = governorateName;
    _cityName = cityName;
    _completed = completed;
    _isCanceled = isCanceled;
    _statusess = statusess;
    _products = products;
  }

  SingleOrderModel.fromJson(dynamic json) {
    _ordersId = json['orders_id'];
    _marketId = json['market_id'];
    _customersName = json['customers_name'];
    _email = json['email'];
    _productsPrice = json['products_price'];
    _shippingPrice = json['shipping_price'];
    _copoun = json['copoun'];
    _copounValue = json['copounValue'];
    _totalPrice = json['total_price'];
    _governorateName = json['governorateName'];
    _cityName = json['cityName'];
    _completed = json['completed'];
    _isCanceled = json['is_canceled'];
    if (json['statusess'] != null) {
      _statusess = [];
      json['statusess'].forEach((v) {
        _statusess?.add(Statusess.fromJson(v));
      });
    }
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(OrderProductModel.fromJson(v));
      });
    }
  }
  String? _ordersId;
  String? _marketId;
  String? _customersName;
  String? _email;
  int? _productsPrice;
  int? _shippingPrice;
  bool? _copoun;
  int? _copounValue;
  int? _totalPrice;
  String? _governorateName;
  String? _cityName;
  int? _completed;
  int? _isCanceled;
  List<Statusess>? _statusess;
  List<OrderProductModel>? _products;

  String? get ordersId => _ordersId;
  String? get marketId => _marketId;
  String? get customersName => _customersName;
  String? get email => _email;
  int? get productsPrice => _productsPrice;
  int? get shippingPrice => _shippingPrice;
  bool? get copoun => _copoun;
  int? get copounValue => _copounValue;
  int? get totalPrice => _totalPrice;
  String? get governorateName => _governorateName;
  String? get cityName => _cityName;
  int? get completed => _completed;
  int? get isCanceled => _isCanceled;
  List<Statusess>? get statusess => _statusess;
  List<OrderProductModel>? get products => _products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orders_id'] = _ordersId;
    map['market_id'] = _marketId;
    map['customers_name'] = _customersName;
    map['email'] = _email;
    map['products_price'] = _productsPrice;
    map['shipping_price'] = _shippingPrice;
    map['copoun'] = _copoun;
    map['copounValue'] = _copounValue;
    map['total_price'] = _totalPrice;
    map['governorateName'] = _governorateName;
    map['cityName'] = _cityName;
    map['completed'] = _completed;
    map['is_canceled'] = _isCanceled;
    if (_statusess != null) {
      map['statusess'] = _statusess?.map((v) => v.toJson()).toList();
    }
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// orders_products_id : "162"
/// orders_id : "175"
/// products_id : "37"
/// products_model : null
/// products_name : "product 1"
/// products_price : "50.00"
/// final_price : "150.00"
/// products_tax : "0"
/// products_quantity : "3"
/// model : null

class OrderProductModel {
  OrderProductModel({
    String? ordersProductsId,
    String? ordersId,
    String? productsId,
    dynamic productsModel,
    String? productsName,
    String? productsPrice,
    String? finalPrice,
    String? productsTax,
    String? productsQuantity,
    dynamic model,
  }) {
    _ordersProductsId = ordersProductsId;
    _ordersId = ordersId;
    _productsId = productsId;
    _productsModel = productsModel;
    _productsName = productsName;
    _productsPrice = productsPrice;
    _finalPrice = finalPrice;
    _productsTax = productsTax;
    _productsQuantity = productsQuantity;
    _model = model;
  }

  OrderProductModel.fromJson(dynamic json) {
    _ordersProductsId = json['orders_products_id'];
    _ordersId = json['orders_id'];
    _productsId = json['products_id'];
    _productsModel = json['products_model'];
    _productsName = json['products_name'];
    _productsPrice = json['products_price'];
    _finalPrice = json['final_price'];
    _productsTax = json['products_tax'];
    _productsQuantity = json['products_quantity'];
    _model = json['model'];
  }
  String? _ordersProductsId;
  String? _ordersId;
  String? _productsId;
  dynamic _productsModel;
  String? _productsName;
  String? _productsPrice;
  String? _finalPrice;
  String? _productsTax;
  String? _productsQuantity;
  dynamic _model;

  String? get ordersProductsId => _ordersProductsId;
  String? get ordersId => _ordersId;
  String? get productsId => _productsId;
  dynamic get productsModel => _productsModel;
  String? get productsName => _productsName;
  String? get productsPrice => _productsPrice;
  String? get finalPrice => _finalPrice;
  String? get productsTax => _productsTax;
  String? get productsQuantity => _productsQuantity;
  dynamic get model => _model;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orders_products_id'] = _ordersProductsId;
    map['orders_id'] = _ordersId;
    map['products_id'] = _productsId;
    map['products_model'] = _productsModel;
    map['products_name'] = _productsName;
    map['products_price'] = _productsPrice;
    map['final_price'] = _finalPrice;
    map['products_tax'] = _productsTax;
    map['products_quantity'] = _productsQuantity;
    map['model'] = _model;
    return map;
  }
}

/// status : "Pending"
/// date_added : "2022-04-25 09:21:10"

class Statusess {
  Statusess({
    String? status,
    String? dateAdded,
  }) {
    _status = status;
    _dateAdded = dateAdded;
  }

  Statusess.fromJson(dynamic json) {
    _status = json['status'];
    _dateAdded = json['date_added'];
  }
  String? _status;
  String? _dateAdded;

  String? get status => _status;
  String? get dateAdded => _dateAdded;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['date_added'] = _dateAdded;
    return map;
  }
}
