import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:martizoom/data_layer/models/backend_notification_model.dart';

import '../../shared/network/remote/dio_helper.dart';
import '../endpoints/endpoints.dart';

class NotificationsRepository {
  static final NotificationsRepository _singleton =
      NotificationsRepository._internal();

  factory NotificationsRepository() {
    return _singleton;
  }

  NotificationsRepository._internal();

  Future<List<BackendNotificationModel>> getNotifications() async {
    String endpoint = '$auth/$notifications';

    final response = await DioHelper.getData(
      url: endpoint,
    );
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['error'] != null) {
      throw HttpException(response.data['error']);
    }

    List data = response.data['data'];

    return data.map((e) => BackendNotificationModel.fromJson(e)).toList();
  }

  Future<String> makeAllNotificationSeen() async {
    const endpoint = '$auth/$updateNotifications';
    final response = await DioHelper.postData(
      url: endpoint,
      data: {},
    );
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('response data: ${response.data}');
    if (response.data['Error'] != null) {
      throw HttpException(response.data['Error']);
    }
    return response.data['success'];
  }
}
