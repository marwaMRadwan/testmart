part of 'search_markets_cubit.dart';

@immutable
abstract class SearchMarketsState {}

class SearchMarketsInitial extends SearchMarketsState {}

class SearchMarketsDataLoadingState extends SearchMarketsState {}

class SearchMarketsDataSuccessState extends SearchMarketsState {}

class SearchMarketsDataEmptyState extends SearchMarketsState {}

class SearchMarketsDataLastPageState extends SearchMarketsState {}

class SearchMarketsDataFirstPageState extends SearchMarketsState {}

class SearchMarketsDataOnlyOnePageState extends SearchMarketsState {}

class SearchMarketsDataErrorState extends SearchMarketsState {
  final error;

  SearchMarketsDataErrorState({required this.error});
}
