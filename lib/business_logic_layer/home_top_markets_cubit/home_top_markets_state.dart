part of 'home_top_markets_cubit.dart';

@immutable
abstract class HomeTopMarketsState {}

class MarketsInitial extends HomeTopMarketsState {}

class GetHomeTopMarketsDataLoadingState extends HomeTopMarketsState {}

class GetHomeTopMarketsDataSuccessState extends HomeTopMarketsState {}

class GetHomeTopMarketsDataEmptyState extends HomeTopMarketsState {}

class GetHomeTopMarketsDataErrorState extends HomeTopMarketsState {
  final error;

  GetHomeTopMarketsDataErrorState({required this.error});
}
