part of 'send_contact_message_cubit.dart';

@immutable
abstract class SendContactMessageState {}

class SendContactMessageInitial extends SendContactMessageState {}

class SendMessageLoadingState extends SendContactMessageState {}

class SendMessageSuccessState extends SendContactMessageState {
  SendMessageSuccessState();
}

class SendMessageErrorState extends SendContactMessageState {

  SendMessageErrorState();
}
