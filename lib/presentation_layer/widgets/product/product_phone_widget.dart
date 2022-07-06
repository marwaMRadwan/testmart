import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/product_model.dart';
import 'package:martizoom/shared/constants/constants.dart';

import '../../../business_logic_layer/cart_product_cubit/cart_product_cubit.dart';
import '../../../shared/styles/colors.dart';

class ProductPhoneWidget extends StatefulWidget {
  final ProductModel productModel;
  final String marketId;

  const ProductPhoneWidget(
      {Key? key, required this.productModel, required this.marketId})
      : super(key: key);

  @override
  State<ProductPhoneWidget> createState() => _ProductPhoneWidgetState();
}

class _ProductPhoneWidgetState extends State<ProductPhoneWidget> {
  String get marketId => widget.marketId;

  final CartProductCubit _addUpdateCartCubit = CartProductCubit();

  @override
  void initState() {
    _addUpdateCartCubit.productModel = widget.productModel;
    if (_addUpdateCartCubit.productModel!.inCart == 1) {
      _addUpdateCartCubit.quantity =
          _addUpdateCartCubit.productModel!.cartQuantity ?? 0;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          5.0,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: setHeightValue(
              portraitValue: 0.16,
              landscapeValue: 0.25,
            ),
            color: Colors.grey,
            child: Image.network(
              _addUpdateCartCubit.productModel!.image ?? '',
              fit: BoxFit.fill,
              width: double.infinity,
              errorBuilder: (_, __, ___) => Container(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: setWidthValue(
                portraitValue: 0.02,
                landscapeValue: 0.015,
              ),
              vertical: setHeightValue(
                portraitValue: 0.015,
                landscapeValue: 0.03,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: setHeightValue(
                    portraitValue: 0.01,
                    landscapeValue: 0.01,
                  ),
                ),
                Text(
                  _addUpdateCartCubit.productModel!.productsName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
                Text(
                  _addUpdateCartCubit.productModel!.productsDescription ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                    fontSize: 12.0,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      _addUpdateCartCubit.productModel!.mainPrice ?? '',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: _addUpdateCartCubit.productModel!.offerPrice ==
                                  true
                              ? Colors.grey
                              : defaultColor,
                          decoration:
                              _addUpdateCartCubit.productModel!.offerPrice ==
                                      true
                                  ? TextDecoration.lineThrough
                                  : null),
                    ),
                    if (_addUpdateCartCubit.productModel!.offerPrice == true)
                      Row(
                        children: [
                          const SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            _addUpdateCartCubit
                                    .productModel!.priceAfterDiscount ??
                                '',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: defaultColor,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                BlocProvider(
                  create: (context) => _addUpdateCartCubit,
                  child: BlocConsumer<CartProductCubit, CartProductState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      return SizedBox(
                        height: setHeightValue(
                          portraitValue: 0.06,
                          landscapeValue: 0.1,
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: setHeightValue(
                                  portraitValue: 0.045,
                                  landscapeValue: 0.07,
                                ),
                                decoration: BoxDecoration(
                                  color: defaultColor,
                                  border: Border.all(
                                    color: Colors.black26,
                                  ),
                                ),
                                child: InkWell(
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                  onTap:
                                      state is ProcessOnCartProductLoadingState ||
                                              !isLoggedIn
                                          ? () {
                                              showErrorToast(
                                                error: HttpException(
                                                    '${appLocalization?.pleaseLoginFirst}'),
                                              );
                                            }
                                          : () {
                                              if (_addUpdateCartCubit.quantity >
                                                  1) {
                                                if (_addUpdateCartCubit
                                                        .productModel!.inCart ==
                                                    1) {
                                                  _addUpdateCartCubit.updateCart(
                                                      cartId:
                                                          _addUpdateCartCubit
                                                              .productModel!
                                                              .cartId
                                                              .toString(),
                                                      isIncrease: false);
                                                } else {
                                                  _addUpdateCartCubit
                                                      .decreaseQuantity();
                                                }
                                              } else if (_addUpdateCartCubit
                                                      .quantity ==
                                                  1) {
                                                _addUpdateCartCubit.deleteCart(
                                                    cartId: _addUpdateCartCubit
                                                        .productModel!.cartId
                                                        .toString());
                                              }
                                            },
                                ),
                              ),
                              Container(
                                height: setHeightValue(
                                  portraitValue: 0.045,
                                  landscapeValue: 0.07,
                                ),
                                width: setWidthValue(
                                  portraitValue: 0.1,
                                  landscapeValue: 0.06,
                                ),
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  border: Border.symmetric(
                                    horizontal: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  _addUpdateCartCubit.quantity.toString(),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                height: setHeightValue(
                                  portraitValue: 0.045,
                                  landscapeValue: 0.07,
                                ),
                                decoration: BoxDecoration(
                                  color: defaultColor,
                                  border: Border.all(
                                    color: Colors.black26,
                                  ),
                                ),
                                child: InkWell(
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  onTap:
                                      state is ProcessOnCartProductLoadingState ||
                                              !isLoggedIn
                                          ? () {
                                              showErrorToast(
                                                error: HttpException(
                                                    '${appLocalization?.pleaseLoginFirst}'),
                                              );
                                            }
                                          : () {
                                              if (_addUpdateCartCubit
                                                      .productModel!.inCart ==
                                                  1) {
                                                _addUpdateCartCubit.updateCart(
                                                    cartId: _addUpdateCartCubit
                                                        .productModel!.cartId
                                                        .toString(),
                                                    isIncrease: true);
                                              } else {
                                                _addUpdateCartCubit
                                                    .increaseQuantity();
                                              }
                                            },
                                ),
                              ),
                              SizedBox(
                                width: setWidthValue(
                                  portraitValue: 0.02,
                                  landscapeValue: 0.03,
                                ),
                              ),
                              if (_addUpdateCartCubit.productModel!.inCart != 1)
                                InkWell(
                                  child: Container(
                                    height: setHeightValue(
                                      portraitValue: 0.045,
                                      landscapeValue: 0.07,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: setHeightValue(
                                        portraitValue: 0.0055,
                                        landscapeValue: 0.01,
                                      ),
                                      horizontal: setWidthValue(
                                        portraitValue: 0.02,
                                        landscapeValue: 0.015,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.local_grocery_store_rounded,
                                      color: Colors.white,
                                    ),
                                    color: defaultColor,
                                  ),
                                  onTap: state
                                          is ProcessOnCartProductLoadingState
                                      ? null
                                      : !isLoggedIn
                                          ? () {
                                              showErrorToast(
                                                error: HttpException(
                                                    '${appLocalization?.pleaseLoginFirst}'),
                                              );
                                            }
                                          : () {
                                              if (_addUpdateCartCubit.quantity >
                                                  0) {
                                                _addUpdateCartCubit.addToCart(
                                                  productId: _addUpdateCartCubit
                                                          .productModel!.id ??
                                                      '0',
                                                  marketId: marketId,
                                                );
                                              }
                                            },
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
