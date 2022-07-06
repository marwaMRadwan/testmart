part of 'update_user_profile_cubit.dart';

@immutable
abstract class UpdateUserProfileState {}

class UpdateUserProfileInitial extends UpdateUserProfileState {}

class UpdateUserProfileLoadingState extends UpdateUserProfileState {}

class UpdateUserProfileSuccessState extends UpdateUserProfileState {}

class UpdateUserProfileErrorState extends UpdateUserProfileState {}
