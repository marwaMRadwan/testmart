part of 'cities_cubit.dart';

@immutable
abstract class CitiesState {}

class CitiesInitial extends CitiesState {}

class GetCitiesDataLoadingState extends CitiesState {}

class GetCitiesDataSuccessState extends CitiesState {}

class GetCitiesDataEmptyState extends CitiesState {}

class GetCitiesDataErrorState extends CitiesState {}

class ChangeCityState extends CitiesState {}
