import 'dart:io';

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/business_logic_layer/countries_cubit/countries_cubit.dart';
import 'package:martizoom/business_logic_layer/installation_cubit/installation_cubit.dart';
import 'package:martizoom/business_logic_layer/languages_cubit/languages_cubit.dart';
import 'package:martizoom/presentation_layer/screens/choose_country/choose_country_tablet_screen.dart';
import 'package:martizoom/presentation_layer/screens/loading/loading_screen.dart';
import 'package:martizoom/shared/components/default_button.dart';
import 'package:martizoom/shared/constants/constants.dart';
import 'package:martizoom/shared/styles/colors.dart';

import '../../../shared/components/default_error_widget.dart';

class ChooseLanguageTabletScreen extends StatefulWidget {
  final bool showViewDialog;

  ChooseLanguageTabletScreen({
    Key? key,
    required this.showViewDialog,
  }) : super(key: key);

  @override
  State<ChooseLanguageTabletScreen> createState() =>
      _ChooseLanguageTabletScreenState();
}

class _ChooseLanguageTabletScreenState
    extends State<ChooseLanguageTabletScreen> {
  late final LanguagesCubit _languagesCubit;

  String? languageValue;

  @override
  void initState() {
    _languagesCubit = LanguagesCubit.get(context);
    _languagesCubit.getLanguages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InstallationCubit, InstallationState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is ChooseLanguageSuccessState) {
          navigateAndFinishTo(
            context: context,
            screen: ChooseCountryTabletScreen(
              languageId: languageValue ?? '1',
              showViewDialog: widget.showViewDialog,
            ),
          );
        }
      },
      child: BlocConsumer<LanguagesCubit, LanguagesState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: defaultColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: setHeightValue(
                      portraitValue: 0.3,
                      landscapeValue: 0.4,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                              MediaQuery.of(context).size.width, 300.0)),
                    ),
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.fill,
                        height: setHeightValue(portraitValue: 0.15, landscapeValue: 0.23,),
                        width: setWidthValue(portraitValue: 0.3, landscapeValue: 0.15,),
                      ),
                    ),
                  ),
                  BuildCondition(
                      condition: state is GetLanguagesDataErrorState,
                      builder: (_) => DefaultErrorWidget(
                          error: (state as GetLanguagesDataErrorState).error),
                      fallback: (context) {
                      return BuildCondition(
                          condition: state is GetLanguagesDataLoadingState,
                          builder: (context) => LoadingScreen(),
                          fallback: (context) {
                            final _languages = _languagesCubit.languages;
                            return SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
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
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.asset(
                                        'assets/images/logo.png',
                                        fit: BoxFit.fill,
                                        height: 120.0,
                                        width: 120.0,
                                      ),
                                    ),
                                    Text(
                                      appLocalization!.chooseLanguage,
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
                                    Column(
                                      children: _languages
                                          .map(
                                            (language) => Column(
                                              children: [
                                                RadioListTile<String>(
                                                  title: Text(
                                                    '${language.name}',
                                                    style: const TextStyle(
                                                      fontSize: 20.0,
                                                    ),
                                                  ),
                                                  value: language.languagesId ?? '0',
                                                  groupValue: languageValue,
                                                  onChanged: (value) {
                                                    languageValue = value;
                                                    _languagesCubit.changeLanguage();
                                                  },
                                                ),
                                                const Divider(),
                                              ],
                                            ),
                                          )
                                          .toList(),
                                    ),
                                    DefaultButton(
                                      function: changeLanguageAndNavToCountries,
                                      text: appLocalization!.next,
                                      radius: 10.0,
                                      height: 60.0,
                                      textFontSize: 20.0,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// in this method we change the app language
  /// and then navigate to choosing country
  /// screen
  changeLanguageAndNavToCountries() {
    if (languageValue == null) {
      showErrorToast(
        error: HttpException(
          appLocalization!.pleaseSelectALanguage,
        ),
      );
      return;
    }
    InstallationCubit.get(context).selectLanguage(
      langCode: languageValue ?? '1',
    );
    CountriesCubit.get(context).getCountries(
      langId: languageValue ?? '1',
    );
  }
}
