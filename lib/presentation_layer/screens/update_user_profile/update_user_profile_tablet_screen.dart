import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/business_logic_layer/date_picker_cubit/date_picker_cubit.dart';
import 'package:martizoom/business_logic_layer/radio_button_cubit/radio_button_cubit.dart';
import 'package:martizoom/business_logic_layer/update_user_profile_cubit/update_user_profile_cubit.dart';
import 'package:martizoom/business_logic_layer/user_data_cubit/user_data_cubit.dart';
import 'package:martizoom/data_layer/models/update_user_model.dart';
import 'package:martizoom/data_layer/models/user_model.dart';
import 'package:martizoom/shared/components/default_app_bar/default_tablet_app_bar.dart';
import 'package:martizoom/shared/components/default_button.dart';
import 'package:martizoom/shared/components/default_text_form_field.dart';
import 'package:martizoom/shared/constants/constants.dart';

class UpdateUserProfileTabletScreen extends StatefulWidget {
  UpdateUserProfileTabletScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateUserProfileTabletScreen> createState() =>
      _UpdateUserProfileTabletScreenState();
}

class _UpdateUserProfileTabletScreenState
    extends State<UpdateUserProfileTabletScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameTextEditingController =
      TextEditingController();

  final TextEditingController _lastNameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();

  final TextEditingController _dobTextEditingController =
      TextEditingController();

  final TextEditingController _phoneTextEditingController =
      TextEditingController();

  final UpdateUserProfileCubit _updateUserProfileCubit =
      UpdateUserProfileCubit();
  final RadioButtonCubit _genderRadioButtonCubit = RadioButtonCubit();
  final DatePickerCubit _datePickerCubit = DatePickerCubit();
  late final UserModel appUser;

  @override
  void initState() {
    appUser = UserDataCubit.get(context).appUser!;
    _genderRadioButtonCubit.buttonValue =
        appUser.gender?.toLowerCase() ?? 'male';
    if (appUser.dob != null) {
      _dobTextEditingController.text = appUser.dob!;
      _datePickerCubit.selectedDate = getParsedDateTime(appUser.dob);
    } else {
      _dobTextEditingController.text = convertDateTimeToString(
        DateTime.now().subtract(
          const Duration(
            days: 30,
          ),
        ),
      );
    }
    _firstNameTextEditingController.text = appUser.firstName ?? '';
    _lastNameTextEditingController.text = appUser.lastName ?? '';
    _emailTextEditingController.text = appUser.email ?? '';
    _phoneTextEditingController.text = appUser.phone ?? '';
    _genderRadioButtonCubit.buttonValue = appUser.gender;

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _firstNameTextEditingController.dispose();
    _lastNameTextEditingController.dispose();
    _dobTextEditingController.dispose();
    _phoneTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _updateUserProfileCubit,
      child: BlocConsumer<UpdateUserProfileCubit, UpdateUserProfileState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is UpdateUserProfileSuccessState) {
            UserDataCubit.get(context).getUserData();
          }
        },
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async => state is! UpdateUserProfileLoadingState,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: DefaultTabletAppBar(
                title: appLocalization!.editProfile,
                backButtonPressed:
                    state is! UpdateUserProfileLoadingState ? null : () {},
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: setWidthValue(
                      portraitValue: 0.06,
                      landscapeValue: 0.08,
                    ),
                    vertical: 20.0,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: setHeightValue(
                            portraitValue: 0.1,
                            landscapeValue: 0.1,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 10.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(
                              40.0,
                            ),
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 2.0,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 20.0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: DefaultTextFormField(
                                  controller: _firstNameTextEditingController,
                                  type: TextInputType.text,
                                  label: appLocalization!.firstName,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return appLocalization!
                                          .firstNameIsRequired;
                                    }
                                    if (isWhiteSpacesWord(value)) {
                                      return appLocalization!
                                          .firstNameIsNotValid;
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: DefaultTextFormField(
                                  controller: _lastNameTextEditingController,
                                  type: TextInputType.text,
                                  label: appLocalization!.lastName,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return appLocalization!
                                          .lastNameIsRequired;
                                    }
                                    if (isWhiteSpacesWord(value)) {
                                      return appLocalization!
                                          .lastNameIsNotValid;
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: DefaultTextFormField(
                                  controller: _emailTextEditingController,
                                  type: TextInputType.emailAddress,
                                  label: appLocalization!.email,
                                  validate: (String value) {
                                    if (value.isNotEmpty) if (value.length >
                                            1 &&
                                        (!value.contains('@') ||
                                            value.contains(' '))) {
                                      return appLocalization!.emailIsNotValid;
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: BlocProvider(
                                  create: (context) => _datePickerCubit,
                                  child: BlocConsumer<DatePickerCubit,
                                      DatePickerState>(
                                    listener: (context, state) {
                                      // TODO: implement listener
                                      _dobTextEditingController.text =
                                          convertDateTimeToString(
                                        _datePickerCubit.selectedDate,
                                      );
                                    },
                                    builder: (context, state) {
                                      return DefaultTextFormField(
                                        controller: _dobTextEditingController,
                                        type: TextInputType.text,
                                        readOnly: true,
                                        onTap: () {
                                          _datePickerCubit.changeDate(
                                            context: context,
                                            firstDate: DateTime(
                                              1800,
                                            ),
                                            lastDate: DateTime.now(),
                                          );
                                        },
                                        label: appLocalization!.dateOfBirth,
                                        suffix: Icons.date_range,
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return appLocalization!
                                                .dateOfBirthIsRequired;
                                          }
                                          if (isWhiteSpacesWord(value)) {
                                            return appLocalization!
                                                .dateOfBirthIsNotValid;
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              BlocProvider(
                                create: (context) => _genderRadioButtonCubit,
                                child: BlocBuilder<RadioButtonCubit,
                                    RadioButtonState>(
                                  builder: (context, state) {
                                    return Row(
                                      children: [
                                        Text('${appLocalization!.gender}: '),
                                        Expanded(
                                          child: RadioListTile<String>(
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                appLocalization!.male,
                                                style:
                                                    const TextStyle(fontSize: 14.0),
                                              ),
                                            ),
                                            isThreeLine: false,
                                            value: 'male',
                                            groupValue: _genderRadioButtonCubit
                                                .buttonValue,
                                            onChanged: (value) {
                                              _genderRadioButtonCubit
                                                  .changeRadioButtonValue(
                                                'male',
                                              );
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: RadioListTile<String>(
                                            title: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                appLocalization!.female,
                                                style: const TextStyle(
                                                    fontSize: 14.0),
                                              ),
                                            ),
                                            value: 'female',
                                            isThreeLine: false,
                                            groupValue: _genderRadioButtonCubit
                                                .buttonValue,
                                            onChanged: (value) {
                                              _genderRadioButtonCubit
                                                  .changeRadioButtonValue(
                                                'female',
                                              );
                                            },
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: DefaultTextFormField(
                                  controller: _phoneTextEditingController,
                                  type: TextInputType.number,
                                  label: appLocalization!.phoneNumber,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return appLocalization!
                                          .phoneNumberIsRequired;
                                    }
                                    if (isWhiteSpacesWord(value)) {
                                      return appLocalization!
                                          .phoneNumberIsNotValid;
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              BuildCondition(
                                condition:
                                    state is! UpdateUserProfileLoadingState,
                                builder: (context) {
                                  return DefaultButton(
                                      function: () {
                                        _submit(context);
                                      },
                                      text: appLocalization!.edit);
                                },
                                fallback: (_) =>
                                    const CircularProgressIndicator(),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _submit(context) {
    if (!_formKey.currentState!.validate()) return;
    if (_genderRadioButtonCubit.buttonValue == null) {
      showErrorToast(error: appLocalization!.pleaseChooseAGender);
      return;
    }
    _updateUserProfileCubit.updateUserProfile(
      updateUserModel: UpdateUserModel(
        firstName: _firstNameTextEditingController.text.trim(),
        lastName: _lastNameTextEditingController.text.trim(),
        phone: _phoneTextEditingController.text.trim(),
        email: _emailTextEditingController.text.trim(),
        dob: _dobTextEditingController.text.trim(),
        gender: _genderRadioButtonCubit.buttonValue,
      ),
    );
  }
}
