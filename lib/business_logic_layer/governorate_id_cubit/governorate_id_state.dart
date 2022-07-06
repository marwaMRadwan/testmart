part of 'governorate_id_cubit.dart';

@immutable
abstract class GovernorateIdState {}

class GovernorateIdInitial extends GovernorateIdState {}

class GetGovernorateIdLoadingState extends GovernorateIdState {}

class GetGovernorateIdSuccessState extends GovernorateIdState {}

class GetGovernorateIdErrorState extends GovernorateIdState {
  GetGovernorateIdErrorState();
}
