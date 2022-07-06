part of 'installation_cubit.dart';

@immutable
abstract class InstallationState {}

class InstallationInitial extends InstallationState {}

class ChooseLanguageSuccessState extends InstallationState {}

class ChooseLanguageErrorState extends InstallationState {}
