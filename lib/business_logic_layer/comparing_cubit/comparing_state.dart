part of 'comparing_cubit.dart';

@immutable
abstract class ComparingState {}

class ComparingInitial extends ComparingState {}

class CompareMarketsLoadingState extends ComparingState {}

class CompareMarketsSuccessState extends ComparingState {}

class CompareMarketsEmptyState extends ComparingState {}

class CompareMarketsErrorState extends ComparingState {
  final error;

  CompareMarketsErrorState({required this.error});
}
