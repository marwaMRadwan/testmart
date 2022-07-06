import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:martizoom/business_logic_layer/contact_us_cubit/contact_us_cubit.dart';
import 'package:martizoom/business_logic_layer/send_contact_message_cubit/send_contact_message_cubit.dart';
import 'package:martizoom/data_layer/models/contact_message_model.dart';
import 'package:martizoom/data_layer/models/contact_model.dart';
import 'package:martizoom/presentation_layer/screens/loading/loading_screen.dart';
import 'package:martizoom/shared/components/default_app_bar/default_phone_app_bar.dart';
import 'package:martizoom/shared/components/default_button.dart';
import 'package:martizoom/shared/components/default_error_widget.dart';
import '../../../shared/components/default_text_form_field.dart';
import '../../../shared/constants/constants.dart';

class ContactUsTabletScreen extends StatefulWidget {
  ContactUsTabletScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsTabletScreen> createState() => _ContactUsTabletScreenState();
}

class _ContactUsTabletScreenState extends State<ContactUsTabletScreen> {
  late final ContactUsCubit _contactUsCubit;
  final SendContactMessageCubit _sendContactMessageCubit =
      SendContactMessageCubit();

  @override
  void initState() {
    _contactUsCubit = ContactUsCubit.get(context);
    _contactUsCubit.getContacts();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _phoneTextEditingController =
      TextEditingController();

  final TextEditingController _messageTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _sendContactMessageCubit,
      child: Scaffold(
        appBar: DefaultPhoneAppBar(
          title: appLocalization!.contactUs,
        ),
        body: BlocConsumer<ContactUsCubit, ContactUsState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(
                15.0,
              ),
              child: BuildCondition(
                  condition: state is GetContactsErrorState,
                  builder: (_) => DefaultErrorWidget(
                        error: (state as GetContactsErrorState).error,
                      ),
                  fallback: (context) {
                    return BuildCondition(
                        condition: state is GetContactsLoadingState,
                        builder: (_) => LoadingScreen(),
                        fallback: (context) {
                          final List<ContactModel> contacts =
                              _contactUsCubit.contacts;
                          return Column(
                            children: [
                              Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 10.0,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Theme.of(context).primaryColor,
                                          width: 2.0,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(
                                            15.0,
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (!isLoggedIn)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                              ),
                                              child: DefaultTextFormField(
                                                controller:
                                                    _nameTextEditingController,
                                                type: TextInputType.text,
                                                label: appLocalization!.name,
                                                validate: (String value) {
                                                  if (!isLoggedIn &&
                                                      value.isEmpty) {
                                                    return appLocalization!.nameIsRequired;
                                                  }
                                                },
                                              ),
                                            ),
                                          if (!isLoggedIn)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                              ),
                                              child: DefaultTextFormField(
                                                controller:
                                                    _emailTextEditingController,
                                                type:
                                                    TextInputType.emailAddress,
                                                label: appLocalization!.email,
                                                validate: (String value) {
                                                  if (isWhiteSpacesWord(
                                                          value) ||
                                                      (value.isNotEmpty &&
                                                          !value
                                                              .contains('@'))) {
                                                    return appLocalization!
                                                        .emailIsNotValid;
                                                  }
                                                },
                                              ),
                                            ),
                                          if (!isLoggedIn)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                              ),
                                              child: DefaultTextFormField(
                                                controller:
                                                    _phoneTextEditingController,
                                                type: TextInputType.phone,
                                                label: appLocalization!.phone,
                                              ),
                                            ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: DefaultTextFormField(
                                              controller:
                                                  _messageTextEditingController,
                                              type: TextInputType.text,
                                              label: appLocalization!.message,
                                              minLines: 5,
                                              maxLines: null,
                                              validate: (String value) {
                                                if (value.isEmpty) {
                                                  return appLocalization!.messageIsRequired;
                                                }
                                              },
                                            ),
                                          ),
                                          BlocConsumer<SendContactMessageCubit,
                                              SendContactMessageState>(
                                            listener: (context, state) {
                                              // TODO: implement listener
                                            },
                                            builder: (context, state) {
                                              return Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: state
                                                        is SendMessageLoadingState
                                                    ? const CircularProgressIndicator()
                                                    : DefaultButton(
                                                        function: () {
                                                          _submit(context);
                                                        },
                                                        text: appLocalization!.send,
                                                        radius: 15.0,
                                                        backgroundColor:
                                                            const Color(
                                                                0xFFce0900),
                                                      ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Builder(builder: (context) {
                                if (_contactUsCubit.phoneContact.id == '-1') {
                                  return Container();
                                }

                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      '${appLocalization!.phone} : ${_contactUsCubit.phoneContact.value}',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Builder(builder: (context) {
                                if (_contactUsCubit.whatsContact.id == '-1' ||
                                    _contactUsCubit.whatsContact.value ==
                                        null ||
                                    _contactUsCubit
                                        .whatsContact.value!.isEmpty) {
                                  return Container();
                                }

                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/WhatsAppIcon.svg',
                                        width: 30.0,
                                        height: 30.0,
                                        semanticsLabel: 'whats Logo'),
                                    const SizedBox(width: 10.0,),
                                    Text(
                                      '${_contactUsCubit.whatsContact.value}',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Wrap(
                                  children: contacts
                                      .map((e) => Container(
                                            margin: const EdgeInsets.all(15.0),
                                            child: DefaultButton(
                                                width: 140.0,
                                                function: () {
                                                  _contactUsCubit
                                                      .launchURL(
                                                          url: (e.name ?? ' ')
                                                                  .toLowerCase()
                                                                  .contains(
                                                                      'mail')
                                                              ? 'mailto:' +
                                                                  (e.value ??
                                                                      ' ')
                                                              : e.value ?? ' ');
                                                },
                                                text: e.name ?? ' '),
                                          ))
                                      .toList()),
                            ],
                          );
                        });
                  }),
            );
          },
        ),
      ),
    );
  }

  void _submit(context) {
    if (!_formKey.currentState!.validate()) return;
    _sendContactMessageCubit.sendMessage(
      message: ContactMessageModel(
        name: _nameTextEditingController.text.trim(),
        email: _emailTextEditingController.text.trim(),
        phone: _phoneTextEditingController.text.trim(),
        message: _messageTextEditingController.text.trim(),
      ),
    );
  }
}
