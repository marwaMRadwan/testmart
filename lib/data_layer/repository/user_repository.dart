import 'dart:io';

import 'package:flutter/material.dart';
import 'package:martizoom/data_layer/endpoints/endpoints.dart';
import 'package:martizoom/data_layer/models/address_model.dart';
import 'package:martizoom/data_layer/models/login_model.dart';
import 'package:martizoom/data_layer/models/register_model.dart';
import 'package:martizoom/data_layer/models/update_user_model.dart';
import 'package:martizoom/data_layer/models/user_model.dart';
import 'package:martizoom/shared/constants/constants.dart';

import '../../shared/network/remote/dio_helper.dart';
import '../../shared/network/remote/firebase_helper.dart';

class UserRepository {
  static final UserRepository _singleton = UserRepository._internal();

  factory UserRepository() {
    return _singleton;
  }

  UserRepository._internal();

  Future userRegister({required RegisterModel registerModel}) async {
    const endpoint = '$auth/$register';
    registerModel.macAddress = await getDeviceId();
    final response =
        await DioHelper.postData(url: endpoint, data: registerModel.toJson());
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['errors'] != null) {
      throw const HttpException('The phone number has already been taken.');
    }
    return response.data['success'];
  }

  Future<LoginModel> userLogin({
    required String phone,
    required String password,
  }) async {
    const endpoint = '$auth/$login';
    final data = {
      'phone': phone,
      'password': password,
      'fcm_token': await FirebaseHelper.getFirebaseToken(),
    };
    final response = await DioHelper.postData(url: endpoint, data: data);
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }
    return LoginModel.fromJson(response.data);
  }

  userLogout() async {
    const endpoint = '$auth/$logout';
    final response = await DioHelper.postData(
      url: endpoint,
      data: {},
    );
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['Message'] != null) {
      throw HttpException(response.data['Message']);
    }
  }

  Future<String> updateUserPassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    const endpoint = '$auth/$updatePassword';
    final data = {
      'current_password': currentPassword,
      'new_password': newPassword,
    };
    final response = await DioHelper.postData(url: endpoint, data: data);
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['errors'] != null) {
      throw HttpException(response.data['errors']);
    }
    return response.data['data'];
  }

  Future<UserModel> getUserData() async {
    const endpoint = '$auth/$userData';
    final response = await DioHelper.postData(url: endpoint, data: {});
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['Message'] != null) {
      throw HttpException(response.data['Message']);
    }
    return UserModel.fromJson(
      response.data,
    );
  }

  Future<String> updateUserProfile({
    required UpdateUserModel updateUserModel,
  }) async {
    const endpoint = '$auth/$updateProfile';
    final response = await DioHelper.postData(
      url: endpoint,
      data: updateUserModel.toJson(),
    );
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['errors'] != null) {
      throw const HttpException('The phone has already been taken.');
    }
    return response.data['success'];
  }

  /// Addresses APIs
  Future<List<AddressModel>> getUserAddresses() async {
    const endpoint = '$auth/$address';
    final response = await DioHelper.getData(
      url: endpoint,
    );
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }
    List data = response.data['data'];
    return data.map((e) => AddressModel.fromJson(e)).toList();
  }

  Future<String> addUserAddress({required AddressModel addressModel}) async {
    const endpoint = '$auth/$address/$addAddress';
    final response = await DioHelper.postData(
      url: endpoint,
      data: addressModel.toAddJson(),
    );
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }
    return response.data['success'];
  }

  Future<String> updateUserAddress({required AddressModel addressModel}) async {
    final endpoint = '$auth/$address/$updateAddress';
    final response = await DioHelper.postData(
      url: endpoint,
      data: addressModel.toUpdateJson(),
    );
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }
    return response.data['success'];
  }

  Future<String> deleteUserAddress({required String addressId}) async {
    final endpoint = '$auth/$address/$deleteAddress/$addressId';
    final response = await DioHelper.getData(
      url: endpoint,
    );
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }
    return response.data['success'];
  }

  Future<String> setAddressAsDefault({required String addressId}) async {
    final endpoint = '$auth/$address/$setDefaultAddress/$addressId';
    final response = await DioHelper.getData(
      url: endpoint,
    );
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }
    return response.data['success'];
  }

  Future<String> updateUserLanguage({required String langId}) async {
    const endpoint = '$auth/$updateLanguage';
    final response = await DioHelper.postData(
      url: endpoint,
      data: {
        "language": langId,
      },
    );
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }
    return response.data['success'];
  }

  Future<String> updateUserCountry({required String countryId}) async {
    const endpoint = '$auth/$updateCountry';
    final response = await DioHelper.postData(
      url: endpoint,
      data: {
        "country": countryId,
      },
    );
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }
    return response.data['success'];
  }

  Future<String> updateUserViewSettings({required String type}) async {
    const endpoint = '$auth/$updateViewSetting';
    final response = await DioHelper.postData(
      url: endpoint,
      data: {
        "type": type,
      },
    );
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }
    return response.data['success'];
  }
}
