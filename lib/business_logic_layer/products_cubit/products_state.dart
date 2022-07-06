part of 'products_cubit.dart';

@immutable
abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class GetProductsDataLoadingState extends ProductsState {}

class GetProductsDataSuccessState extends ProductsState {}

class GetProductsDataEmptyState extends ProductsState {}

class GetProductsDataLastPageState extends ProductsState {}

class GetProductsDataErrorState extends ProductsState {
  final error;

  GetProductsDataErrorState({
    required this.error,
  });
}
