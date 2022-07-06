import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/business_logic_layer/cart_widget_cubit/cart_widget_cubit.dart';
import 'package:martizoom/business_logic_layer/my_carts_cubit/my_carts_cubit.dart';
import 'package:martizoom/data_layer/models/cart_model.dart';
import 'package:martizoom/shared/constants/constants.dart';

class CartWidget extends StatefulWidget {
  final CartModel cartModel;
  final Function? computeTotalPrices;

  CartWidget({
    Key? key,
    required this.cartModel,
    this.computeTotalPrices,
  }) : super(key: key);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  CartModel get cartModel => widget.cartModel;

  Function? get computeTotalPrices => widget.computeTotalPrices;

  late final CartWidgetCubit _cartWidgetCubit;

  @override
  void initState() {
    // TODO: implement initState
    _cartWidgetCubit = CartWidgetCubit()..cartModel = cartModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cartWidgetCubit,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: setHeightValue(
              portraitValue: 0.12,
              landscapeValue: 0.23,
            ),
            width: setWidthValue(
              portraitValue: 0.23,
              landscapeValue: 0.13,
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
            child: Image.network(
              cartModel.image ?? '',
              fit: BoxFit.fill,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartModel.productsName ?? '',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  cartModel.marketName ?? '',
                  style: const TextStyle(
                    color: Color(0XFF8D98A4),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '\$ ${cartModel.marketProductsPrice ?? '0'}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          if (widget.computeTotalPrices != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BlocConsumer<CartWidgetCubit, CartWidgetState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is UpdateQuantityDataSuccessState) {
                      computeTotalPrices!();
                    }
                  },
                  builder: (context, state) {
                    return Row(
                      children: [
                        Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5.0,
                            ),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: IconButton(
                            padding: const EdgeInsets.all(0.0),
                            icon: const Icon(
                              Icons.remove,
                              size: 20.0,
                            ),
                            onPressed: () {
                              if (state is! UpdateQuantityDataLoadingState) {
                                _cartWidgetCubit.decrementQuantity();
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            '${cartModel.customersBasketQuantity}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                        Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5.0,
                            ),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: IconButton(
                            padding: const EdgeInsets.all(0.0),
                            icon: const Icon(
                              Icons.add,
                              size: 20.0,
                            ),
                            onPressed: () {
                              if (state is! UpdateQuantityDataLoadingState) {
                                _cartWidgetCubit.incrementQuantity();
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
                IconButton(
                    padding: const EdgeInsets.all(0.0),
                    alignment: AlignmentDirectional.bottomEnd,
                    onPressed: () {
                      MyCartsCubit.get(context).deleteMyCart(
                          basketId: cartModel.customersBasketId ?? '0');
                    },
                    icon: const Icon(
                      Icons.delete,
                      size: 30.0,
                      color: Colors.red,
                    )),
              ],
            ),
        ],
      ),
    );
  }
}
