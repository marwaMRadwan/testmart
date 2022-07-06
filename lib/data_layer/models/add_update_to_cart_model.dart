/// success : "Product Added To Cart"
/// status : true
/// data : {"id":"5022","products_name":"5022","products_description":"1","categories_name":"أعشاب و بهارات","image":"","MainPrice":"50","MarketName":"Metro","in_cart":1,"cart_quantity":"5","cart_id":174,"offer_price":false,"priceAfterDiscount":"0.00","is_Flash":false,"Flash_price":0}

class AddUpdateToCartModel {
  AddUpdateToCartModel({
    String? success,
    bool? status,
    Data? data,
  }) {
    _success = success;
    _status = status;
    _data = data;
  }

  AddUpdateToCartModel.fromJson(dynamic json) {
    _success = json['success'];
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? _success;
  bool? _status;
  Data? _data;

  String? get success => _success;

  bool? get status => _status;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// id : "5022"
/// products_name : "5022"
/// products_description : "1"
/// categories_name : "أعشاب و بهارات"
/// image : ""
/// MainPrice : "50"
/// MarketName : "Metro"
/// in_cart : 1
/// cart_quantity : "5"
/// cart_id : 174
/// offer_price : false
/// priceAfterDiscount : "0.00"
/// is_Flash : false
/// Flash_price : 0

class Data {
  Data({
    String? id,
    String? productsName,
    String? productsDescription,
    String? categoriesName,
    String? image,
    String? mainPrice,
    String? marketName,
    int? inCart,
    String? cartQuantity,
    String? cartId,
    bool? offerPrice,
    String? priceAfterDiscount,
    bool? isFlash,
    int? flashPrice,
  }) {
    _id = id;
    _productsName = productsName;
    _productsDescription = productsDescription;
    _categoriesName = categoriesName;
    _image = image;
    _mainPrice = mainPrice;
    _marketName = marketName;
    _inCart = inCart;
    _cartQuantity = cartQuantity;
    _cartId = cartId;
    _offerPrice = offerPrice;
    _priceAfterDiscount = priceAfterDiscount;
    _isFlash = isFlash;
    _flashPrice = flashPrice;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _productsName = json['products_name'];
    _productsDescription = json['products_description'];
    _categoriesName = json['categories_name'];
    _image = json['image'];
    _mainPrice = json['MainPrice'];
    _marketName = json['MarketName'];
    _inCart = json['in_cart'];
    _cartQuantity = json['cart_quantity'];
    _cartId = json['cart_id'];
    _offerPrice = json['offer_price'];
    _priceAfterDiscount = json['priceAfterDiscount'];
    _isFlash = json['is_Flash'];
    _flashPrice = json['Flash_price'];
  }

  String? _id;
  String? _productsName;
  String? _productsDescription;
  String? _categoriesName;
  String? _image;
  String? _mainPrice;
  String? _marketName;
  int? _inCart;
  String? _cartQuantity;
  String? _cartId;
  bool? _offerPrice;
  String? _priceAfterDiscount;
  bool? _isFlash;
  int? _flashPrice;

  String? get id => _id;

  String? get productsName => _productsName;

  String? get productsDescription => _productsDescription;

  String? get categoriesName => _categoriesName;

  String? get image => _image;

  String? get mainPrice => _mainPrice;

  String? get marketName => _marketName;

  int? get inCart => _inCart;

  String? get cartQuantity => _cartQuantity;

  String? get cartId => _cartId;

  bool? get offerPrice => _offerPrice;

  String? get priceAfterDiscount => _priceAfterDiscount;

  bool? get isFlash => _isFlash;

  int? get flashPrice => _flashPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['products_name'] = _productsName;
    map['products_description'] = _productsDescription;
    map['categories_name'] = _categoriesName;
    map['image'] = _image;
    map['MainPrice'] = _mainPrice;
    map['MarketName'] = _marketName;
    map['in_cart'] = _inCart;
    map['cart_quantity'] = _cartQuantity;
    map['cart_id'] = _cartId;
    map['offer_price'] = _offerPrice;
    map['priceAfterDiscount'] = _priceAfterDiscount;
    map['is_Flash'] = _isFlash;
    map['Flash_price'] = _flashPrice;
    return map;
  }
}
