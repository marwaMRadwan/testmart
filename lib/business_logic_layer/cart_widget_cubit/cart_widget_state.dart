part of 'cart_widget_cubit.dart';

@immutable
abstract class CartWidgetState {}

class CartWidgetInitial extends CartWidgetState {}

class UpdateQuantityDataLoadingState extends CartWidgetState {}

class UpdateQuantityDataSuccessState extends CartWidgetState {}

class UpdateQuantityDataErrorState extends CartWidgetState {}
