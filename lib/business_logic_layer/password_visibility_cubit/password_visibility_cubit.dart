import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'password_visibility_state.dart';

class PasswordVisibilityCubit extends Cubit<PasswordVisibilityState> {
  PasswordVisibilityCubit() : super(PasswordVisibilityInitial());
  static PasswordVisibilityCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  bool isPassword = true;
  IconData visibleIcon = Icons.visibility_outlined;

  changePasswordVisibility() {
    isPassword = !isPassword;
    visibleIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }
}
