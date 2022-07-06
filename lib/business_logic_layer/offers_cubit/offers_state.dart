part of 'offers_cubit.dart';

@immutable
abstract class OffersState {}

class OffersInitial extends OffersState {}

class GetOffersDataLoadingState extends OffersState {}

class GetOffersDataSuccessState extends OffersState {}

class GetOffersDataEmptyState extends OffersState {}

class GetOffersDataErrorState extends OffersState {
  final error;

  GetOffersDataErrorState({required this.error});
}
