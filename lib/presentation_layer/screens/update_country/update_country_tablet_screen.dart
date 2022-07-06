import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/business_logic_layer/countries_cubit/countries_cubit.dart';
import 'package:martizoom/business_logic_layer/update_user_country/update_user_country_cubit.dart';
import 'package:martizoom/presentation_layer/screens/loading/loading_screen.dart';
import 'package:martizoom/shared/components/default_app_bar/default_tablet_app_bar.dart';
import 'package:martizoom/shared/components/default_button.dart';
import 'package:martizoom/shared/constants/constants.dart';
import 'package:martizoom/shared/styles/colors.dart';

import '../../../main.dart';
import '../../../shared/components/default_error_widget.dart';

class UpdateCountryTabletScreen extends StatefulWidget {
  final String languageId;

  UpdateCountryTabletScreen({
    Key? key,
    required this.languageId,
  }) : super(key: key);

  @override
  State<UpdateCountryTabletScreen> createState() =>
      _UpdateCountryTabletScreenState();
}

class _UpdateCountryTabletScreenState extends State<UpdateCountryTabletScreen> {
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
          appBar: DefaultTabletAppBar(
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
                                portraitValue: 0.08,
                                landscapeValue: 0.07,
                              ),
                              horizontal: setWidthValue(
                                portraitValue: 0.08,
                                landscapeValue: 0.1,
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: setWidthValue(
                                  portraitValue: 0.07,
                                  landscapeValue: 0.05,
                                ),
                                vertical: setHeightValue(
                                  portraitValue: 0.03,
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
                                      fontSize: 24.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: setHeightValue(
                                      portraitValue: 0.02,
                                      landscapeValue: 0.04,
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
                                                  '${country.countriesName}',
                                                  style: const TextStyle(
                                                    fontSize: 18.0,
                                                  ),
                                                ),
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
