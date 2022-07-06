part of 'user_data_cubit.dart';

@immutable
abstract class UserDataState {}

class UserDataInitial extends UserDataState {}

class GetUserDataLoadingState extends UserDataState {}

class GetUserDataSuccessState extends UserDataState {}

class GetUserDataErrorState extends UserDataState {
  final error;

  GetUserDataErrorState({required this.error});
}
