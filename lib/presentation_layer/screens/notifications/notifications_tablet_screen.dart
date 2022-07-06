import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/business_logic_layer/backend_notifications_cubit/backend_notifications_cubit.dart';
import 'package:martizoom/data_layer/models/backend_notification_model.dart';
import 'package:martizoom/presentation_layer/screens/category/category_tablet_screen.dart';
import 'package:martizoom/presentation_layer/screens/loading/loading_screen.dart';
import 'package:martizoom/shared/components/default_app_bar/default_tablet_app_bar.dart';
import 'package:martizoom/shared/components/default_empty_items_text.dart';
import 'package:martizoom/shared/components/default_error_widget.dart';
import 'package:martizoom/shared/constants/constants.dart';

import '../single_order/single_order_tablet_screen.dart';

class NotificationsTabletScreen extends StatefulWidget {
  const NotificationsTabletScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsTabletScreen> createState() =>
      _NotificationsTabletScreenState();
}

class _NotificationsTabletScreenState extends State<NotificationsTabletScreen> {
  late final BackendNotificationsCubit _backendNotificationsCubit;

  @override
  void initState() {
    // TODO: implement initState
    _backendNotificationsCubit = BackendNotificationsCubit.get(context);
    _backendNotificationsCubit.getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultTabletAppBar(
        title: appLocalization!.notifications,
      ),
      body: BlocConsumer<BackendNotificationsCubit, BackendNotificationsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return BuildCondition(
              condition: state is GetBackendNotificationsErrorState,
              builder: (_) => DefaultErrorWidget(
                  error: (state as GetBackendNotificationsErrorState).error),
              fallback: (context) {
                return BuildCondition(
                    condition: state is GetBackendNotificationsEmptyState,
                    builder: (_) =>
                        DefaultEmptyItemsText(itemsName: 'notifications'),
                    fallback: (context) {
                      return BuildCondition(
                          condition:
                              state is GetBackendNotificationsLoadingState,
                          builder: (_) => LoadingScreen(),
                          fallback: (context) {
                            final List<BackendNotificationModel>
                                _notifications =
                                _backendNotificationsCubit.notifications;
                            return ListView.builder(
                              padding: EdgeInsets.symmetric(
                                  horizontal: setWidthValue(
                                    portraitValue: 0.02,
                                    landscapeValue: 0.05,
                                  ),
                                  vertical: setHeightValue(
                                    portraitValue: 0.015,
                                    landscapeValue: 0.03,
                                  )),
                              itemCount: _notifications.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    if (_notifications[index].flag == '1') {
                                      navigateTo(
                                          context: context,
                                          screen: SingleOrderTabletScreen(
                                              orderId: _notifications[index]
                                                      .orderId ??
                                                  '0'));
                                    } else {
                                      navigateTo(
                                        context: context,
                                        screen: CategoryTabletScreen(
                                          marketId:
                                              _notifications[index].marketId ??
                                                  '0',
                                          categoryId: _notifications[index]
                                                  .categoryId ??
                                              '0',
                                          categoryName: _notifications[index]
                                                  .categoriesName ??
                                              ' ',
                                          sceneId:
                                              _notifications[index].theme ??
                                                  '0',
                                        ),
                                      );
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${_notifications[index].title}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                                Text(
                                                  '${_notifications[index].message}',
                                                  style: const TextStyle(
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            if (_notifications[index].isSeen !=
                                                '1')
                                              const Icon(
                                                Icons.star,
                                                color: Colors.red,
                                              ),
                                          ],
                                        ),
                                        const Divider(thickness: 1.2),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          });
                    });
              });
        },
      ),
    );
  }
}
