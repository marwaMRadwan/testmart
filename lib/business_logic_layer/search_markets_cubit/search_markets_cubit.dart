import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/market_model.dart';
import 'package:martizoom/data_layer/repository/markets_repository.dart';
import 'package:martizoom/shared/constants/constants.dart';

part 'search_markets_state.dart';

class SearchMarketsCubit extends Cubit<SearchMarketsState> {
  SearchMarketsCubit() : super(SearchMarketsInitial());

  static SearchMarketsCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final MarketsRepository _marketsRepository = MarketsRepository();

  final List<MarketModel> _markets = [];
  final List<MarketModel> pageMarkets = [];
  int marketsCount = 0;
  final int limit = 12;
  int _page = 0;
  int pagesNumber = 0;

  getFirstMarkets({required String word}) {
    /// clearing
    _page = 0;
    _markets.clear();
    pageMarkets.clear();
    emit(SearchMarketsDataLoadingState());

    /// getting data
    _marketsRepository
        .searchMarkets(page: _page, limit: limit, word: word)
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
          emit(SearchMarketsDataEmptyState());
        } else if (_markets.length == marketsCount) {
          emit(SearchMarketsDataOnlyOnePageState());
        } else {
          _page++;
          emit(SearchMarketsDataFirstPageState());
        }
      },
    ).catchError((error) {
      debugPrint('$error');
      showErrorToast(error: error);
      emit(SearchMarketsDataErrorState(error: error));
    });
  }

  getNextMarkets({required String word}) {
    /// clearing
    pageMarkets.clear();
    emit(SearchMarketsDataLoadingState());

    /// getting local data
    _page++;
    pageMarkets.addAll(getDataFromLocalTopMarketsList());

    if (pageMarkets.isNotEmpty) {
      if (_page == pagesNumber - 1) {
        emit(SearchMarketsDataLastPageState());
      } else {
        emit(SearchMarketsDataSuccessState());
      }
    } else {
      _page--;
      _marketsRepository
          .searchMarkets(page: _page, limit: limit, word: word)
          .then(
        (value) {
          /// receiving data and prepare my properties
          pageMarkets.addAll(value.markets ?? []);
          _markets.addAll(pageMarkets);

          /// handle scenarios for the first time
          if (_markets.length == marketsCount) {
            emit(SearchMarketsDataLastPageState());
          } else {
            _page++;
            emit(SearchMarketsDataSuccessState());
          }
        },
      ).catchError((error) {
        debugPrint('$error');
        showErrorToast(error: error);
        emit(SearchMarketsDataErrorState(error: error));
      });
    }
  }

  getPreviousTopMarkets() {
    if (_page == 0) {
      emit(SearchMarketsDataFirstPageState());
    } else {
      _page--;

      /// clearing
      pageMarkets.clear();
      pageMarkets.addAll(getDataFromLocalTopMarketsList());

      emit(SearchMarketsDataSuccessState());
    }
  }

  List<MarketModel> getDataFromLocalTopMarketsList() {
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
