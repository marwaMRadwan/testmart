import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/category_model.dart';
import 'package:martizoom/data_layer/repository/markets_repository.dart';
import 'package:martizoom/shared/constants/constants.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  static CategoriesCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final MarketsRepository _generalRepository = MarketsRepository();
  final List<CategoryModel> categories = [];

  getCategories({required String marketId}) {
    categories.clear();
    emit(GetCategoriesDataLoadingState());
    _generalRepository.getMarketCategories(marketId: marketId).then(
      (value) {
        categories.addAll(value);
        if (categories.isEmpty) {
          emit(GetCategoriesDataEmptyState());
        } else {
          emit(GetCategoriesDataSuccessState());
        }
      },
    ).catchError((error) {
      debugPrint('$error');
      showErrorToast(error: error);
      emit(GetCategoriesDataErrorState(error: error));
    });
  }
}
