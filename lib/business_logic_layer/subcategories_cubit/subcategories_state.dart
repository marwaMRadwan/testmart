part of 'subcategories_cubit.dart';

@immutable
abstract class SubcategoriesState {}

class SubcategoriesInitial extends SubcategoriesState {}

class GetSubcategoriesDataLoadingState extends SubcategoriesState {}

class GetSubcategoriesDataSuccessState extends SubcategoriesState {}

class GetSubcategoriesDataErrorState extends SubcategoriesState {
  final error;

  GetSubcategoriesDataErrorState({required this.error});
}
