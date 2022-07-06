import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/address_model.dart';
import 'package:martizoom/data_layer/repository/user_repository.dart';
import 'package:martizoom/shared/constants/constants.dart';

part 'add_update_address_state.dart';

class AddUpdateAddressCubit extends Cubit<AddUpdateAddressState> {
  AddUpdateAddressCubit() : super(AddUpdateAddressInitial());

  static AddUpdateAddressCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final UserRepository _userRepository = UserRepository();

  addUserAddress({required AddressModel addressModel}) {
    emit(AddUpdateAddressLoadingState());
    _userRepository.addUserAddress(addressModel: addressModel).then(
      (value) {
        showSuccessToast(successMessage: value);
        emit(AddUpdateAddressSuccessState());
      },
    ).catchError((error) {
      showErrorToast(error: error);
      debugPrint('$error');
      emit(AddUpdateAddressErrorState());
    });
  }

  updateUserAddress({required AddressModel addressModel}) {
    emit(AddUpdateAddressLoadingState());
    _userRepository
        .updateUserAddress(
      addressModel: addressModel,
    )
        .then(
      (value) {
        showSuccessToast(successMessage: value);
        emit(AddUpdateAddressSuccessState());
      },
    ).catchError((error) {
      showErrorToast(error: error);
      debugPrint('$error');
      emit(AddUpdateAddressErrorState());
    });
  }
}
