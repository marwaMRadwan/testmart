import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/cart_model.dart';
import 'package:martizoom/data_layer/repository/carts_repository.dart';
import 'package:martizoom/shared/constants/constants.dart';
import 'package:meta/meta.dart';

part 'my_carts_state.dart';

class MyCartsCubit extends Cubit<MyCartsState> {
  MyCartsCubit() : super(MyCartsInitial());

  static MyCartsCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final CartsRepository _cartsRepository = CartsRepository();
  final List<CartModel> myCarts = [];
  double shippingPrice = 0.0;

  getMyCarts() {
    myCarts.clear();
    debugPrint('before carts: ${myCarts.length}');

    emit(GetMyCartsDataLoadingState());
    _cartsRepository.getMyCarts().then(
      (value) {
        myCarts.addAll(value.data ?? []);
        debugPrint('carts: ${myCarts.length}');
        shippingPrice = double.tryParse(value.shippingPrice ?? '') ?? 0.0;
        if (myCarts.isNotEmpty) {
          computeTotalPrice();
          emit(GetMyCartsDataSuccessState());
        } else {
          emit(GetMyCartsDataEmptyState());
        }
      },
    ).catchError(
      (error) {
        debugPrint('$error');
        emit(GetMyCartsDataErrorState(error: error));
      },
    );
  }

  deleteMyCart({required String basketId}) {
    showLoadingToast();
    emit(DeleteMyCartLoadingState());
    _cartsRepository.deleteMyCart(basketId: basketId).then((value) {
      myCarts.removeWhere((element) => element.customersBasketId == basketId);

      /// After deleting the cart check there
      /// is another cart or not, where in case
      /// no carts i emit the empty state
      if (myCarts.isEmpty) {
        emit(GetMyCartsDataEmptyState());
      } else {
        emit(DeleteMyCartSuccessState());
      }

      showSuccessToast(
          successMessage: appLocalization!.cartIsSuccessfullyDeleted);
    }).catchError((error) {
      debugPrint('$error');
      showErrorToast(error: error);
      emit(DeleteMyCartErrorState());
    });
  }

  double totalPrice = 0.0;

  computeTotalPrice() {
    totalPrice = 0.0;
    for (CartModel cart in myCarts) {
      int q = int.tryParse(cart.customersBasketQuantity ?? '0') ?? 0;
      double price = double.tryParse(cart.marketProductsPrice ?? '0.0') ?? 0.0;
      totalPrice += q * price;
    }
    totalPrice += shippingPrice;
    debugPrint('totalPrice: $totalPrice');
    emit(ComputeTotalPriceState());
  }
}
