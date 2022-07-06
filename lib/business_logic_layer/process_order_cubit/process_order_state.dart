part of 'process_order_cubit.dart';

@immutable
abstract class ProcessOrderState {}

class ProcessOrderInitial extends ProcessOrderState {}

class ProcessOrderLoadingState extends ProcessOrderState {}

class ProcessOrderSuccessState extends ProcessOrderState {}

class ProcessOrderErrorState extends ProcessOrderState {}
