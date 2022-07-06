import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/language_model.dart';
import 'package:martizoom/data_layer/repository/general_repository.dart';
import 'package:martizoom/shared/constants/constants.dart';

part 'languages_state.dart';

class LanguagesCubit extends Cubit<LanguagesState> {
  LanguagesCubit() : super(LanguagesInitial());

  static LanguagesCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final GeneralRepository _generalRepository = GeneralRepository();
  final List<LanguageModel> languages = [];

  getLanguages() {
    languages.clear();
    emit(GetLanguagesDataLoadingState());
    _generalRepository.getLanguages().then(
      (value) {
        languages.addAll(value);
        if (languages.isEmpty) {
          emit(GetLanguagesDataEmptyState());
        } else {
          emit(GetLanguagesDataSuccessState());
        }
      },
    ).catchError((error) {
      debugPrint('$error');
      showErrorToast(error: error);
      emit(GetLanguagesDataErrorState(error: error));
    });
  }

  changeLanguage() {
    emit(
      ChangeLanguageState(),
    );
  }
}
