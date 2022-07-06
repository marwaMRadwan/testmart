import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/subcategory_model.dart';

import '../../data_layer/repository/categories_repository.dart';

part 'subcategories_state.dart';

class SubcategoriesCubit extends Cubit<SubcategoriesState> {
  SubcategoriesCubit() : super(SubcategoriesInitial());

  static SubcategoriesCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final CategoriesRepository _categoriesRepository = CategoriesRepository();
  final List<SubcategoryModel> subcategories = [SubcategoryModel(id: '0')];

  getSubcategories({
    required String standId,
  }) {
    subcategories.removeRange(1, subcategories.length);
    emit(GetSubcategoriesDataLoadingState());
    _categoriesRepository
        .getSubcategories(
      standId: standId,
    )
        .then(
      (value) {
        subcategories.addAll(value);

        emit(GetSubcategoriesDataSuccessState());
      },
    ).catchError((error) {
      debugPrint('$error');
      emit(GetSubcategoriesDataErrorState(error: error));
    });
  }
}
