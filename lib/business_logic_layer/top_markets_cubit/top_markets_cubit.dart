import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/market_model.dart';
import 'package:martizoom/data_layer/repository/markets_repository.dart';
import 'package:martizoom/shared/constants/constants.dart';

part 'top_markets_state.dart';

class TopMarketsCubit extends Cubit<TopMarketsState> {
  TopMarketsCubit() : super(TopMarketsInitial());

  static TopMarketsCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final MarketsRepository _marketsRepository = MarketsRepository();

  final List<MarketModel> _topMarkets = [];
  final List<MarketModel> pageTopMarkets = [];
  int topMarketsCount = 0;
  final int limit = 12;
  String? zoneId;
  int _page = 0;
  int pagesNumber = 0;

  getFirstTopMarkets() {
    /// clearing
    _topMarkets.clear();
    pageTopMarkets.clear();
    emit(GetTopMarketsDataLoadingState());

    /// getting data
    _marketsRepository
        .getTopMarkets(page: _page, limit: limit, zoneId: zoneId)
        .then(
      (value) {
        /// receiving data and prepare my properties.
        pageTopMarkets.addAll(value.markets ?? []);
        _topMarkets.addAll(pageTopMarkets);
        topMarketsCount = value.count ?? 0;
        pagesNumber = ((value.count ?? 0) / limit).ceil();
        debugPrint(
            'count: $topMarketsCount, pageNums: $pagesNumber,page length: ${pageTopMarkets.length}');

        /// handle scenarios for the first time
        if (topMarketsCount == 0) {
          emit(GetTopMarketsDataEmptyState());
        } else if (_topMarkets.length == topMarketsCount) {
          emit(GetTopMarketsDataOnlyOnePageState());
        } else {
          _page++;
          emit(GetTopMarketsDataFirstPageState());
        }
      },
    ).catchError((error) {
      debugPrint('$error');
      showErrorToast(error: error);
      emit(GetTopMarketsDataErrorState(error: error));
    });
  }

  getNextTopMarkets() {
    /// clearing
    pageTopMarkets.clear();
    emit(GetTopMarketsDataLoadingState());

    /// getting local data
    _page++;
    pageTopMarkets.addAll(getDataFromLocalTopMarketsList());

    if (pageTopMarkets.isNotEmpty) {
      if (_page == pagesNumber - 1) {
        emit(GetTopMarketsDataLastPageState());
      } else {
        emit(GetTopMarketsDataSuccessState());
      }
    } else {
      _page--;
      _marketsRepository
          .getTopMarkets(page: _page, limit: limit, zoneId: zoneId)
          .then(
        (value) {
          /// receiving data and prepare my properties
          pageTopMarkets.addAll(value.markets ?? []);
          _topMarkets.addAll(pageTopMarkets);

          /// handle scenarios for the first time
          if (_topMarkets.length == topMarketsCount) {
            emit(GetTopMarketsDataLastPageState());
          } else {
            _page++;
            emit(GetTopMarketsDataSuccessState());
          }
        },
      ).catchError((error) {
        debugPrint('$error');
        showErrorToast(error: error);
        emit(GetTopMarketsDataErrorState(error: error));
      });
    }
  }

  getPreviousTopMarkets() {
    if (_page == 0) {
      emit(GetTopMarketsDataFirstPageState());
    } else {
      _page--;

      /// clearing
      pageTopMarkets.clear();
      pageTopMarkets.addAll(getDataFromLocalTopMarketsList());

      emit(GetTopMarketsDataSuccessState());
    }
  }

  List<MarketModel> getDataFromLocalTopMarketsList() {
    if (_page * limit <= _topMarkets.length - 1) {
      int start = _page * limit;
      int end = start + limit;
      if (end > _topMarkets.length) end = _topMarkets.length;
      return _topMarkets.sublist(
        start,
        end,
      );
    }
    return [];
  }
}
