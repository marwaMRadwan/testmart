part of 'stands_cubit.dart';

@immutable
abstract class StandsState {}

class StandsInitial extends StandsState {}

class GetStandsDataLoadingState extends StandsState {}

class GetStandsDataSuccessState extends StandsState {}

class GetStandsDataEmptyState extends StandsState {}

class GetStandsDataErrorState extends StandsState {
  final error;

  GetStandsDataErrorState({required this.error});
}
