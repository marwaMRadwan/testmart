import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/cart_model.dart';
import 'package:martizoom/data_layer/repository/carts_repository.dart';
import 'package:martizoom/shared/constants/constants.dart';
import 'package:meta/meta.dart';

part 'cart_widget_state.dart';

class CartWidgetCubit extends Cubit<CartWidgetState> {
  CartWidgetCubit() : super(CartWidgetInitial());

  static CartWidgetCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final CartsRepository _cartsRepository = CartsRepository();
  CartModel? cartModel;

  incrementQuantity() {
    emit(UpdateQuantityDataLoadingState());
    int quantity = int.tryParse(cartModel?.customersBasketQuantity ?? '0') ?? 0;
    cartModel?.customersBasketQuantity = (++quantity).toString();
    updateQuantity();
  }

  decrementQuantity() {
    emit(UpdateQuantityDataLoadingState());
    int quantity = int.tryParse(cartModel?.customersBasketQuantity ?? '0') ?? 0;
    if (quantity > 0) {
      cartModel?.customersBasketQuantity = (--quantity).toString();
      updateQuantity();
    }
  }

  updateQuantity() {
    _cartsRepository
        .updateMyCart(
      basketId: cartModel?.customersBasketId ?? '0',
      quantity: cartModel?.customersBasketQuantity ?? '0',
    )
        .then((value) {
      emit(UpdateQuantityDataSuccessState());
    }).catchError((error) {
      debugPrint('$error');
      showErrorToast(error: error);
      emit(UpdateQuantityDataErrorState());
    });
  }
}
