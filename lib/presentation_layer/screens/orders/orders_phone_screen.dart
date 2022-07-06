import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/business_logic_layer/orders_cubit/orders_cubit.dart';
import 'package:martizoom/presentation_layer/screens/loading/loading_screen.dart';
import 'package:martizoom/presentation_layer/screens/single_order/single_order_phone_screen.dart';
import 'package:martizoom/presentation_layer/widgets/app_header/app_header_widget.dart';
import 'package:martizoom/shared/components/default_empty_items_text.dart';
import 'package:martizoom/shared/components/default_error_widget.dart';
import 'package:martizoom/shared/constants/constants.dart';

class OrdersPhoneScreen extends StatefulWidget {
  OrdersPhoneScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OrdersPhoneScreen> createState() => _OrdersPhoneScreenState();
}

class _OrdersPhoneScreenState extends State<OrdersPhoneScreen> {
  @override
  void initState() {
    // TODO: implement initState
    OrdersCubit.get(context).getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersCubit, OrdersState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final orders = OrdersCubit.get(context).orders;
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppHeaderWidget(
                  height: setHeightValue(
                    portraitValue: 0.2,
                    landscapeValue: 0.2,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: setWidthValue(
                      portraitValue: 0.03,
                      landscapeValue: 0.05,
                    ),
                    vertical: setHeightValue(
                      portraitValue: 0.03,
                      landscapeValue: 0.05,
                    ),
                  ),
                  child: Text(
                    appLocalization!.orders,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                BuildCondition(
                    condition: state is GetOrdersDataErrorState,
                    builder: (_) => DefaultErrorWidget(
                          error: (state as GetOrdersDataErrorState).error,
                        ),
                    fallback: (context) {
                      return BuildCondition(
                          condition: state is GetOrdersDataEmptyState,
                          builder: (_) => DefaultEmptyItemsText(
                              itemsName: appLocalization!.orders),
                          fallback: (context) {
                            return BuildCondition(
                                condition: state is GetOrdersDataLoadingState,
                                builder: (_) => LoadingScreen(),
                                fallback: (context) {
                                  return ListView.separated(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: setWidthValue(
                                        portraitValue: 0.03,
                                        landscapeValue: 0.05,
                                      ),
                                      vertical: setHeightValue(
                                        portraitValue: 0.03,
                                        landscapeValue: 0.05,
                                      ),
                                    ),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) => Container(
                                      width: double.infinity,
                                      height: setHeightValue(
                                        portraitValue: 0.16,
                                        landscapeValue: 0.3,
                                      ),
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFce0900)
                                              .withAlpha(40),
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      child: ListTile(
                                        onTap: () {
                                          navigateTo(
                                              context: context,
                                              screen: SingleOrderPhoneScreen(
                                                orderId:
                                                    orders[index].ordersId ??
                                                        '0',
                                              ));
                                        },
                                        title: Text(
                                          orders[index].customersName ?? '',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              appLocalization!.orderPrice,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              '\$ ${orders[index].totalPrice}',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              orders[index].ordersStatus ?? '',
                                              style: const TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // controlAffinity: ListTileControlAffinity.trailing,
                                        trailing: const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    itemCount: orders.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const SizedBox(
                                      height: 10.0,
                                    ),
                                  );
                                });
                          });
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
