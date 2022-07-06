import 'dart:io';

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/business_logic_layer/comparing_cubit/comparing_cubit.dart';
import 'package:martizoom/business_logic_layer/process_order_cubit/process_order_cubit.dart';
import 'package:martizoom/business_logic_layer/radio_button_cubit/radio_button_cubit.dart';
import 'package:martizoom/data_layer/models/compare_model.dart';
import 'package:martizoom/presentation_layer/screens/loading/loading_screen.dart';
import 'package:martizoom/presentation_layer/screens/single_order/single_order_tablet_screen.dart';
import 'package:martizoom/shared/components/default_app_bar/default_tablet_app_bar.dart';
import 'package:martizoom/shared/components/default_button.dart';
import 'package:martizoom/shared/components/default_empty_items_text.dart';
import 'package:martizoom/shared/components/default_error_widget.dart';
import 'package:martizoom/shared/constants/constants.dart';

class ComparingTabletScreen extends StatefulWidget {
  final double shippingPrice;
  final String? couponCode;

  ComparingTabletScreen({
    Key? key,
    required this.shippingPrice,
    this.couponCode,
  }) : super(key: key);

  @override
  State<ComparingTabletScreen> createState() => _ComparingTabletScreenState();
}

class _ComparingTabletScreenState extends State<ComparingTabletScreen> {
  double get shippingPrice => widget.shippingPrice;

  String? get couponCode => widget.couponCode;

  String? marketId;

  final ProcessOrderCubit _processOrderCubit = ProcessOrderCubit();

  final ComparingCubit _comparingCubit = ComparingCubit();

  final _radioButtonCubit = RadioButtonCubit();

  double totalPrice = 0.0;

