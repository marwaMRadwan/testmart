import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/stand_model.dart';
import 'package:martizoom/data_layer/repository/categories_repository.dart';
import 'package:martizoom/shared/constants/constants.dart';

part 'stands_state.dart';

class StandsCubit extends Cubit<StandsState> {
  StandsCubit() : super(StandsInitial());

  static StandsCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final CategoriesRepository _categoriesRepository = CategoriesRepository();
  final List<StandModel> stands = [StandModel(id: '0',title: appLocalization!.all)];

  getStands({
    required String marketId,
    required String categoryId,
  }) {

    emit(GetStandsDataLoadingState());
    _categoriesRepository
        .getStands(marketId: marketId, categoryId: categoryId)
        .then(
      (value) {
        stands.addAll(value);
        if (stands.isEmpty) {
          emit(GetStandsDataEmptyState());
        } else {
          emit(GetStandsDataSuccessState());
        }
      },
    ).catchError((error) {
      debugPrint('$error');
      emit(GetStandsDataErrorState(error: error));
    });
  }
}
