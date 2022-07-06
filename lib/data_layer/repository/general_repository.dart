import 'dart:io';

import 'package:flutter/material.dart';
import 'package:martizoom/data_layer/endpoints/endpoints.dart';
import 'package:martizoom/data_layer/models/about_app_model.dart';
import 'package:martizoom/data_layer/models/city_model.dart';
import 'package:martizoom/data_layer/models/contact_message_model.dart';
import 'package:martizoom/data_layer/models/contact_model.dart';
import 'package:martizoom/data_layer/models/country_model.dart';
import 'package:martizoom/data_layer/models/device_details_model.dart';
import 'package:martizoom/data_layer/models/language_model.dart';
import 'package:martizoom/data_layer/models/zone_model.dart';
import 'package:martizoom/shared/constants/constants.dart';
import 'package:martizoom/shared/network/remote/dio_helper.dart';

class GeneralRepository {
  static final GeneralRepository _singleton = GeneralRepository._internal();

  factory GeneralRepository() {
    return _singleton;
  }

  GeneralRepository._internal();

  Future<List<ZoneModel>> getZones() async {
    const endpoint = zones;
    final response = await DioHelper.postData(
      url: endpoint,
      data: {
        'MacAddress': await getDeviceId(),
      },
    );
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }
    List data = response.data['data'];
    return data.map((e) => ZoneModel.fromJson(e)).toList();
  }

  Future<List<LanguageModel>> getLanguages() async {
    const endpoint = languages;

    final response = await DioHelper.getData(
      url: endpoint,
      removeToken: true,
    );
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }
    List data = response.data['data'];
    return data.map((e) => LanguageModel.fromJson(e)).toList();
  }

  Future<List<CountryModel>> getCountries({required String langId}) async {
    final endpoint = "$countries/$langId";
    final response = await DioHelper.getData(
      url: endpoint,
    );
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }
    List data = response.data['data'];
    return data.map((e) => CountryModel.fromJson(e)).toList();
  }

  Future<String> storeDeviceDetails(
      {required DeviceDetailsModel deviceDetailsModel}) async {
    deviceDetailsModel.macAddress = await getDeviceId();
    const endpoint = deviceDetails;
    final response = await DioHelper.postData(
      url: endpoint,
      data: deviceDetailsModel.toJson(),
    );
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }
    return response.data['success'];
  }

  Future<List<CityModel>> getCities({required String zoneId}) async {
    const endpoint = cities;
    final response = await DioHelper.postData(
      url: endpoint,
      data: {
        'MacAddress': await getDeviceId(),
        'zone_id': zoneId,
      },
    );
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }
    List data = response.data['data'];
    return data.map((e) => CityModel.fromJson(e)).toList();
  }

  Future<String> getGovernorateId({required String govName}) async {
    final endpoint = '$zoneId/$govName/${languageCode == 'en' ? 1 : 4}';
    final response = await DioHelper.getData(
      url: endpoint,
    );
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }
    return response.data['govId'];
  }

  Future<List<AboutAppInfoModel>> getAppInfo() async {
    String endpoint = staticPages;
    if (!isLoggedIn) {
      endpoint = '$staticPages/${await getDeviceId()}';
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
    return data.map((e) => AboutAppInfoModel.fromJson(e)).toList();
  }

  Future<List<ContactModel>> getContacts() async {
    String endpoint = contactInformation;

    final response = await DioHelper.getData(
      url: endpoint,
    );
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }
    List data = response.data['data'];
    return data.map((e) => ContactModel.fromJson(e)).toList();
  }


  Future<String> sendContactMessage({required ContactMessageModel message}) async {
    const endpoint = contactUs;
    final response = await DioHelper.postData(
      url: endpoint,
      data:message.toJson(),
    );
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }
    return response.data['message'];
  }


}
