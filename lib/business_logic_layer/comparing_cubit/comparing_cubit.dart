import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/compare_model.dart';
import 'package:martizoom/data_layer/repository/carts_repository.dart';
import 'package:meta/meta.dart';

import '../../shared/constants/constants.dart';

part 'comparing_state.dart';

class ComparingCubit extends Cubit<ComparingState> {
  ComparingCubit() : super(ComparingInitial());

  static ComparingCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final CartsRepository _cartsRepository = CartsRepository();
  final List<CompareModel> comparedMarkets = [];

  compareMarkets({String? couponCode}) {
    comparedMarkets.clear();
    emit(CompareMarketsLoadingState());
    _cartsRepository.compareMarkets(couponCode: couponCode).then(
      (value) {
        comparedMarkets.addAll(value);
        print('${comparedMarkets[0].priceAfterDiscount}');
        if (comparedMarkets.isEmpty) {
          emit(CompareMarketsEmptyState());
        } else {
          emit(CompareMarketsSuccessState());
        }
      },
    ).catchError((error) {
      debugPrint('$error');
      showErrorToast(error: error);
      emit(CompareMarketsErrorState(error: error));
    });
  }
}
