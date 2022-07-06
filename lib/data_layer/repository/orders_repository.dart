import 'dart:io';
import 'package:flutter/material.dart';
import 'package:martizoom/data_layer/endpoints/endpoints.dart';
import 'package:martizoom/data_layer/models/order_model.dart';
import 'package:martizoom/data_layer/models/single_order_model.dart';
import 'package:martizoom/shared/constants/constants.dart';
import 'package:martizoom/shared/network/remote/dio_helper.dart';

class OrdersRepository {
  static final OrdersRepository _singleton = OrdersRepository._internal();

  factory OrdersRepository() {
    return _singleton;
  }

  OrdersRepository._internal();

  Future processUserOrder({
    required String marketId,
  }) async {
    const endpoint = '$auth/$processOrder';
    final response = await DioHelper.postData(
      url: endpoint,
      data: {
        'market_id': marketId,
        "payment_method": "cash_on_delivery",
      },
    );
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }
    return response.data;
  }

  Future<List<OrderModel>> getOrders() async {
    String endpoint = '$auth/$orders/${languageCode == 'ar' ? 4 : 1}';

    final response = await DioHelper.getData(
      url: endpoint,
    );

    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }
    List data = response.data['data'];
    return data.map((e) => OrderModel.fromJson(e)).toList();
  }

  Future<List<SingleOrderModel>> getSingleOrder(
      {required String orderId}) async {
    String endpoint =
        '$auth/$viewOrder/$orderId/${languageCode == 'ar' ? 4 : 1}';

    final response = await DioHelper.getData(
      url: endpoint,
    );

    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }
    List data = response.data['data'];
    return data.map((e) => SingleOrderModel.fromJson(e)).toList();
  }
}
