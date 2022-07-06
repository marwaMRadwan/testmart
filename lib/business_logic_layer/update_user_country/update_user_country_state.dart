part of 'update_user_country_cubit.dart';

@immutable
abstract class UpdateUserCountryState {}

class UpdateUserCountryInitial extends UpdateUserCountryState {}

class UpdateUserCountryLoadingState extends UpdateUserCountryState {}

class UpdateUserCountrySuccessState extends UpdateUserCountryState {}

class UpdateUserCountryErrorState extends UpdateUserCountryState {}
