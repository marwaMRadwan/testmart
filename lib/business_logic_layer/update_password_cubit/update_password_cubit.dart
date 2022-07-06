import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data_layer/repository/user_repository.dart';
import '../../shared/constants/constants.dart';

part 'update_password_state.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  UpdatePasswordCubit() : super(UpdatePasswordInitial());

  static UpdatePasswordCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final UserRepository _userRepository = UserRepository();

  updatePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    emit(UpdatePasswordLoadingState());
    _userRepository
        .updateUserPassword(
            currentPassword: currentPassword, newPassword: newPassword)
        .then(
      (value) {
        showSuccessToast(successMessage: value);
        emit(UpdatePasswordSuccessState());
      },
    ).catchError((error) {
      showErrorToast(error: error);
      debugPrint('$error');
      emit(UpdatePasswordErrorState());
    });
  }
}
