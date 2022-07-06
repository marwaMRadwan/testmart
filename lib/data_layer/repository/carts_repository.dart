import 'dart:io';

import 'package:flutter/material.dart';
import 'package:martizoom/data_layer/endpoints/endpoints.dart';
import 'package:martizoom/data_layer/models/add_update_to_cart_model.dart';
import 'package:martizoom/data_layer/models/compare_model.dart';
import 'package:martizoom/data_layer/models/my_carts_response_model.dart';
import 'package:martizoom/shared/constants/constants.dart';
import 'package:martizoom/shared/network/remote/dio_helper.dart';

class CartsRepository {
  static final CartsRepository _singleton = CartsRepository._internal();

  factory CartsRepository() {
    return _singleton;
  }

  CartsRepository._internal();

  Future<MyCartsResponseModel> getMyCarts() async {
    String endpoint = '$auth/$myCart/${languageCode == 'ar' ? 4 : 1}';

    final response = await DioHelper.getData(
      url: endpoint,
    );

    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }

    return MyCartsResponseModel.fromJson(response.data);
  }

  Future<String> deleteMyCart({required String basketId}) async {
    const endpoint = '$auth/$deleteCart';
    final response =
        await DioHelper.postData(url: endpoint, data: {'basket_id': basketId});
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }
    return response.data['data'];
  }

  Future<AddUpdateToCartModel> updateMyCart(
      {required String basketId, required String quantity}) async {
    const endpoint = '$auth/$editCart';
    final response = await DioHelper.postData(url: endpoint, data: {
      'basket_id': basketId,
      "quantity": quantity,
    });
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }
    return AddUpdateToCartModel.fromJson(response.data);
  }

  Future<List<CompareModel>> compareMarkets({String? couponCode}) async {
    String endpoint = '$auth/$compare';
    if (couponCode != null) {
      endpoint = '$auth/$compare/$couponCode';
    }

    final response = await DioHelper.getData(
      url: endpoint,
    );

    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }
    List data = response.data['data'];
    return data.map((e) => CompareModel.fromJson(e)).toList();
  }

  Future<AddUpdateToCartModel> addProductToCart({
    required String productId,
    required String quantity,
    required String marketId,
  }) async {
    const endpoint = '$auth/$addToCart';
    final response = await DioHelper.postData(url: endpoint, data: {
      "products_id": productId,
      "quantity": quantity,
      "market_id": marketId,
    });
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }
    return AddUpdateToCartModel.fromJson(response.data);
  }
}
