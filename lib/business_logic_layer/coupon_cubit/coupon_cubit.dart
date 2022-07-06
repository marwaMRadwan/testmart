import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/coupons_response_model.dart';
import 'package:martizoom/data_layer/repository/coupons_repository.dart';
import 'package:martizoom/shared/constants/constants.dart';

part 'coupon_state.dart';

class CouponCubit extends Cubit<CouponState> {
  CouponCubit() : super(CouponInitial());

  static CouponCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final CouponsRepository _couponsRepository = CouponsRepository();
  CouponsResponseModel? couponModel;
  String? couponCode;

  checkCoupon({required String couponValue, required String finalPrice}) {
    couponCode = null;
    emit(CheckCouponLoadingState());
    _couponsRepository
        .checkCoupon(
      couponValue: couponValue,
      finalPrice: finalPrice,
    )
        .then((value) {
      couponModel = value;
      couponCode = couponValue;
      showSuccessToast(successMessage: appLocalization!.done);
      emit(CheckCouponSuccessState());
    }).catchError((error) {
      debugPrint('$error');
      couponModel = null;
      couponCode = null;
      showErrorToast(error: error);
      emit(CheckCouponErrorState());
    });
  }
}
