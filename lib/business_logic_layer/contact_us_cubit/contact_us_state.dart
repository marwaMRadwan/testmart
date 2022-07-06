part of 'contact_us_cubit.dart';

@immutable
abstract class ContactUsState {}

class ContactUsInitial extends ContactUsState {}

class GetContactsLoadingState extends ContactUsState {}

class GetContactsSuccessState extends ContactUsState {}

class GetContactsErrorState extends ContactUsState {
  final error;

  GetContactsErrorState({required this.error});
}
