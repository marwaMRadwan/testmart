part of 'app_info_cubit.dart';

@immutable
abstract class AppInfoState {}

class AppInfoInitial extends AppInfoState {}

class GetAppInfoLoadingState extends AppInfoState {}

class GetAppInfoSuccessState extends AppInfoState {}

class GetAppInfoEmptyState extends AppInfoState {}

class GetAppInfoErrorState extends AppInfoState {
  final error;

  GetAppInfoErrorState({required this.error});
}
