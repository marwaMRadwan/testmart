import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/login_model.dart';
import 'package:martizoom/data_layer/models/register_model.dart';

import '../../data_layer/repository/user_repository.dart';
import '../../shared/constants/constants.dart';
import '../../shared/network/local/cache_helper.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);

  final _userRepository = UserRepository();

  void userLogin({
    required String phone,
    required String password,
  }) {
    emit(LoginLoadingState());
    _userRepository
        .userLogin(
      phone: phone,
      password: password,
    )
        .then((loginModel) {
      saveData(loginModel: loginModel);
    }).catchError(
      (error) {
        debugPrint('$error');
        showErrorToast(error: error);
        emit(
          LoginErrorState(),
        );
      },
    );
  }

  saveData({required LoginModel loginModel}) {
    Future.wait(<Future>[
      CacheHelper.saveData(
        key: 'is_logged_in',
        value: true,
      ),
      CacheHelper.saveData(
        key: 'access_token',
        value: "bearer " + (loginModel.accessToken ?? ''),
      ),
      chooseLanguageCode(langCode: (loginModel.language ?? '1')=='1'?'en':'ar'),

      chooseCountryId(id: loginModel.country ?? '1'),
    ]).then((value) {
      accessToken = CacheHelper.getData(key: 'access_token');
      debugPrint('access_token $accessToken');
      isLoggedIn = CacheHelper.getData(key: 'is_logged_in');
      debugPrint('is_logged_in $isLoggedIn');
      emit(
        LoginSuccessState(loginModel: loginModel),
      );
    }).catchError(
      (error) {
        debugPrint('$error');
        showErrorToast(error: error);
        emit(
          LoginErrorState(),
        );
      },
    );
  }

  void userRegister({
    required RegisterModel registerModel,
  }) {
    emit(RegisterLoadingState());
    _userRepository
        .userRegister(
      registerModel: registerModel,
    )
        .then((value) {
      showSuccessToast(successMessage: value);
      emit(RegisterSuccessState());
    }).catchError((error) {
      debugPrint('$error');
      showErrorToast(error: error);
      emit(
        RegisterErrorState(),
      );
    });
  }

  void userLogout() {
    emit(LogoutLoadingState());
    _userRepository.userLogout().then((value) {
      removeData();
    }).catchError(
      (error) {
        debugPrint('$error');
        showErrorToast(error: error);
        emit(
          LogoutErrorState(),
        );
      },
    );
  }

  removeData() {
    Future.wait(<Future>[
      CacheHelper.removeData(
        key: 'is_logged_in',
      ),
      CacheHelper.removeData(key: 'access_token'),
    ]).then((value) {
      accessToken = null;
      emit(LogoutSuccessState());
      isLoggedIn = false;
    }).catchError(
      (error) {
        debugPrint('$error');
        showErrorToast(error: error);
        emit(
          LogoutErrorState(),
        );
      },
    );
  }
}
