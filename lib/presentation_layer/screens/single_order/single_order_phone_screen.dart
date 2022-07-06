import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/business_logic_layer/single_order_cubit/single_order_cubit.dart';
import 'package:martizoom/presentation_layer/screens/loading/loading_screen.dart';
import 'package:martizoom/presentation_layer/widgets/order_product/order_product_widget.dart';
import 'package:martizoom/shared/components/default_app_bar/default_phone_app_bar.dart';
import 'package:martizoom/shared/components/default_empty_items_text.dart';
import 'package:martizoom/shared/components/default_error_widget.dart';
import 'package:martizoom/shared/constants/constants.dart';
import 'package:timelines/timelines.dart';

import '../../../main.dart';

class SingleOrderPhoneScreen extends StatefulWidget {
  final String orderId;
  final bool restartApp;

  SingleOrderPhoneScreen({
    Key? key,
    required this.orderId,
    this.restartApp = false,
  }) : super(key: key);

  @override
  State<SingleOrderPhoneScreen> createState() => _SingleOrderPhoneScreenState();
}

class _SingleOrderPhoneScreenState extends State<SingleOrderPhoneScreen> {
  String get orderId => widget.orderId;

  bool get restartApp => widget.restartApp;

  late final SingleOrderCubit _singleOrderCubit;

  @override
  void initState() {
    // TODO: implement initState
    _singleOrderCubit = SingleOrderCubit.get(context);
    _singleOrderCubit.getSingOrder(orderId: orderId);
    super.initState();
  }

  late var _isLandscape;

  @override
  Widget build(BuildContext context) {
    _isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return WillPopScope(
      onWillPop: () async {
        if (restartApp) MyApp.restartApp(context);

        return Future.value(true);
      },
      child: Scaffold(
        appBar: DefaultPhoneAppBar(
          title: appLocalization!.orderDetails,
          backButtonPressed: () {
            if (restartApp) {
              MyApp.restartApp(context);
            } else {
              Navigator.pop(context);
            }
          },
        ),
        body: SingleChildScrollView(
          child: BlocListener<SingleOrderCubit, SingleOrderState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            child: BlocBuilder<SingleOrderCubit, SingleOrderState>(
              builder: (context, state) {
                return BuildCondition(
                  condition: state is GetSingleOrderDataErrorState,
                  builder: (_) => DefaultErrorWidget(
                    error: (state as GetSingleOrderDataErrorState).error,
                  ),
                  fallback: (context) {
                    return BuildCondition(
                      condition: state is GetSingleOrderDataLoadingState,
                      builder: (_) => LoadingScreen(),
                      fallback: (context) {
                        return BuildCondition(
                          condition: state is GetSingleOrderDataEmptyState,
                          builder: (_) => DefaultEmptyItemsText(
                            itemsName: appLocalization!.products,
                          ),
                          fallback: (context) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _singleOrderCubit.isCanceled == 1
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.work_off_sharp,
                                              color: Colors.red,
                                              size: 24.0,
                                            ),
                                            Text(
                                              appLocalization!.orderIsCanceled,
                                              style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : _singleOrderCubit.statusess.isNotEmpty
                                        ? SizedBox(
                                            height: 100.0,
                                            width: double.infinity,
                                            child: Timeline.tileBuilder(
                                              theme: TimelineThemeData(
                                                direction: Axis.horizontal,
                                                connectorTheme:
                                                    const ConnectorThemeData(
                                                  space: 30.0,
                                                  thickness: 5.0,
                                                ),
                                              ),
                                              builder:
                                                  TimelineTileBuilder.connected(
                                                connectionDirection:
                                                    ConnectionDirection.before,
                                                itemExtentBuilder: (_, __) =>
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    _singleOrderCubit
                                                        .statusess.length,
                                                contentsBuilder:
                                                    (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 15.0,
                                                    ),
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        _singleOrderCubit
                                                                .statusess[
                                                                    index]
                                                                .status ??
                                                            ' ',
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                indicatorBuilder: (_, index) {
                                                  var color;
                                                  var child = const Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                    size: 15.0,
                                                  );
                                                  if (index <=
                                                      _singleOrderCubit
                                                          .lastDoneStatusIndex) {
                                                    color = Theme.of(context)
                                                        .primaryColor;
                                                  } else {
                                                    color = Colors.grey;
                                                  }

                                                  return Stack(
                                                    children: [
                                                      DotIndicator(
                                                        size: 30.0,
                                                        color: color,
                                                        child: child,
                                                      ),
                                                    ],
                                                  );
                                                },
                                                connectorBuilder:
                                                    (_, index, type) {
                                                  if (index <=
                                                      _singleOrderCubit
                                                          .lastDoneStatusIndex) {
                                                    return DecoratedLineConnector(
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                    );
                                                  } else {
                                                    return const SolidLineConnector(
                                                      color: Colors.grey,
                                                    );
                                                  }
                                                },
                                                itemCount: _singleOrderCubit
                                                    .statusess.length,
                                              ),
                                            ),
                                          )
                                        : Container(),
                                Padding(
                                  padding: EdgeInsets.all(
                                      _isLandscape ? 35.0 : 15.0),
                                  child: Text(
                                    appLocalization!.products,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                                ListView.separated(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5.0,
                                    horizontal: _isLandscape ? 35.0 : 15.0,
                                  ),
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) =>
                                      OrderProductWidget(
                                    productModel:
                                        _singleOrderCubit.products[index],
                                  ),
                                  itemCount: _singleOrderCubit.products.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const SizedBox(
                                    height: 10.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 50.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Text(
                                    '${appLocalization!.shippingPrice}: ${_singleOrderCubit.singleOrderModel?.shippingPrice ?? 0}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Text(
                                    '${appLocalization!.totalPrice}: ${_singleOrderCubit.totalPrice}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
