import 'dart:io';

import 'package:flutter/material.dart';
import 'package:martizoom/data_layer/endpoints/endpoints.dart';
import 'package:martizoom/data_layer/models/offer_model.dart';
import 'package:martizoom/shared/constants/constants.dart';

import '../../shared/network/remote/dio_helper.dart';

class OffersRepository {
  static final OffersRepository _singleton = OffersRepository._internal();

  factory OffersRepository() {
    return _singleton;
  }

  OffersRepository._internal();

  Future<List<OfferModel>> getOffers() async {
    String endpoint = '$offers/${await getDeviceId()}';

    if (isLoggedIn) endpoint = offers;
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
    return data.map((e) => OfferModel.fromJson(e)).toList();
  }
}
