import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/market_model.dart';
import 'package:martizoom/data_layer/repository/markets_repository.dart';
import 'package:martizoom/shared/constants/constants.dart';
import 'package:meta/meta.dart';

part 'home_top_markets_state.dart';

class HomeTopMarketsCubit extends Cubit<HomeTopMarketsState> {
  HomeTopMarketsCubit() : super(MarketsInitial());

  static HomeTopMarketsCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final MarketsRepository _marketsRepository = MarketsRepository();

  final List<MarketModel> topMarkets = [];
  int topMarketsCount = 0;
  final int limit = 9;
  String? zoneId;

  getHomeTopMarkets() {
    topMarkets.clear();
    emit(GetHomeTopMarketsDataLoadingState());
    _marketsRepository
        .getTopMarkets(page: 0, limit: limit, zoneId: zoneId)
        .then(
      (value) {
        topMarkets.addAll(value.markets ?? []);
        topMarketsCount = value.count ?? 0;
        if (topMarketsCount == 0) {
          emit(GetHomeTopMarketsDataEmptyState());
        } else {
          emit(GetHomeTopMarketsDataSuccessState());
        }
      },
    ).catchError((error) {
      debugPrint('$error');
      showErrorToast(error: error);
      emit(GetHomeTopMarketsDataErrorState(error: error));
    });
  }
}
