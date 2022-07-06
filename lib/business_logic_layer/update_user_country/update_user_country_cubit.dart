import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/repository/user_repository.dart';
import 'package:martizoom/shared/constants/constants.dart';

part 'update_user_country_state.dart';

class UpdateUserCountryCubit extends Cubit<UpdateUserCountryState> {
  UpdateUserCountryCubit() : super(UpdateUserCountryInitial());

  static UpdateUserCountryCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final UserRepository _userRepository = UserRepository();

  updateUserCountry({required String countryId}) {
    emit(UpdateUserCountryLoadingState());
    _userRepository.updateUserCountry(countryId: countryId).then(
      (value) async {
        await chooseCountryId(id: countryId);
        showSuccessToast(successMessage: value);
        emit(UpdateUserCountrySuccessState());
      },
    ).catchError((error) {
      showErrorToast(error: error);
      debugPrint('$error');
      emit(UpdateUserCountryErrorState());
    });
  }
}
