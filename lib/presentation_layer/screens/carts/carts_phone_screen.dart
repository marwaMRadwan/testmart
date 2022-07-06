import 'dart:io';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/business_logic_layer/my_carts_cubit/my_carts_cubit.dart';
import 'package:martizoom/business_logic_layer/user_data_cubit/user_data_cubit.dart';
import 'package:martizoom/presentation_layer/screens/addresses/addresses_phone_screen.dart';
import 'package:martizoom/presentation_layer/screens/comparing/comparing_phone_screen.dart';
import 'package:martizoom/presentation_layer/screens/loading/loading_screen.dart';
import 'package:martizoom/presentation_layer/widgets/app_header/app_header_widget.dart';
import 'package:martizoom/presentation_layer/widgets/cart/cart_widget.dart';
import 'package:martizoom/shared/components/default_app_bar/default_phone_app_bar.dart';
import 'package:martizoom/shared/components/default_button.dart';
import 'package:martizoom/shared/components/default_empty_items_text.dart';
import 'package:martizoom/shared/components/default_error_widget.dart';
import 'package:martizoom/shared/constants/constants.dart';
import 'package:martizoom/shared/styles/colors.dart';
import '../../../business_logic_layer/coupon_cubit/coupon_cubit.dart';

class CartsPhoneScreen extends StatefulWidget {
  final bool showAppHeader;

  CartsPhoneScreen({
    Key? key,
    this.showAppHeader = true,
  }) : super(key: key);

  @override
  State<CartsPhoneScreen> createState() => _CartsPhoneScreenState();
}

class _CartsPhoneScreenState extends State<CartsPhoneScreen> {
  final CouponCubit _couponCubit = CouponCubit();

  final TextEditingController _couponTextController = TextEditingController();
  late MyCartsCubit _myCartsCubit;

