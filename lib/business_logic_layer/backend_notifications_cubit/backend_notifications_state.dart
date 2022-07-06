part of 'backend_notifications_cubit.dart';

@immutable
abstract class BackendNotificationsState {}

class BackendNotificationsInitial extends BackendNotificationsState {}

class GetBackendNotificationsLoadingState extends BackendNotificationsState {}

class GetBackendNotificationsSuccessState extends BackendNotificationsState {}

class GetBackendNotificationsEmptyState extends BackendNotificationsState {}

class GetBackendNotificationsErrorState extends BackendNotificationsState {
  final error;

  GetBackendNotificationsErrorState({required this.error});
}
