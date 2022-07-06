import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/shared/constants/constants.dart';
part 'installation_state.dart';

class InstallationCubit extends Cubit<InstallationState> {
  InstallationCubit() : super(InstallationInitial());

  static InstallationCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);

  selectLanguage({required String langCode}) {
    chooseLanguageCode(langCode: langCode).then(
      (value) async {
        emit(ChooseLanguageSuccessState());
      },
    ).catchError((error) {
      showErrorToast(error: error);
      debugPrint('$error');
      emit(ChooseLanguageErrorState());
    });
  }
}
