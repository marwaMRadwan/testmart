import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/user_model.dart';
import 'package:martizoom/data_layer/repository/user_repository.dart';
import 'package:martizoom/shared/constants/constants.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(UserDataInitial());

  static UserDataCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final UserRepository _userRepository = UserRepository();
  UserModel? appUser;

  getUserData() {
    emit(GetUserDataLoadingState());
    _userRepository.getUserData().then((value) {
      appUser = value;
      chooseLanguageCode(langCode: appUser?.languageCode ?? 'en');
      chooseCountryId(id: appUser?.country ?? '0');
      countryCode = appUser?.countryCode ?? 'eg';
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      debugPrint('$error');
      emit(GetUserDataErrorState(
        error: error,
      ));
    });
  }
}
