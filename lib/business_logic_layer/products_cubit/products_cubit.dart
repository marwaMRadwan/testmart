import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/product_model.dart';
import 'package:meta/meta.dart';

import '../../data_layer/repository/markets_repository.dart';
import '../../shared/constants/constants.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial()) {
    scrollController.addListener(() async {
      if (state is! GetProductsDataLoadingState &&
          state is! GetProductsDataLastPageState &&
          scrollController.position.pixels + 200.0 >
              scrollController.position.maxScrollExtent) {
        getProductsByCategory();
      }
    });
  }

  static ProductsCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final MarketsRepository _marketsRepository = MarketsRepository();
  ScrollController scrollController = ScrollController();
  String marketId = "0";
  String standId = "0";
  String categoryId = "0";

  final List<ProductModel> products = [];
  final int limit = 10;
  int page = 0;

  getProductsByCategory() {
    /// clearing
    if (page == 0) {
      products.clear();
    }
    emit(GetProductsDataLoadingState());
    _marketsRepository
            .getProductsByCategory(
      marketId: marketId,
      standId: standId,
      categoryId: categoryId,
      page: page,
      limit: limit,
    )
            .then(
      (value) {
        /// receiving data and prepare my properties
        products.addAll(value.data ?? []);
        debugPrint('products length : ${products.length}');
        if (products.isEmpty) {
          emit(GetProductsDataEmptyState());
        } else if (products.length == value.count) {
          emit(GetProductsDataLastPageState());
        } else {
          page++;
          emit(GetProductsDataSuccessState());
        }
      },
    )
            .catchError((error) {
          debugPrint('$error');
          showErrorToast(error: error);
          emit(GetProductsDataErrorState(error: error));
        })
        ;
  }

  reset() {
    page = 0;
  }
}
