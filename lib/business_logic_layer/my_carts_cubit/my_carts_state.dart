part of 'my_carts_cubit.dart';

@immutable
abstract class MyCartsState {}

class MyCartsInitial extends MyCartsState {}

class GetMyCartsDataLoadingState extends MyCartsState {}

class GetMyCartsDataSuccessState extends MyCartsState {}

class GetMyCartsDataEmptyState extends MyCartsState {}

class GetMyCartsDataErrorState extends MyCartsState {
  final error;

  GetMyCartsDataErrorState({required this.error});
}

class DeleteMyCartLoadingState extends MyCartsState {}

class DeleteMyCartSuccessState extends MyCartsState {}

class DeleteMyCartErrorState extends MyCartsState {}

class ComputeTotalPriceState extends MyCartsState {}
