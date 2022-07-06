part of 'countries_cubit.dart';

@immutable
abstract class CountriesState {}

class CountriesInitial extends CountriesState {}

class GetCountriesDataLoadingState extends CountriesState {}

class GetCountriesDataSuccessState extends CountriesState {}

class GetCountriesDataEmptyState extends CountriesState {}

class GetCountriesDataErrorState extends CountriesState {
  final error;

  GetCountriesDataErrorState({required this.error});
}

class ChangeCountryState extends CountriesState {}
