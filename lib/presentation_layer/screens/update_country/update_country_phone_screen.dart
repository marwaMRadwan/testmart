import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/business_logic_layer/countries_cubit/countries_cubit.dart';
import 'package:martizoom/business_logic_layer/update_user_country/update_user_country_cubit.dart';
import 'package:martizoom/presentation_layer/screens/loading/loading_screen.dart';
import 'package:martizoom/shared/components/default_app_bar/default_phone_app_bar.dart';
import 'package:martizoom/shared/components/default_button.dart';
import 'package:martizoom/shared/constants/constants.dart';
import 'package:martizoom/shared/styles/colors.dart';

import '../../../main.dart';
import '../../../shared/components/default_error_widget.dart';

class UpdateCountryPhoneScreen extends StatefulWidget {
  UpdateCountryPhoneScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateCountryPhoneScreen> createState() =>
      _UpdateCountryPhoneScreenState();
}

class _UpdateCountryPhoneScreenState extends State<UpdateCountryPhoneScreen> {
  late final CountriesCubit _countriesCubit;

  String countryValue = countryId;

  @override
  void initState() {
    _countriesCubit = CountriesCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateUserCountryCubit, UpdateUserCountryState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is UpdateUserCountrySuccessState) {
          MyApp.restartApp(context);
        }
      },
      builder: (context, updateCountryState) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: DefaultPhoneAppBar(
            title: appLocalization!.countries,
          ),
          body: BlocConsumer<CountriesCubit, CountriesState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return BuildCondition(
                  condition: state is GetCountriesDataErrorState,
                  builder: (_) => DefaultErrorWidget(
                      error: (state as GetCountriesDataErrorState).error),
                  fallback: (context) {
                    return BuildCondition(
                        condition: state is GetCountriesDataLoadingState,
                        builder: (_) => LoadingScreen(),
                        fallback: (context) {
                          return SingleChildScrollView(
                            padding: EdgeInsets.symmetric(
                              vertical: setHeightValue(
                                portraitValue: 0.02,
                                landscapeValue: 0.05,
                              ),
                              horizontal: setWidthValue(
                                portraitValue: 0.06,
                                landscapeValue: 0.15,
                              ),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(
                                top: setHeightValue(
                                  portraitValue: 0.09,
                                  landscapeValue: 0.2,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: setHeightValue(
                                  portraitValue: 0.05,
                                  landscapeValue: 0.06,
                                ),
                                horizontal: setWidthValue(
                                  portraitValue: 0.05,
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
                                    appLocalization!.chooseCountry,
                                    style: const TextStyle(
                                      color: defaultColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: setHeightValue(
                                      portraitValue: 0.02,
                                      landscapeValue: 0.05,
                                    ),
                                  ),
                                  BlocBuilder<CountriesCubit, CountriesState>(
                                    builder: (context, state) {
                                      final _countries =
                                          _countriesCubit.countries;
                                      return Column(
                                        children: _countries
                                            .map(
                                              (country) =>
                                                  RadioListTile<String>(
                                                title: Text(
                                                    '${country.countriesName}'),
                                                value:
                                                    country.countriesId ?? '0',
                                                groupValue: countryValue,
                                                onChanged: (value) {
                                                  countryValue = value!;
                                                  debugPrint(
                                                      'countryValue $countryValue');
                                                  _countriesCubit
                                                      .changeCountry();
                                                },
                                              ),
                                            )
                                            .toList(),
                                      );
                                    },
                                  ),
                                  BuildCondition(
                                      condition: updateCountryState
                                          is UpdateUserCountryLoadingState,
                                      builder: (_) =>
                                          const CircularProgressIndicator(),
                                      fallback: (context) {
                                        return DefaultButton(
                                          function: updateCountry,
                                          text: appLocalization!.update,
                                          radius: 10.0,
                                        );
                                      }),
                                ],
                              ),
                            ),
                          );
                        });
                  });
            },
          ),
        );
      },
    );
  }

  updateCountry() {
    UpdateUserCountryCubit.get(context).updateUserCountry(
      countryId: countryValue,
    );
  }
}
