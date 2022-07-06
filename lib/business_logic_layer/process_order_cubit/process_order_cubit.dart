import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/repository/orders_repository.dart';
import 'package:martizoom/shared/constants/constants.dart';

part 'process_order_state.dart';

class ProcessOrderCubit extends Cubit<ProcessOrderState> {
  ProcessOrderCubit() : super(ProcessOrderInitial());

  static ProcessOrderCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final OrdersRepository _ordersRepository = OrdersRepository();
  int orderId = 0;
  processUserOrder({required String marketId}) {
    emit(ProcessOrderLoadingState());
    _ordersRepository.processUserOrder(marketId: marketId).then(
      (value) async {
        orderId = value['order_id'];
        emit(ProcessOrderSuccessState());
      },
    ).catchError((error) {
      showErrorToast(error: error);
      debugPrint('$error');
      emit(ProcessOrderErrorState());
    });
  }
}
