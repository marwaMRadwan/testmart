import 'package:martizoom/data_layer/models/product_model.dart';

/// data : [{"id":"32","products_name":"Straight long coat","products_description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&rsquo;s standard dummy text ever since the 1500s","categories_name":"Fruits","image":"http://marwaradwan.co/Products/images/16492671691912780547.png","MainPrice":"30","MarketName":"suadi","offer_price":"Percentage","priceAfterDiscount":-19.200000000000003,"is_Flash":false,"Flash_price":0},{"id":"31","products_name":"Quilted gilet hoodie","products_description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.","categories_name":"Fruits","image":"http://marwaradwan.co/Products/images/16492671691912780547.png","MainPrice":"40","MarketName":"suadi","offer_price":"Percentage","priceAfterDiscount":-20,"is_Flash":false,"Flash_price":0},{"id":"30","products_name":"Denim jacket reverse","products_description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.","categories_name":"Fruits","image":"http://marwaradwan.co/Products/images/16492671691912780547.png","MainPrice":"50","MarketName":"suadi","offer_price":"Percentage","priceAfterDiscount":0,"is_Flash":false,"Flash_price":0},{"id":"29","products_name":"Strip Knitwear for women","products_description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.","categories_name":"Fruits","image":"http://marwaradwan.co/Products/images/16492671691912780547.png","MainPrice":"90","MarketName":"suadi","offer_price":false,"priceAfterDiscount":0,"is_Flash":false,"Flash_price":0},{"id":"28","products_name":"Printed Rose Petal Shirt","products_description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.","categories_name":"Fruits","image":"http://marwaradwan.co/Products/images/16492671691912780547.png","MainPrice":"90","MarketName":"suadi","offer_price":false,"priceAfterDiscount":0,"is_Flash":false,"Flash_price":0},{"id":"24","products_name":"Party Dinner Shoes Woman","products_description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.","categories_name":"Fruits","image":"http://marwaradwan.co/Products/images/16492671691912780547.png","MainPrice":"90","MarketName":"suadi","offer_price":false,"priceAfterDiscount":0,"is_Flash":false,"Flash_price":0},{"id":"21","products_name":"Mid waist culottes  Pent","products_description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.","categories_name":"Fruits","image":"http://marwaradwan.co/Products/images/16492671691912780547.png","MainPrice":"90","MarketName":"suadi","offer_price":false,"priceAfterDiscount":0,"is_Flash":false,"Flash_price":0}]
/// count : 7

class ProductsByStandModel {
  ProductsByStandModel({
    List<ProductModel>? data,
    int? count,
  }) {
    _data = data;
    _count = count;
  }

  ProductsByStandModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ProductModel.fromJson(v));
      });
    }
    _count = json['count'];
  }

  List<ProductModel>? _data;
  int? _count;

  List<ProductModel>? get data => _data;

  int? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['count'] = _count;
    return map;
  }
}
