import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/add_update_to_cart_model.dart';
import 'package:martizoom/data_layer/models/product_model.dart';
import 'package:martizoom/data_layer/repository/carts_repository.dart';
import 'package:martizoom/shared/constants/constants.dart';

part 'cart_product_state.dart';

class CartProductCubit extends Cubit<CartProductState> {
  CartProductCubit() : super(CartProductInitial());

  static CartProductCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final CartsRepository _cartsRepository = CartsRepository();
  ProductModel? productModel;
  int quantity = 0;

  addToCart({
    required String productId,
    required String marketId,
  }) {
    showLoadingToast();
    emit(ProcessOnCartProductLoadingState());
    _cartsRepository
        .addProductToCart(
            productId: productId,
            quantity: quantity.toString(),
            marketId: marketId)
        .then((value) {
      final AddUpdateToCartModel addUpdateToCartModel = value;
      productModel!.inCart = 1;
      productModel!.cartId =
          int.tryParse(addUpdateToCartModel.data?.cartId ?? '0');
      debugPrint('cartId: ${productModel!.cartId}');
      showSuccessToast(successMessage: addUpdateToCartModel.success ?? '');
      emit(ProcessOnCartProductSuccessState());
    }).catchError((error) {
      showErrorToast(error: error);
      emit(ProcessOnCartProductErrorState());
    });
  }

  updateCart({required String cartId, required bool isIncrease}) {
    showLoadingToast();
    emit(ProcessOnCartProductLoadingState());
    int q = quantity;
    if (isIncrease) {
      q++;
    } else {
      q--;
    }
    _cartsRepository
        .updateMyCart(
      basketId: cartId,
      quantity: q.toString(),
    )
        .then((value) {
      if (isIncrease) {
        quantity++;
      } else {
        quantity--;
      }
      final AddUpdateToCartModel addUpdateToCartModel = value;
      showSuccessToast(successMessage: addUpdateToCartModel.success ?? '');
      emit(ProcessOnCartProductSuccessState());
    }).catchError((error) {
      showErrorToast(error: error);
      emit(ProcessOnCartProductErrorState());
    });
  }

  deleteCart({
    required String cartId,
  }) {
    showLoadingToast();
    emit(ProcessOnCartProductLoadingState());
    _cartsRepository
        .deleteMyCart(
      basketId: cartId,
    )
        .then((value) {
      productModel!.inCart = 0;
      productModel!.cartId = 0;
      quantity--;
      showSuccessToast(successMessage: value);
      emit(ProcessOnCartProductSuccessState());
    }).catchError((error) {
      showErrorToast(error: error);
      emit(ProcessOnCartProductErrorState());
    });
  }

  increaseQuantity() {
    quantity++;
    emit(IncreaseQuantityState());
  }

  decreaseQuantity() {
    if (quantity > 0) {
      quantity--;
      emit(DecreaseQuantityState());
    }
  }
}
