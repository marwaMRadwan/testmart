part of 'coupon_cubit.dart';

@immutable
abstract class CouponState {}

class CouponInitial extends CouponState {}

class CheckCouponLoadingState extends CouponState {}

class CheckCouponSuccessState extends CouponState {}

class CheckCouponErrorState extends CouponState {}
