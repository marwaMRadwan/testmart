import 'package:martizoom/data_layer/models/market_model.dart';

/// data : [{"id":"59","Name":"suadi","image":"http://techsexperts.site/adminImages/1647716454.jpg"},{"id":"63","Name":"Kibo","image":"http://techsexperts.site/adminImages/1647899188.png"},{"id":"62","Name":"test market1","image":"http://techsexperts.site/adminImages/1647899166.png"}]
/// count : 3

class MarketsModel {
  MarketsModel({
    List<MarketModel>? market,
    int? count,
  }) {
    _markets = market;
    _count = count;
  }

  MarketsModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _markets = [];
      json['data'].forEach((v) {
        _markets?.add(MarketModel.fromJson(v));
      });
    }
    _count = json['count'];
  }

  List<MarketModel>? _markets;
  int? _count;

  List<MarketModel>? get markets => _markets;

  int? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_markets != null) {
      map['data'] = _markets?.map((v) => v.toJson()).toList();
    }
    map['count'] = _count;
    return map;
  }
}
