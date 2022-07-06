import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/business_logic_layer/radio_button_cubit/radio_button_cubit.dart';
import 'package:martizoom/main.dart';
import 'package:martizoom/shared/components/default_app_bar/default_tablet_app_bar.dart';
import 'package:martizoom/shared/components/default_button.dart';
import 'package:martizoom/shared/constants/constants.dart';
import 'package:martizoom/shared/styles/colors.dart';

import '../../../business_logic_layer/update_user_view_settings_cubit/update_user_view_settings_cubit.dart';

class UpdateUserViewSettingsTabletScreen extends StatefulWidget {
  UpdateUserViewSettingsTabletScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateUserViewSettingsTabletScreen> createState() =>
      _UpdateUserViewSettingsTabletScreenState();
}

class _UpdateUserViewSettingsTabletScreenState
    extends State<UpdateUserViewSettingsTabletScreen> {
  final RadioButtonCubit _radioButtonCubit = RadioButtonCubit();

  @override
  void initState() {
    _radioButtonCubit.buttonValue = viewType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateUserViewSettingsCubit,
        UpdateUserViewSettingsState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is UpdateUserViewSettingsSuccessState) {
          MyApp.restartApp(context);
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async => state is! UpdateUserViewSettingsLoadingState,
          child: Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: DefaultTabletAppBar(
              title: appLocalization!.userViewSettings,
              backButtonPressed:
                  state is! UpdateUserViewSettingsLoadingState ? null : () {},
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                vertical: setHeightValue(
                  portraitValue: 0.08,
                  landscapeValue: 0.1,
                ),
                horizontal: setWidthValue(
                  portraitValue: 0.06,
                  landscapeValue: 0.1,
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: setWidthValue(
                    portraitValue: 0.07,
                    landscapeValue: 0.07,
                  ),
                  vertical: setHeightValue(
                    portraitValue: 0.04,
                    landscapeValue: 0.06,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2.0,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      appLocalization!.chooseViewType,
                      style: const TextStyle(
                        color: defaultColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    SizedBox(
                      height: setHeightValue(
                        portraitValue: 0.04,
                        landscapeValue: 0.04,
                      ),
                    ),
                    BlocProvider(
                      create: (context) => _radioButtonCubit,
                      child: BlocConsumer<RadioButtonCubit, RadioButtonState>(
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          return Column(
                            children: ['3d', '2d']
                                .map(
                                  (type) => Column(
                                    children: [
                                      RadioListTile<String>(
                                        title: Text(
                                          type,
                                          style: const TextStyle(
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        value: type,
                                        groupValue:
                                            _radioButtonCubit.buttonValue,
                                        onChanged: (value) {
                                          _radioButtonCubit
                                              .changeRadioButtonValue(value);
                                        },
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                    ),
                    BuildCondition(
                        condition: state is UpdateUserViewSettingsLoadingState,
                        builder: (_) => const CircularProgressIndicator(),
                        fallback: (context) {
                          return DefaultButton(
                            function: updateViewSettings,
                            text: appLocalization!.update,
                            radius: 10.0,
                          );
                        }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  updateViewSettings() {
    UpdateUserViewSettingsCubit.get(context)
        .updateUserViewSettings(type: _radioButtonCubit.buttonValue);
  }
}
