part of 'addresses_cubit.dart';

@immutable
abstract class AddressesState {}

class AddressesInitial extends AddressesState {}

class GetAddressesDataLoadingState extends AddressesState {}

class GetAddressesDataSuccessState extends AddressesState {}

class GetAddressesDataEmptyState extends AddressesState {}

class GetAddressesDataErrorState extends AddressesState {
  final error;

  GetAddressesDataErrorState({this.error});
}

class DeleteAddressLoadingState extends AddressesState {}

class DeleteAddressSuccessState extends AddressesState {}

class DeleteAddressErrorState extends AddressesState {}

class SetDefaultAddressLoadingState extends AddressesState {}

class SetDefaultAddressSuccessState extends AddressesState {}

class SetDefaultAddressErrorState extends AddressesState {}
