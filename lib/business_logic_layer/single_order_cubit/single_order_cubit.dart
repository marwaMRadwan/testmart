import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/single_order_model.dart';
import 'package:martizoom/data_layer/repository/orders_repository.dart';
import 'package:meta/meta.dart';

part 'single_order_state.dart';

class SingleOrderCubit extends Cubit<SingleOrderState> {
  SingleOrderCubit() : super(SingleOrderInitial());

  static SingleOrderCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final OrdersRepository _ordersRepository = OrdersRepository();

  SingleOrderModel? singleOrderModel;
  final List<OrderProductModel> products = [];
  final List<Statusess> statusess = [];
  int isCanceled = 0;
  int lastDoneStatusIndex = 0;
  int totalPrice = 0;

  getSingOrder({
    required String orderId,
  }) {
    products.clear();
    statusess.clear();
    emit(GetSingleOrderDataLoadingState());
    _ordersRepository.getSingleOrder(orderId: orderId).then(
      (value) {
        final List<SingleOrderModel> orders = value;
        if (orders.isNotEmpty) {
          singleOrderModel = orders[0];
          products.addAll(orders[0].products ?? []);
          statusess.addAll(orders[0].statusess ?? []);
          totalPrice = orders[0].totalPrice ?? 0;
          if (statusess.length > 5) {
            statusess.removeRange(5, statusess.length);
          }
          lastDoneStatusIndex = statusess.length - 1;
          for (int i = 0; i < statusess.length; i++) {
            if (statusess[i].dateAdded == null) {
              if (i != 0) {
                lastDoneStatusIndex = i - 1;
              }
              break;
            }
          }
          isCanceled = orders[0].isCanceled ?? 0;
        }
        if (products.isEmpty) {
          emit(GetSingleOrderDataEmptyState());
        } else {
          emit(GetSingleOrderDataSuccessState());
        }
      },
    ).catchError((error) {
      debugPrint('$error');
      emit(GetSingleOrderDataErrorState(error: error));
    });
  }
}
