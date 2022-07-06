import 'dart:io';

import 'package:flutter/material.dart';
import 'package:martizoom/data_layer/endpoints/endpoints.dart';
import 'package:martizoom/data_layer/models/stand_model.dart';
import 'package:martizoom/data_layer/models/subcategory_model.dart';
import 'package:martizoom/shared/constants/constants.dart';

import '../../shared/network/remote/dio_helper.dart';

class CategoriesRepository {
  static final CategoriesRepository _singleton =
      CategoriesRepository._internal();

  factory CategoriesRepository() {
    return _singleton;
  }

  CategoriesRepository._internal();

  Future<List<StandModel>> getStands({
    required String marketId,
    required String categoryId,
  }) async {
    String endpoint =
        '$category/$stands/$marketId/$categoryId/${await getDeviceId()}';
    if (isLoggedIn) {
      endpoint = '$category/$stands/$marketId/$categoryId';
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
    return data.map((e) => StandModel.fromJson(e)).toList();
  }

  Future<List<SubcategoryModel>> getSubcategories({
    required String standId,
  }) async {
    final endpoint = '$stands/$subcategories/$standId';
    final response = await DioHelper.getData(
      url: endpoint,
    );
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }
    List data = response.data['data'];
    return data.map((e) => SubcategoryModel.fromJson(e)).toList();
  }
}
