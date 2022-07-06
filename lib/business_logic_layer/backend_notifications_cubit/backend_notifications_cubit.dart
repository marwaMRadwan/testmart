import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/backend_notification_model.dart';

import '../../data_layer/repository/notifications_repository.dart';

part 'backend_notifications_state.dart';

class BackendNotificationsCubit extends Cubit<BackendNotificationsState> {
  BackendNotificationsCubit() : super(BackendNotificationsInitial());

  static BackendNotificationsCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final NotificationsRepository _notificationsRepository =
      NotificationsRepository();
  final List<BackendNotificationModel> notifications = [];

  void getNotifications() {
    notifications.clear();
    emit(GetBackendNotificationsLoadingState());
    _notificationsRepository.getNotifications().then((value) {
      notifications.addAll(value);
      if (notifications.isEmpty) {
        emit(GetBackendNotificationsEmptyState());
      } else {
        emit(GetBackendNotificationsSuccessState());
      }
      _notificationsRepository
          .makeAllNotificationSeen()
          .then((value) => null)
          .catchError((error) {
      });
    }).catchError((error) {
      debugPrint('$error');
      emit(GetBackendNotificationsErrorState(error: error));
    });
  }
}
