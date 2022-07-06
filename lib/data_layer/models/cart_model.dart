/// customers_basket_id : "96"
/// products_id : "31"
/// products_name : "Quilted gilet hoodie"
/// customers_basket_quantity : "1"
/// Market_products_price : "40"
/// image : "http://martizoom.marwaradwan.co/"
/// Market_id : "59"
/// Market_name : "Saudi"
/// Market_products_price_after : -20

class CartModel {
  CartModel({
    String? customersBasketId,
    String? productsId,
    String? productsName,
    String? customersBasketQuantity,
    String? marketProductsPrice,
    String? image,
    String? marketId,
    String? marketName,
    String? marketProductsPriceAfter,
  }) {
    _customersBasketId = customersBasketId;
    _productsId = productsId;
    _productsName = productsName;
    _customersBasketQuantity = customersBasketQuantity;
    _marketProductsPrice = marketProductsPrice;
    _image = image;
    _marketId = marketId;
    _marketName = marketName;
    _marketProductsPriceAfter = marketProductsPriceAfter;
  }

  CartModel.fromJson(dynamic json) {
    _customersBasketId = json['customers_basket_id'];
    _productsId = json['products_id'];
    _productsName = json['products_name'];
    _customersBasketQuantity = json['customers_basket_quantity'];
    _marketProductsPrice = json['Market_products_price'];
    _image = json['image'];
    _marketId = json['Market_id'];
    _marketName = json['Market_name'];
    _marketProductsPriceAfter = json['Market_products_price_after'];
  }

  String? _customersBasketId;
  String? _productsId;
  String? _productsName;
  String? _customersBasketQuantity;
  String? _marketProductsPrice;
  String? _image;
  String? _marketId;
  String? _marketName;
  String? _marketProductsPriceAfter;

  String? get customersBasketId => _customersBasketId;

  String? get productsId => _productsId;

  String? get productsName => _productsName;

  String? get customersBasketQuantity => _customersBasketQuantity;

  String? get marketProductsPrice => _marketProductsPrice;

  String? get image => _image;

  String? get marketId => _marketId;

  String? get marketName => _marketName;

  String? get marketProductsPriceAfter => _marketProductsPriceAfter;

  set customersBasketQuantity(String? value) =>
      _customersBasketQuantity = value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['customers_basket_id'] = _customersBasketId;
    map['products_id'] = _productsId;
    map['products_name'] = _productsName;
    map['customers_basket_quantity'] = _customersBasketQuantity;
    map['Market_products_price'] = _marketProductsPrice;
    map['image'] = _image;
    map['Market_id'] = _marketId;
    map['Market_name'] = _marketName;
    map['Market_products_price_after'] = _marketProductsPriceAfter;
    return map;
  }
}
