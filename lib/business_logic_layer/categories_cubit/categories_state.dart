part of 'categories_cubit.dart';

@immutable
abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class GetCategoriesDataLoadingState extends CategoriesState {}

class GetCategoriesDataSuccessState extends CategoriesState {}

class GetCategoriesDataEmptyState extends CategoriesState {}

class GetCategoriesDataErrorState extends CategoriesState {
  final error;

  GetCategoriesDataErrorState({required this.error});
}
