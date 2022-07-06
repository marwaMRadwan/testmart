part of 'languages_cubit.dart';

@immutable
abstract class LanguagesState {}

class LanguagesInitial extends LanguagesState {}

class GetLanguagesDataLoadingState extends LanguagesState {}

class GetLanguagesDataSuccessState extends LanguagesState {}

class GetLanguagesDataEmptyState extends LanguagesState {}

class GetLanguagesDataErrorState extends LanguagesState {
  final error;

  GetLanguagesDataErrorState({required this.error});
}

class ChangeLanguageState extends LanguagesState {}
