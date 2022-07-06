import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/shared/components/app_icons/app_icons.dart';
import 'package:martizoom/shared/components/default_app_bar/default_phone_app_bar.dart';
import 'package:martizoom/shared/components/default_button.dart';
import 'package:martizoom/shared/components/default_text_form_field.dart';
import '../../../business_logic_layer/update_password_cubit/update_password_cubit.dart';
import '../../../shared/constants/constants.dart';

class UpdatePasswordPhoneScreen extends StatelessWidget {
  UpdatePasswordPhoneScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordTextEditingController =
      TextEditingController();
  final TextEditingController _newPasswordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultPhoneAppBar(
        title: appLocalization!.updatePassword,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: setHeightValue(
              portraitValue: 0.05,
              landscapeValue: 0.1,
            ),
            horizontal: setWidthValue(
              portraitValue: 0.072,
              landscapeValue: 0.15,
            ),
          ),
          child: Form(
            key: _formKey,
            child: BlocConsumer<UpdatePasswordCubit, UpdatePasswordState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state is UpdatePasswordSuccessState) {
                  Navigator.of(context).pop();
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(
                          40.0,
                        ),
                        border: Border.all(
                            width: 2.0, color: Theme.of(context).primaryColor),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                            ),
                            child: DefaultTextFormField(
                              controller: _currentPasswordTextEditingController,
                              type: TextInputType.text,
                              prefix: AppIcons.lock,
                              isPassword: true,
                              label: appLocalization!.currentPassword,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return appLocalization!
                                      .currentPasswordIsRequired;
                                }
                                if (value.isEmpty || value.contains(' ')) {
                                  return appLocalization!
                                      .currentPasswordIsNotValid;
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: DefaultTextFormField(
                              controller: _newPasswordTextEditingController,
                              type: TextInputType.text,
                              prefix: AppIcons.lock,
                              isPassword: true,
                              label: appLocalization!.newPassword,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return appLocalization!.newPasswordIsRequired;
                                }
                                if (value.isEmpty ||
                                    value.contains(' ') ||
                                    value ==
                                        _currentPasswordTextEditingController
                                            .text) {
                                  return appLocalization!.newPasswordIsNotValid;
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: BuildCondition(
                                condition: state is UpdatePasswordLoadingState,
                                builder: (_) =>
                                    const CircularProgressIndicator(),
                                fallback: (context) {
                                  return DefaultButton(
                                    function: () {
                                      _submit(context);
                                    },
                                    text: appLocalization!.update,
                                    radius: 15.0,
                                    backgroundColor: const Color(0xFFce0900),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _submit(context) {
    if (!_formKey.currentState!.validate()) return;
    UpdatePasswordCubit.get(context).updatePassword(
      currentPassword: _currentPasswordTextEditingController.text.trim(),
      newPassword: _newPasswordTextEditingController.text.trim(),
    );
  }
}
