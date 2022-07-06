/// id : "17"
/// market_id : "117"
/// category_id : "2"
/// product_id : "0"
/// image_path : "http://martizoom.com/offers/1650965537.jpg"
/// products_name : "asd"
/// categories_name : "Water"
/// theme_id : "0"

class OfferModel {
  OfferModel({
    String? id,
    String? marketId,
    String? categoryId,
    String? productId,
    String? imagePath,
    String? productsName,
    String? categoriesName,
    String? themeId,
  }) {
    _id = id;
    _marketId = marketId;
    _categoryId = categoryId;
    _productId = productId;
    _imagePath = imagePath;
    _productsName = productsName;
    _categoriesName = categoriesName;
    _themeId = themeId;
  }

  OfferModel.fromJson(dynamic json) {
    _id = json['id'];
    _marketId = json['market_id'];
    _categoryId = json['category_id'];
    _productId = json['product_id'];
    _imagePath = json['image_path'];
    _productsName = json['products_name'];
    _categoriesName = json['categories_name'];
    _themeId = json['theme_id'];
  }
  String? _id;
  String? _marketId;
  String? _categoryId;
  String? _productId;
  String? _imagePath;
  String? _productsName;
  String? _categoriesName;
  String? _themeId;

  String? get id => _id;
  String? get marketId => _marketId;
  String? get categoryId => _categoryId;
  String? get productId => _productId;
  String? get imagePath => _imagePath;
  String? get productsName => _productsName;
  String? get categoriesName => _categoriesName;
  String? get themeId => _themeId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['market_id'] = _marketId;
    map['category_id'] = _categoryId;
    map['product_id'] = _productId;
    map['image_path'] = _imagePath;
    map['products_name'] = _productsName;
    map['categories_name'] = _categoriesName;
    map['theme_id'] = _themeId;
    return map;
  }
}
