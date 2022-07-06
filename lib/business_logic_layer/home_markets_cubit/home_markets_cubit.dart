import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/market_model.dart';
import 'package:martizoom/data_layer/repository/markets_repository.dart';
import 'package:martizoom/shared/constants/constants.dart';
import 'package:meta/meta.dart';

part 'home_markets_state.dart';

class HomeMarketsCubit extends Cubit<HomeMarketsState> {
  HomeMarketsCubit() : super(HomeMarketsInitial());

  static HomeMarketsCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final MarketsRepository _marketsRepository = MarketsRepository();

  final List<MarketModel> markets = [];
  int marketsCount = 0;
  final int limit = 9;

  getHomeMarkets() {
    markets.clear();
    emit(GetHomeMarketsDataLoadingState());
    _marketsRepository
        .getMarkets(
      page: 0,
      limit: limit,
    )
        .then(
      (value) {
        markets.addAll(value.markets ?? []);
        marketsCount = value.count ?? 0;
        if (marketsCount == 0) {
          emit(GetHomeMarketsDataEmptyState());
        } else {
          emit(GetHomeMarketsDataSuccessState());
        }
      },
    ).catchError((error) {
      debugPrint('$error');
      showErrorToast(error: error);
      emit(GetHomeMarketsDataErrorState(error: error));
    });
  }
}
