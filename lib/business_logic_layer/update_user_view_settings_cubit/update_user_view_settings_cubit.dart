import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/shared/network/local/cache_helper.dart';
import 'package:meta/meta.dart';

import '../../data_layer/repository/user_repository.dart';
import '../../shared/constants/constants.dart';

part 'update_user_view_settings_state.dart';

class UpdateUserViewSettingsCubit extends Cubit<UpdateUserViewSettingsState> {
  UpdateUserViewSettingsCubit() : super(UpdateUserViewSettingsInitial());

  static UpdateUserViewSettingsCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final UserRepository _userRepository = UserRepository();

  updateUserViewSettings({required String type}) {
    if (isLoggedIn) {
      updateSignedUserViewSettings(type: type);
    } else {
      updateUnSignedUserViewSettings(type: type);
    }
  }

  updateSignedUserViewSettings({required String type}) {
    emit(UpdateUserViewSettingsLoadingState());
    _userRepository.updateUserViewSettings(type: type).then(
      (value) async {
        await CacheHelper.saveData(key: viewTypeKey, value: type);
        viewType = CacheHelper.getData(key: viewTypeKey);
        showSuccessToast(successMessage: value);
        emit(UpdateUserViewSettingsSuccessState());
      },
    ).catchError((error) {
      showErrorToast(error: error);
      debugPrint('$error');
      emit(UpdateUserViewSettingsErrorState());
    });
  }

  updateUnSignedUserViewSettings({required String type}) {
    emit(UpdateUserViewSettingsLoadingState());
    CacheHelper.saveData(key: viewTypeKey, value: type).then(
      (value) async {
        viewType = CacheHelper.getData(key: viewTypeKey);
        showSuccessToast(successMessage: appLocalization!.viewSettingsIsUpdated);
        emit(UpdateUserViewSettingsSuccessState());
      },
    ).catchError((error) {
      showErrorToast(error: error);
      debugPrint('$error');
      emit(UpdateUserViewSettingsErrorState());
    });
  }
}
