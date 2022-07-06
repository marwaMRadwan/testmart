import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/order_model.dart';
import 'package:martizoom/data_layer/repository/orders_repository.dart';
import 'package:meta/meta.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  static OrdersCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final OrdersRepository _ordersRepository = OrdersRepository();
  final List<OrderModel> orders = [];

  getOrders() {
    orders.clear();
    emit(GetOrdersDataLoadingState());
    _ordersRepository.getOrders().then(
      (value) {
        orders.addAll(value);
        if (orders.isEmpty) {
          emit(GetOrdersDataEmptyState());
        } else {
          emit(GetOrdersDataSuccessState());
        }
      },
    ).catchError((error) {
      debugPrint('$error');
      emit(GetOrdersDataErrorState(error: error));
    });
  }
}
