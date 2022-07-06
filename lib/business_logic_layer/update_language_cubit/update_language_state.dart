part of 'update_language_cubit.dart';

@immutable
abstract class UpdateLanguageState {}

class UpdateLanguageInitial extends UpdateLanguageState {}

class UpdateUserLanguageLoadingState extends UpdateLanguageState {}

class UpdateUserLanguageSuccessState extends UpdateLanguageState {}

class UpdateUserLanguageErrorState extends UpdateLanguageState {}
