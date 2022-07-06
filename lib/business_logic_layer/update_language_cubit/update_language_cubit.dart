import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/repository/user_repository.dart';
import 'package:martizoom/shared/constants/constants.dart';

part 'update_language_state.dart';

class UpdateLanguageCubit extends Cubit<UpdateLanguageState> {
  UpdateLanguageCubit() : super(UpdateLanguageInitial());

  static UpdateLanguageCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final UserRepository _userRepository = UserRepository();

  updateUserLanguage({required String langId}) {
    emit(UpdateUserLanguageLoadingState());
    _userRepository.updateUserLanguage(langId: langId).then(
      (value) async {
        await chooseLanguageCode(langCode: langId=='1'?'en':'ar');
        showSuccessToast(successMessage: value);
        emit(UpdateUserLanguageSuccessState());
      },
    ).catchError((error) {
      showErrorToast(error: error);
      debugPrint('$error');
      emit(UpdateUserLanguageErrorState());
    });
  }
}
