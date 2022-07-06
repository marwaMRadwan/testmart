part of 'top_markets_cubit.dart';

@immutable
abstract class TopMarketsState {}

class TopMarketsInitial extends TopMarketsState {}

class GetTopMarketsDataLoadingState extends TopMarketsState {}

class GetTopMarketsDataSuccessState extends TopMarketsState {}

class GetTopMarketsDataEmptyState extends TopMarketsState {}

class GetTopMarketsDataLastPageState extends TopMarketsState {}

class GetTopMarketsDataFirstPageState extends TopMarketsState {}

class GetTopMarketsDataOnlyOnePageState extends TopMarketsState {}

class GetTopMarketsDataErrorState extends TopMarketsState {
  final error;

  GetTopMarketsDataErrorState({required this.error});
}
