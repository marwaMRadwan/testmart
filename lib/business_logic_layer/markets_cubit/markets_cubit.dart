import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/market_model.dart';
import 'package:martizoom/data_layer/repository/markets_repository.dart';
import 'package:martizoom/shared/constants/constants.dart';
import 'package:meta/meta.dart';

part 'markets_state.dart';

class MarketsCubit extends Cubit<MarketsState> {
  MarketsCubit() : super(MarketsInitial());

  static MarketsCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final MarketsRepository _marketsRepository = MarketsRepository();

  final List<MarketModel> _markets = [];
  final List<MarketModel> pageMarkets = [];
  int marketsCount = 0;
  final int limit = 12;
  int _page = 0;
  int pagesNumber = 0;

  getFirstMarkets() {
    /// clearing
    _markets.clear();
    pageMarkets.clear();
    emit(GetMarketsDataLoadingState());

    /// getting data
    _marketsRepository
        .getMarkets(
      page: _page,
      limit: limit,
    )
        .then(
      (value) {
        /// receiving data and prepare my properties.
        pageMarkets.addAll(value.markets ?? []);
        _markets.addAll(pageMarkets);
        marketsCount = value.count ?? 0;
        pagesNumber = ((value.count ?? 0) / limit).ceil();
        debugPrint(
            'count: $marketsCount, pageNums: $pagesNumber,page length: ${pageMarkets.length}');

        /// handle scenarios for the first time
        if (marketsCount == 0) {
          emit(GetMarketsDataEmptyState());
        } else if (_markets.length == marketsCount) {
          emit(GetMarketsDataOnlyOnePageState());
        } else {
          _page++;
          emit(GetMarketsDataFirstPageState());
        }
      },
    ).catchError((error) {
      debugPrint('$error');
      showErrorToast(error: error);
      emit(GetMarketsDataErrorState(error: error));
    });
  }

  getNextMarkets() {
    /// clearing
    pageMarkets.clear();
    emit(GetMarketsDataLoadingState());

    /// getting local data
    _page++;
    pageMarkets.addAll(getDataFromLocalMarketsList());

    if (pageMarkets.isNotEmpty) {
      if (_page == pagesNumber - 1) {
        emit(GetMarketsDataLastPageState());
      } else {
        emit(GetMarketsDataSuccessState());
      }
    } else {
      _page--;
      _marketsRepository
          .getMarkets(
        page: _page,
        limit: limit,
      )
          .then(
        (value) {
          /// receiving data and prepare my properties
          pageMarkets.addAll(value.markets ?? []);
          _markets.addAll(pageMarkets);

          /// handle scenarios for the first time
          if (_markets.length == marketsCount) {
            emit(GetMarketsDataLastPageState());
          } else {
            _page++;
            emit(GetMarketsDataSuccessState());
          }
        },
      ).catchError((error) {
        debugPrint('$error');
        showErrorToast(error: error);
        emit(GetMarketsDataErrorState(error: error));
      });
    }
  }

  getPreviousMarkets() {
    if (_page == 0) {
      emit(GetMarketsDataFirstPageState());
    } else {
      _page--;

      /// clearing
      pageMarkets.clear();
      pageMarkets.addAll(getDataFromLocalMarketsList());

      emit(GetMarketsDataSuccessState());
    }
  }

  List<MarketModel> getDataFromLocalMarketsList() {
    if (_page * limit <= _markets.length - 1) {
      int start = _page * limit;
      int end = start + limit;
      if (end > _markets.length) end = _markets.length;
      return _markets.sublist(
        start,
        end,
      );
    }
    return [];
  }
}
