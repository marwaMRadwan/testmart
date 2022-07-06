import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/business_logic_layer/languages_cubit/languages_cubit.dart';
import 'package:martizoom/business_logic_layer/update_language_cubit/update_language_cubit.dart';
import 'package:martizoom/main.dart';
import 'package:martizoom/presentation_layer/screens/loading/loading_screen.dart';
import 'package:martizoom/shared/components/default_app_bar/default_phone_app_bar.dart';
import 'package:martizoom/shared/components/default_button.dart';
import 'package:martizoom/shared/constants/constants.dart';
import 'package:martizoom/shared/styles/colors.dart';

import '../../../shared/components/default_error_widget.dart';

class UpdateLanguagePhoneScreen extends StatefulWidget {
  UpdateLanguagePhoneScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateLanguagePhoneScreen> createState() =>
      _UpdateLanguagePhoneScreenState();
}

class _UpdateLanguagePhoneScreenState extends State<UpdateLanguagePhoneScreen> {
  late final LanguagesCubit _languagesCubit;

  String languageValue = languageCode == 'en' ? '1' : '4';

  @override
  void initState() {
    _languagesCubit = LanguagesCubit.get(context);
    _languagesCubit.getLanguages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateLanguageCubit, UpdateLanguageState>(
      listener: (context, updateLanguageState) {
        // TODO: implement listener
        if (updateLanguageState is UpdateUserLanguageSuccessState) {
          MyApp.restartApp(context);
        }
      },
      builder: (context, updateLanguageState) {
        return BlocConsumer<LanguagesCubit, LanguagesState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, languagesState) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: DefaultPhoneAppBar(
                title: appLocalization!.languages,
              ),
              body: BuildCondition(
                  condition: languagesState is GetLanguagesDataErrorState,
                  builder: (_) => DefaultErrorWidget(
                      error:
                          (languagesState as GetLanguagesDataErrorState).error),
                  fallback: (context) {
                    return BuildCondition(
                        condition:
                            languagesState is GetLanguagesDataLoadingState,
                        builder: (_) => LoadingScreen(),
                        fallback: (context) {
                          final _languages = _languagesCubit.languages;
                          return SingleChildScrollView(
                            padding: EdgeInsets.symmetric(
                              vertical: setHeightValue(
                                portraitValue: 0.1,
                                landscapeValue: 0.1,
                              ),
                              horizontal: setWidthValue(
                                portraitValue: 0.072,
                                landscapeValue: 0.15,
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: setWidthValue(
                                  portraitValue: 0.05,
                                  landscapeValue: 0.06,
                                ),
                                vertical: setHeightValue(
                                  portraitValue: 0.04,
                                  landscapeValue: 0.08,
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
                                    appLocalization!.chooseLanguage,
                                    style: const TextStyle(
                                      color: defaultColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: setHeightValue(
                                      portraitValue: 0.025,
                                      landscapeValue: 0.05,
                                    ),
                                  ),
                                  Column(
                                    children: _languages
                                        .map(
                                          (language) => Column(
                                            children: [
                                              RadioListTile<String>(
                                                title: Text('${language.name}'),
                                                value:
                                                    language.languagesId ?? '1',
                                                groupValue: languageValue,
                                                onChanged: (value) {
                                                  languageValue = value!;
                                                  _languagesCubit
                                                      .changeLanguage();
                                                },
                                              ),
                                              const Divider(),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  BuildCondition(
                                      condition: updateLanguageState
                                          is UpdateUserLanguageLoadingState,
                                      builder: (_) =>
                                          const CircularProgressIndicator(),
                                      fallback: (context) {
                                        return DefaultButton(
                                          function: updateLanguage,
                                          text: appLocalization!.update,
                                          radius: 10.0,
                                        );
                                      }),
                                ],
                              ),
                            ),
                          );
                        });
                  }),
            );
          },
        );
      },
    );
  }

  updateLanguage() {
    UpdateLanguageCubit.get(context).updateUserLanguage(langId: languageValue);
  }
}
