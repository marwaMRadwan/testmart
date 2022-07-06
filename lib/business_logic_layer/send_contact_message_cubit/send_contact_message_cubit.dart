import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/contact_message_model.dart';
import 'package:martizoom/shared/constants/constants.dart';

import '../../data_layer/repository/general_repository.dart';

part 'send_contact_message_state.dart';

class SendContactMessageCubit extends Cubit<SendContactMessageState> {
  SendContactMessageCubit() : super(SendContactMessageInitial());

  static SendContactMessageCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final GeneralRepository _generalRepository = GeneralRepository();

  void sendMessage({required ContactMessageModel message}) {
    emit(SendMessageLoadingState());
    _generalRepository
        .sendContactMessage(
      message: message,
    )
        .then((value) {
      showSuccessToast(successMessage: value);
      emit(SendMessageSuccessState());
    }).catchError(
      (error) {
        debugPrint('$error');
        showErrorToast(error: error);
        emit(
          SendMessageErrorState(),
        );
      },
    );
  }
}
