part of 'orders_cubit.dart';

@immutable
abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class GetOrdersDataLoadingState extends OrdersState {}

class GetOrdersDataSuccessState extends OrdersState {}

class GetOrdersDataEmptyState extends OrdersState {}

class GetOrdersDataErrorState extends OrdersState {
  final error;

  GetOrdersDataErrorState({required this.error});
}
