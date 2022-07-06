import 'dart:io';

import 'package:flutter/material.dart';
import 'package:martizoom/data_layer/endpoints/endpoints.dart';
import 'package:martizoom/data_layer/models/category_model.dart';
import 'package:martizoom/data_layer/models/markets_model.dart';
import 'package:martizoom/data_layer/models/products_by_stand_model.dart';
import 'package:martizoom/shared/constants/constants.dart';
import 'package:martizoom/shared/network/remote/dio_helper.dart';

class MarketsRepository {
  static final MarketsRepository _singleton = MarketsRepository._internal();

  factory MarketsRepository() {
    return _singleton;
  }

  MarketsRepository._internal();

  Future<MarketsModel> getTopMarkets({
    required int page,
    required int limit,
    String? zoneId,
  }) async {
    String endpoint = '$listTopMarkets/$page/$limit/${await getDeviceId()}';
    if (zoneId != null) {
      endpoint =
          '$listTopMarketByZone/$zoneId/$page/$limit/${await getDeviceId()}';
    }
    if (isLoggedIn) {
      endpoint = '$listTopMarkets/$page/$limit';
      if (zoneId != null) {
        endpoint = '$listTopMarketByZone/$zoneId/$page/$limit';
      }
    }

    final response =
        await DioHelper.getData(url: endpoint, removeToken: !isLoggedIn);
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }

    return MarketsModel.fromJson(
      response.data,
    );
  }

  Future<MarketsModel> getMarkets({
    required int page,
    required int limit,
  }) async {
    String endpoint = '$listMarkets/$page/$limit';
    if (!isLoggedIn) {
      endpoint = '$listMarkets/$page/$limit/${await getDeviceId()}';
    }
    final response = await DioHelper.getData(
      url: endpoint,
      removeToken: !isLoggedIn,
    );

    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }

    return MarketsModel.fromJson(
      response.data,
    );
  }

  Future<MarketsModel> searchMarkets({
    required int page,
    required int limit,
    required String word,
  }) async {
    String endpoint = '$searchListMarkets/$word/$page/$limit/${getDeviceId()}';
    if (isLoggedIn) {
      endpoint = '$searchListMarkets/$word/$page/$limit';
    }
    final response = await DioHelper.getData(
      url: endpoint,
      removeToken: !isLoggedIn,
    );

    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }

    return MarketsModel.fromJson(
      response.data,
    );
  }

  Future<List<CategoryModel>> getMarketCategories(
      {required String marketId}) async {
    String endpoint = '$listMarketsCategories/$marketId/${await getDeviceId()}';
    if (isLoggedIn) {
      endpoint = '$listMarketsCategories/$marketId';
    }

    final response = await DioHelper.getData(
      url: endpoint,
      removeToken: !isLoggedIn,
    );

    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }
    List data = response.data['data'];

    return data.map((e) => CategoryModel.fromJson(e)).toList();
  }

  Future<ProductsByStandModel> getProductsByCategory({
    required String marketId,
    required String categoryId,
    required String standId,
    required int page,
    required int limit,
  }) async {
    String endpoint =
        '$productsByCategory/$marketId/$categoryId/$standId/$page/$limit/${await getDeviceId()}';
    if (isLoggedIn) {
      endpoint =
          '$productsByCategory/$marketId/$categoryId/$standId/$page/$limit';
    }
    final response = await DioHelper.getData(
      url: endpoint,
      removeToken: !isLoggedIn,
    );

    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }

    return ProductsByStandModel.fromJson(
      response.data,
    );
  }
}
