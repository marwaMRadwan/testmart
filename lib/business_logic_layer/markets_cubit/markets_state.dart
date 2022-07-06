part of 'markets_cubit.dart';

@immutable
abstract class MarketsState {}

class MarketsInitial extends MarketsState {}

class GetMarketsDataLoadingState extends MarketsState {}

class GetMarketsDataSuccessState extends MarketsState {}

class GetMarketsDataEmptyState extends MarketsState {}

class GetMarketsDataLastPageState extends MarketsState {}

class GetMarketsDataFirstPageState extends MarketsState {}

class GetMarketsDataOnlyOnePageState extends MarketsState {}

class GetMarketsDataErrorState extends MarketsState {
  final error;

  GetMarketsDataErrorState({required this.error});
}
