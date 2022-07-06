/// success : "data Fetched"
/// data : [{"coupans_id":"1","discount_type":"fixed_cart","amount":"50","minimum_amount":"100.00","maximum_amount":"500.00"}]
/// DiscountPrice : "50"
/// finalPrice : 450

class CouponsResponseModel {
  CouponsResponseModel({
    String? success,
    List<Data>? data,
    String? discountPrice,
    String? finalPrice,
  }) {
    _success = success;
    _data = data;
    _discountPrice = discountPrice;
    _finalPrice = finalPrice;
  }

  CouponsResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _discountPrice = json['DiscountPrice'];
    _finalPrice = json['finalPrice'];
  }

  String? _success;
  List<Data>? _data;
  String? _discountPrice;
  String? _finalPrice;

  String? get success => _success;

  List<Data>? get data => _data;

  String? get discountPrice => _discountPrice;

  String? get finalPrice => _finalPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['DiscountPrice'] = _discountPrice;
    map['finalPrice'] = _finalPrice;
    return map;
  }
}

/// coupans_id : "1"
/// discount_type : "fixed_cart"
/// amount : "50"
/// minimum_amount : "100.00"
/// maximum_amount : "500.00"

class Data {
  Data({
    String? coupansId,
    String? discountType,
    String? amount,
    String? minimumAmount,
    String? maximumAmount,
  }) {
    _coupansId = coupansId;
    _discountType = discountType;
    _amount = amount;
    _minimumAmount = minimumAmount;
    _maximumAmount = maximumAmount;
  }

  Data.fromJson(dynamic json) {
    _coupansId = json['coupans_id'];
    _discountType = json['discount_type'];
    _amount = json['amount'];
    _minimumAmount = json['minimum_amount'];
    _maximumAmount = json['maximum_amount'];
  }

  String? _coupansId;
  String? _discountType;
  String? _amount;
  String? _minimumAmount;
  String? _maximumAmount;

  String? get coupansId => _coupansId;

  String? get discountType => _discountType;

  String? get amount => _amount;

  String? get minimumAmount => _minimumAmount;

  String? get maximumAmount => _maximumAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coupans_id'] = _coupansId;
    map['discount_type'] = _discountType;
    map['amount'] = _amount;
    map['minimum_amount'] = _minimumAmount;
    map['maximum_amount'] = _maximumAmount;
    return map;
  }
}
