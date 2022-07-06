part of 'add_update_address_cubit.dart';

@immutable
abstract class AddUpdateAddressState {}

class AddUpdateAddressInitial extends AddUpdateAddressState {}

class AddUpdateAddressLoadingState extends AddUpdateAddressState {}

class AddUpdateAddressSuccessState extends AddUpdateAddressState {}

class AddUpdateAddressErrorState extends AddUpdateAddressState {}
