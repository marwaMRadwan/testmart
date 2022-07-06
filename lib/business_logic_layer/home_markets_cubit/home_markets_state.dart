part of 'home_markets_cubit.dart';

@immutable
abstract class HomeMarketsState {}

class HomeMarketsInitial extends HomeMarketsState {}

class GetHomeMarketsDataLoadingState extends HomeMarketsState {}

class GetHomeMarketsDataSuccessState extends HomeMarketsState {}

class GetHomeMarketsDataEmptyState extends HomeMarketsState {}

class GetHomeMarketsDataErrorState extends HomeMarketsState {
  final error;

  GetHomeMarketsDataErrorState({required this.error});
}
