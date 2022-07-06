/// market_id : "118"
/// market_name : "Seoudi Market"
/// market_logo : "http://martizoom.com/adminImages/1650964097.jpg"
/// totalCart : 480
/// price_after_discount : 0
/// products : [{"id":"3503","products_name":"3503","products_description":"1","categories_name":"مياه","products_price":"50","products_quantity":"8","image":"http://martizoom.com/products/images/3503.jpg","Final_price":400},{"id":"5033","products_name":"5033","products_description":"1","categories_name":"أعشاب و بهارات","products_price":"40","products_quantity":"2","image":"http://martizoom.com/products/images/5033.jpg","Final_price":80}]

class CompareModel {
  CompareModel({
    String? marketId,
    String? marketName,
    String? marketLogo,
    String? totalCart,
    String? priceAfterDiscount,
    List<CompareProductModel>? products,
  }) {
    _marketId = marketId;
    _marketName = marketName;
    _marketLogo = marketLogo;
    _totalCart = totalCart;
    _priceAfterDiscount = priceAfterDiscount;
    _products = products;
  }

  CompareModel.fromJson(dynamic json) {
    _marketId = json['market_id'];
    _marketName = json['market_name'];
    _marketLogo = json['market_logo'];
    _totalCart = json['totalCart'];
    _priceAfterDiscount = json['price_after_discount'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(CompareProductModel.fromJson(v));
      });
    }
  }
  String? _marketId;
  String? _marketName;
  String? _marketLogo;
  String? _totalCart;
  String? _priceAfterDiscount;
  List<CompareProductModel>? _products;

  String? get marketId => _marketId;
  String? get marketName => _marketName;
  String? get marketLogo => _marketLogo;
  String? get totalCart => _totalCart;
  String? get priceAfterDiscount => _priceAfterDiscount;
  List<CompareProductModel>? get products => _products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['market_id'] = _marketId;
    map['market_name'] = _marketName;
    map['market_logo'] = _marketLogo;
    map['totalCart'] = _totalCart;
    map['price_after_discount'] = _priceAfterDiscount;
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "3503"
/// products_name : "3503"
/// products_description : "1"
/// categories_name : "مياه"
/// products_price : "50"
/// products_quantity : "8"
/// image : "http://martizoom.com/products/images/3503.jpg"
/// Final_price : 400

class CompareProductModel {
  CompareProductModel({
    String? id,
    String? productsName,
    String? productsDescription,
    String? categoriesName,
    String? productsPrice,
    String? productsQuantity,
    String? image,
    int? finalPrice,
  }) {
    _id = id;
    _productsName = productsName;
    _productsDescription = productsDescription;
    _categoriesName = categoriesName;
    _productsPrice = productsPrice;
    _productsQuantity = productsQuantity;
    _image = image;
    _finalPrice = finalPrice;
  }

  CompareProductModel.fromJson(dynamic json) {
    _id = json['id'];
    _productsName = json['products_name'];
    _productsDescription = json['products_description'];
    _categoriesName = json['categories_name'];
    _productsPrice = json['products_price'];
    _productsQuantity = json['products_quantity'];
    _image = json['image'];
    _finalPrice = json['Final_price'];
  }
  String? _id;
  String? _productsName;
  String? _productsDescription;
  String? _categoriesName;
  String? _productsPrice;
  String? _productsQuantity;
  String? _image;
  int? _finalPrice;

  String? get id => _id;
  String? get productsName => _productsName;
  String? get productsDescription => _productsDescription;
  String? get categoriesName => _categoriesName;
  String? get productsPrice => _productsPrice;
  String? get productsQuantity => _productsQuantity;
  String? get image => _image;
  int? get finalPrice => _finalPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['products_name'] = _productsName;
    map['products_description'] = _productsDescription;
    map['categories_name'] = _categoriesName;
    map['products_price'] = _productsPrice;
    map['products_quantity'] = _productsQuantity;
    map['image'] = _image;
    map['Final_price'] = _finalPrice;
    return map;
  }
}
