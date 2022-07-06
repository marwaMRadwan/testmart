part of 'single_order_cubit.dart';

@immutable
abstract class SingleOrderState {}

class SingleOrderInitial extends SingleOrderState {}

class GetSingleOrderDataLoadingState extends SingleOrderState {}

class GetSingleOrderDataSuccessState extends SingleOrderState {}

class GetSingleOrderDataEmptyState extends SingleOrderState {}

class GetSingleOrderDataErrorState extends SingleOrderState {
  final error;

  GetSingleOrderDataErrorState({required this.error});
}