  @override
  void initState() {
    _comparingCubit.compareMarkets(couponCode: couponCode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _processOrderCubit,
        ),
        BlocProvider(
          create: (context) => _comparingCubit,
        ),
        BlocProvider(
          create: (context) => _radioButtonCubit,
        ),
      ],
      child: BlocConsumer<ProcessOrderCubit, ProcessOrderState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is ProcessOrderSuccessState) {
            navigateTo(
              context: context,
              screen: SingleOrderTabletScreen(
                orderId: _processOrderCubit.orderId.toString(),
                restartApp: true,
              ),
            );
          }
        },
        builder: (context, state) {
          return BlocConsumer<ComparingCubit, ComparingState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return Scaffold(
                appBar: DefaultTabletAppBar(
                  title: appLocalization!.compare,
                ),
                body: BuildCondition(
                    condition: state is CompareMarketsErrorState,
                    builder: (_) => DefaultErrorWidget(
                        error: (state as CompareMarketsErrorState).error),
                    fallback: (context) {
                      return BuildCondition(
                          condition: state is CompareMarketsLoadingState,
                          builder: (_) => LoadingScreen(),
                          fallback: (context) {
                            return BuildCondition(
                                condition: state is CompareMarketsEmptyState,
                                builder: (_) => DefaultEmptyItemsText(
                                      itemsName: appLocalization!.markets,
                                    ),
                                fallback: (context) {
                                  final List<CompareModel> comparedMarkets =
                                      ComparingCubit.get(context)
                                          .comparedMarkets;
                                  return SingleChildScrollView(
                                    child: BlocConsumer<RadioButtonCubit,
                                        RadioButtonState>(
                                      listener: (context, state) {
                                        // TODO: implement listener
                                        if (state
                                            is ChangeRadioButtonValueState) {
                                          marketId =
                                              _radioButtonCubit.buttonValue ??
                                                  '0';
                                          CompareModel market = comparedMarkets
                                              .firstWhere((market) =>
                                                  marketId == market.marketId);
                                          if (market.priceAfterDiscount !=
                                                  null &&
                                              market.priceAfterDiscount !=
                                                  '0.0') {
                                            totalPrice = double.tryParse(market
                                                    .priceAfterDiscount!) ??
                                                0.0;
                                          } else {
                                            totalPrice = double.tryParse(
                                                    market.totalCart ??
                                                        '0.0') ??
                                                0.0;
                                          }
                                        }
                                      },
                                      builder: (context, state) {
                                        return Column(
                                          children: [
                                            ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              primary: true,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: setWidthValue(
                                                  portraitValue: 0.03,
                                                  landscapeValue: 0.05,
                                                ),
                                              ),
                                              itemBuilder: (context, index) =>
                                                  Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: setWidthValue(
                                                    portraitValue: 0.01,
                                                    landscapeValue: 0.03,
                                                  ),
                                                  vertical: setHeightValue(
                                                    portraitValue: 0.01,
                                                    landscapeValue: 0.03,
                                                  ),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    _radioButtonCubit
                                                        .changeRadioButtonValue(
                                                            comparedMarkets[
                                                                        index]
                                                                    .marketId ??
                                                                '0');
                                                  },
                                                  child: Container(
                                                    height: 150.0,
                                                    width: double.infinity,
                                                    clipBehavior: Clip
                                                        .antiAliasWithSaveLayer,
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                                0xFFce0900)
                                                            .withAlpha(40),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    15.0)),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height:
                                                              setHeightValue(
                                                            portraitValue: 0.17,
                                                            landscapeValue:
                                                                0.32,
                                                          ),
                                                          width: setWidthValue(
                                                            portraitValue: 0.2,
                                                            landscapeValue: 0.2,
                                                          ),
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.grey,
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                comparedMarkets[
                                                                            index]
                                                                        .marketLogo ??
                                                                    '',
                                                              ),
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              horizontal:
                                                                  setWidthValue(
                                                                portraitValue:
                                                                    0.025,
                                                                landscapeValue:
                                                                    0.05,
                                                              ),
                                                              vertical:
                                                                  setHeightValue(
                                                                portraitValue:
                                                                    0.025,
                                                                landscapeValue:
                                                                    0.05,
                                                              ),
                                                            ),
                                                            child:
                                                                RadioListTile(
                                                              value: comparedMarkets[
                                                                          index]
                                                                      .marketId ??
                                                                  '0',
                                                              groupValue:
                                                                  marketId,
                                                              onChanged:
                                                                  (value) {
                                                                if (value !=
                                                                    null) {
                                                                  _radioButtonCubit
                                                                      .changeRadioButtonValue(
                                                                          value);
                                                                }
                                                              },
                                                              title: Text(
                                                                comparedMarkets[
                                                                            index]
                                                                        .marketName ??
                                                                    '',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      18.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                              subtitle: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    appLocalization!
                                                                        .totalPrice,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          16.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    '''${(comparedMarkets[index].priceAfterDiscount ?? '0.0') != '0.0' ? '${appLocalization!.before}: ' : ''}\$ ${comparedMarkets[index].totalCart ?? '0.0'}''',
                                                                    style:
                                                                        TextStyle(
                                                                      color: (comparedMarkets[index].priceAfterDiscount ?? '0.0') !=
                                                                              '0.0'
                                                                          ? Colors
                                                                              .grey
                                                                          : Colors
                                                                              .black,
                                                                      fontSize:
                                                                          16.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      decoration: (comparedMarkets[index].priceAfterDiscount ?? '0.0') !=
                                                                              '0.0'
                                                                          ? TextDecoration
                                                                              .lineThrough
                                                                          : null,
                                                                    ),
                                                                  ),
                                                                  if ((comparedMarkets[index]
                                                                              .priceAfterDiscount ??
                                                                          '0.0') !=
                                                                      '0.0')
                                                                    Text(
                                                                      '${appLocalization!.after}: \$ ${comparedMarkets[index].priceAfterDiscount ?? '0.0'}',
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            16.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                ],
                                                              ),
                                                              toggleable: true,
                                                              controlAffinity:
                                                                  ListTileControlAffinity
                                                                      .trailing,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              itemCount: comparedMarkets.length,
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  BlocBuilder<RadioButtonCubit,
                                                      RadioButtonState>(
                                                    builder: (context, state) {
                                                      return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            '${appLocalization?.shipping} : ${shippingPrice}',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14.0,
                                                            ),
                                                          ),
                                                          Text(
                                                            '${appLocalization!.total} : \$ ${totalPrice + shippingPrice}',
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 20.0,
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: setWidthValue(
                                                          portraitValue: 0.04,
                                                          landscapeValue: 0.1),
                                                      vertical: setWidthValue(
                                                        portraitValue: 0.02,
                                                        landscapeValue: 0.03,
                                                      ),
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .bottomEnd,
                                                      child: BuildCondition(
                                                          condition: state
                                                              is ProcessOrderLoadingState,
                                                          builder: (_) =>
                                                              const CircularProgressIndicator(),
                                                          fallback: (context) {
                                                            return DefaultButton(
                                                              function: () {
                                                                if (marketId !=
                                                                    null) {
                                                                  _processOrderCubit
                                                                      .processUserOrder(
                                                                    marketId:
                                                                        marketId!,
                                                                  );
                                                                } else {
                                                                  showErrorToast(
                                                                    error:
                                                                        HttpException(
                                                                      appLocalization!
                                                                          .pleaseSelectAMarket,
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                              text:
                                                                  appLocalization!
                                                                      .proceed,
                                                              radius: 15.0,
                                                              width:
                                                                  setWidthValue(
                                                                portraitValue:
                                                                    0.25,
                                                                landscapeValue:
                                                                    0.15,
                                                              ),
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xFFce0900),
                                                            );
                                                          }),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                });
                          });
                    }),
              );
            },
          );
        },
      ),
    );
  }
}