  @override
  void initState() {
    _myCartsCubit = MyCartsCubit.get(context);
    _myCartsCubit.getMyCarts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppHeader
          ? null
          : DefaultPhoneAppBar(
              title: appLocalization!.carts,
            ),
      body: UserDataCubit.get(context).appUser?.defaultAddress != null
          ? BlocProvider(
              create: (context) => _couponCubit,
              child: SingleChildScrollView(
                child: BlocListener<MyCartsCubit, MyCartsState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is DeleteMyCartSuccessState) {
                      _myCartsCubit.computeTotalPrice();
                    }
                  },
                  child: BlocBuilder<MyCartsCubit, MyCartsState>(
                    buildWhen: (previousState, currentState) =>
                        currentState is! ComputeTotalPriceState,
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.showAppHeader)
                            AppHeaderWidget(
                              height: setHeightValue(
                                portraitValue: 0.2,
                                landscapeValue: 0.2,
                              ),
                              showCartButton: false,
                            ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                              start: setWidthValue(
                                portraitValue: 0.03,
                                landscapeValue: 0.06,
                              ),
                              top: 15.0,
                              bottom: 15.0,
                            ),
                            child: Text(
                              appLocalization!.carts,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          BuildCondition(
                              condition: state is GetMyCartsDataErrorState,
                              builder: (_) => DefaultErrorWidget(
                                    error: (state as GetMyCartsDataErrorState)
                                        .error,
                                  ),
                              fallback: (context) {
                                return BuildCondition(
                                    condition:
                                        state is GetMyCartsDataLoadingState,
                                    builder: (_) =>
                                        Center(child: LoadingScreen()),
                                    fallback: (context) {
                                      return BuildCondition(
                                        condition:
                                            state is GetMyCartsDataEmptyState,
                                        builder: (_) => DefaultEmptyItemsText(
                                            itemsName: appLocalization!.carts),
                                        fallback: (context) {
                                          return ListView.separated(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 3.0,
                                              horizontal: setWidthValue(
                                                portraitValue: 0.03,
                                                landscapeValue: 0.06,
                                              ),
                                            ),
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) =>
                                                CartWidget(
                                              cartModel:
                                                  _myCartsCubit.myCarts[index],
                                              computeTotalPrices: () {
                                                _myCartsCubit
                                                    .computeTotalPrice();
                                              },
                                            ),
                                            itemCount:
                                                _myCartsCubit.myCarts.length,
                                            separatorBuilder:
                                                (BuildContext context,
                                                        int index) =>
                                                    const SizedBox(
                                              height: 10.0,
                                            ),
                                          );
                                        },
                                      );
                                    });
                              }),
                          const SizedBox(
                            height: 10.0,
                          ),
                          if (_myCartsCubit.myCarts.isNotEmpty)
                            BlocConsumer<CouponCubit, CouponState>(
                              listener: (context, couponState) {
                                // TODO: implement listener
                              },
                              builder: (context, couponState) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: setWidthValue(
                                            portraitValue: 0.03,
                                            landscapeValue: 0.06,
                                          ),
                                          vertical: setHeightValue(
                                            portraitValue: 0.02,
                                            landscapeValue: 0.03,
                                          )),
                                      child: Row(
                                        children: [
                                          Theme(
                                            child: Expanded(
                                              child: TextField(
                                                controller:
                                                    _couponTextController,
                                                textInputAction:
                                                    TextInputAction.send,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(5.0),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadiusDirectional
                                                            .only(
                                                      topStart:
                                                          Radius.circular(3.0),
                                                      bottomStart:
                                                          Radius.circular(3.0),
                                                    ).resolve(languageCode ==
                                                                'en'
                                                            ? TextDirection.ltr
                                                            : TextDirection
                                                                .rtl),
                                                  ),
                                                  alignLabelWithHint: true,
                                                  hintText: appLocalization!
                                                      .enterCode,
                                                ),
                                                onSubmitted: (value) {
                                                  onSubmitted();
                                                },
                                              ),
                                            ),
                                            data: Theme.of(context).copyWith(
                                              colorScheme: ThemeData()
                                                  .colorScheme
                                                  .copyWith(
                                                    primary: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: couponState
                                                      is CheckCouponLoadingState
                                                  ? Colors.grey
                                                  : Theme.of(context)
                                                      .primaryColor,
                                              borderRadius:
                                                  const BorderRadiusDirectional
                                                      .only(
                                                topEnd: Radius.circular(3.0),
                                                bottomEnd: Radius.circular(3.0),
                                              ),
                                            ),
                                            child: TextButton(
                                              onPressed: couponState
                                                      is CheckCouponLoadingState
                                                  ? null
                                                  : () {
                                                      onSubmitted();
                                                    },
                                              child: Text(
                                                appLocalization!.check,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: setWidthValue(
                                            portraitValue: 0.03,
                                            landscapeValue: 0.06,
                                          ),
                                          vertical: setHeightValue(
                                            portraitValue: 0.02,
                                            landscapeValue: 0.03,
                                          )),
                                      color: Colors.grey[300],
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BlocBuilder<MyCartsCubit,
                                              MyCartsState>(
                                            buildWhen: (previousState,
                                                    currentState) =>
                                                currentState
                                                    is ComputeTotalPriceState,
                                            builder: (context, state) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${_myCartsCubit.myCarts.length} ${appLocalization!.items}',
                                                    style: const TextStyle(
                                                      color: Colors.blueGrey,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${appLocalization?.shipping} : \$ ${_myCartsCubit.shippingPrice}',
                                                    style: const TextStyle(
                                                        fontSize: 14.0),
                                                  ),
                                                  Text(
                                                    '${appLocalization!.total} : \$ ${_myCartsCubit.totalPrice}',
                                                    style: TextStyle(
                                                      color: _couponCubit
                                                                  .couponModel ==
                                                              null
                                                          ? Colors.black
                                                          : Colors.grey,
                                                      fontSize: 20.0,
                                                      decoration: _couponCubit
                                                                  .couponModel ==
                                                              null
                                                          ? null
                                                          : TextDecoration
                                                              .lineThrough,
                                                    ),
                                                  ),
                                                  if (_couponCubit
                                                          .couponModel !=
                                                      null)
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '${appLocalization!.discount}: \$${_couponCubit.couponModel?.discountPrice ?? '0.0'}',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 20.0,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${appLocalization!.finalPrice}: \$${_couponCubit.couponModel?.finalPrice ?? '0.0'}',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 20.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                ],
                                              );
                                            },
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional.bottomEnd,
                                            child: DefaultButton(
                                              function: () {
                                                navigateTo(
                                                  context: context,
                                                  screen: ComparingPhoneScreen(
                                                    shippingPrice: _myCartsCubit
                                                        .shippingPrice,
                                                    couponCode:
                                                        _couponCubit.couponCode,
                                                  ),
                                                );
                                              },
                                              text: appLocalization!.compare,
                                              radius: 15.0,
                                              width: 120.0,
                                              backgroundColor:
                                                  const Color(0xFFce0900),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          const SizedBox(
                            height: 20.0,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            )
          : Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100.0,
                  width: double.infinity,
                ),
                Text(
                  appLocalization!.pleaseSelectDefaultAddress,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: defaultColor,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                DefaultButton(
                    function: () {
                      navigateTo(
                        context: context,
                        screen: AddressesPhoneScreen(),
                      );
                    },
                    text: appLocalization!.addresses,
                    width: setWidthValue(
                      portraitValue: 0.8,
                      landscapeValue: 0.7,
                    )),
              ],
            ),
    );
  }

  void onSubmitted() {
    if (_couponTextController.text.trim().isEmpty) {
      showErrorToast(
          error: HttpException(
        appLocalization!.pleaseEnterCode,
      ));
      return;
    }
    _couponCubit.checkCoupon(
      couponValue: _couponTextController.text.trim(),
      finalPrice: _myCartsCubit.totalPrice.toString(),
    );
  }
}
