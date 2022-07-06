import 'cart_model.dart';

/// data : [{"customers_basket_id":"95","products_id":"30","products_name":"Denim jacket reverse","customers_basket_quantity":"1","Market_products_price":"50","image":"http://martizoom.marwaradwan.co/","Market_id":"59","Market_name":"Saudi","Market_products_price_after":0},{"customers_basket_id":"96","products_id":"31","products_name":"Quilted gilet hoodie","customers_basket_quantity":"1","Market_products_price":"40","image":"http://martizoom.marwaradwan.co/","Market_id":"59","Market_name":"Saudi","Market_products_price_after":-20}]
/// ShippingPrice : "100"
/// Count : 2

class MyCartsResponseModel {
  MyCartsResponseModel({
    List<CartModel>? data,
    String? shippingPrice,
    int? count,
  }) {
    _data = data;
    _shippingPrice = shippingPrice;
    _count = count;
  }

  MyCartsResponseModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CartModel.fromJson(v));
      });
    }
    _shippingPrice = json['ShippingPrice'];
    _count = json['Count'];
  }

  List<CartModel>? _data;
  String? _shippingPrice;
  int? _count;

  List<CartModel>? get data => _data;

  String? get shippingPrice => _shippingPrice;

  int? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['ShippingPrice'] = _shippingPrice;
    map['Count'] = _count;
    return map;
  }
}
