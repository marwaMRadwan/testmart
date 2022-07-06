import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:martizoom/data_layer/models/coupons_response_model.dart';

import '../../shared/network/remote/dio_helper.dart';
import '../endpoints/endpoints.dart';

class CouponsRepository {
  static final CouponsRepository _singleton = CouponsRepository._internal();

  factory CouponsRepository() {
    return _singleton;
  }

  CouponsRepository._internal();
  Future<CouponsResponseModel> checkCoupon({required String couponValue,required String finalPrice}) async {
    String endpoint = '$auth/$copouns/$check/$couponValue/$finalPrice';

    final response = await DioHelper.getData(
      url: endpoint,
    );

    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }
    return CouponsResponseModel.fromJson(response.data);
  }
}