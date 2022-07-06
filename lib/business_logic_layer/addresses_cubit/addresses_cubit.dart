import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/address_model.dart';
import 'package:martizoom/data_layer/repository/user_repository.dart';
import 'package:martizoom/shared/constants/constants.dart';

part 'addresses_state.dart';

class AddressesCubit extends Cubit<AddressesState> {
  AddressesCubit() : super(AddressesInitial());

  static AddressesCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final UserRepository _userRepository = UserRepository();
  final List<AddressModel> userAddresses = [];

  getUserAddresses() {
    userAddresses.clear();
    emit(GetAddressesDataLoadingState());
    _userRepository.getUserAddresses().then((value) {
      userAddresses.addAll(value);
      if (userAddresses.isEmpty) {
        emit(GetAddressesDataEmptyState());
      } else {
        emit(GetAddressesDataSuccessState());
      }
    }).catchError((error) {
      debugPrint('$error');
      emit(GetAddressesDataErrorState(error: error));
    });
  }

  deleteUserAddress({required String addressId}) {
    showLoadingToast();
    emit(DeleteAddressLoadingState());
    _userRepository.deleteUserAddress(addressId: addressId).then((value) {
      userAddresses.removeWhere((element) => element.id == addressId);

      /// After deleting the address check there
      /// is another address or not, where in case
      /// no addresses i emit the empty state
      if (userAddresses.isEmpty) {
        emit(GetAddressesDataEmptyState());
      } else {
        emit(DeleteAddressSuccessState());
      }

      showSuccessToast(successMessage: appLocalization!.addressIsSuccessfullyDeleted);
    }).catchError((error) {
      debugPrint('$error');
      showErrorToast(error: error);
      emit(DeleteAddressErrorState());
    });
  }

  setDefaultAddress({required String addressId}) {
    showLoadingToast();
    emit(SetDefaultAddressLoadingState());
    _userRepository.setAddressAsDefault(addressId: addressId).then((value) {
      for (AddressModel address in userAddresses) {
        if (address.id == addressId) {
          address.isDefault = '1';
        } else {
          address.isDefault = '0';
        }
      }
      emit(SetDefaultAddressSuccessState());
    }).catchError((error) {
      debugPrint('$error');
      showErrorToast(error: error);
      emit(SetDefaultAddressErrorState());
    });
  }
}
