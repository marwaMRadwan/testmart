import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/update_user_model.dart';
import 'package:martizoom/data_layer/repository/user_repository.dart';
import 'package:martizoom/shared/constants/constants.dart';

part 'update_user_profile_state.dart';

class UpdateUserProfileCubit extends Cubit<UpdateUserProfileState> {
  UpdateUserProfileCubit() : super(UpdateUserProfileInitial());

  static UpdateUserProfileCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final UserRepository _userRepository = UserRepository();

  updateUserProfile({required UpdateUserModel updateUserModel}) {
    emit(UpdateUserProfileLoadingState());
    _userRepository
        .updateUserProfile(
      updateUserModel: updateUserModel,
    )
        .then(
      (value) {
        showSuccessToast(successMessage: value);
        emit(UpdateUserProfileSuccessState());
      },
    ).catchError((error) {
      showErrorToast(error: error);
      debugPrint('$error');
      emit(UpdateUserProfileErrorState());
    });
  }
}
