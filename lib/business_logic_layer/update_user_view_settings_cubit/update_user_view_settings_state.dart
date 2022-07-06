part of 'update_user_view_settings_cubit.dart';

@immutable
abstract class UpdateUserViewSettingsState {}

class UpdateUserViewSettingsInitial extends UpdateUserViewSettingsState {}

class UpdateUserViewSettingsLoadingState extends UpdateUserViewSettingsState {}

class UpdateUserViewSettingsSuccessState extends UpdateUserViewSettingsState {}

class UpdateUserViewSettingsErrorState extends UpdateUserViewSettingsState {}
