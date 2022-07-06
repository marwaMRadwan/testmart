part of 'cart_product_cubit.dart';

@immutable
abstract class CartProductState {}

class CartProductInitial extends CartProductState {}

class ProcessOnCartProductLoadingState extends CartProductState {}

class ProcessOnCartProductSuccessState extends CartProductState {}

class ProcessOnCartProductErrorState extends CartProductState {}

class IncreaseQuantityState extends CartProductState {}

class DecreaseQuantityState extends CartProductState {}
