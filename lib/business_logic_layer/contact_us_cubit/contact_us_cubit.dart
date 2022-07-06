import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/contact_model.dart';
import 'package:martizoom/shared/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data_layer/repository/general_repository.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(ContactUsInitial());

  static ContactUsCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final GeneralRepository _generalRepository = GeneralRepository();
  final List<ContactModel> contacts = [];
  ContactModel phoneContact = ContactModel(id: '-1');
  ContactModel whatsContact = ContactModel(id: '-1');

  getContacts() {
    contacts.clear();
    emit(GetContactsLoadingState());
    _generalRepository.getContacts().then(
      (value) {
        contacts.addAll(value);
        phoneContact = contacts.firstWhere(
          (contact) => contact.id == '12',
          orElse: () => ContactModel(id: '-1'),
        );
        contacts.remove(phoneContact);
        whatsContact = contacts.firstWhere(
          (contact) => contact.id == '152',
          orElse: () => ContactModel(id: '-1'),
        );
        contacts.remove(whatsContact);
        emit(GetContactsSuccessState());
      },
    ).catchError((error) {
      debugPrint('$error');
      emit(GetContactsErrorState(error: error));
    });
  }

  launchURL({required String url}) async {
    final uri = Uri.parse(url);
    launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    ).catchError((error) {
      showErrorToast(error: error);
      debugPrint('$error');
    });
  }
}
