import 'dart:io';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/business_logic_layer/countries_cubit/countries_cubit.dart';
import 'package:martizoom/business_logic_layer/device_details_cubit/device_details_cubit.dart';
import 'package:martizoom/data_layer/models/device_details_model.dart';
import 'package:martizoom/presentation_layer/screens/loading/loading_screen.dart';
import 'package:martizoom/presentation_layer/screens/on_board/on_board_phone_screen.dart';
import 'package:martizoom/shared/components/default_button.dart';
import 'package:martizoom/shared/components/default_error_widget.dart';
import 'package:martizoom/shared/constants/constants.dart';
import 'package:martizoom/shared/styles/colors.dart';

class ChooseCountryPhoneScreen extends StatefulWidget {
  final String languageId;
  final bool showViewDialog;

  const ChooseCountryPhoneScreen({
    Key? key,
    required this.languageId,
    required this.showViewDialog,
  }) : super(key: key);

  @override
  State<ChooseCountryPhoneScreen> createState() =>
      _ChooseCountryPhoneScreenState();
}

class _ChooseCountryPhoneScreenState extends State<ChooseCountryPhoneScreen> {
  late final CountriesCubit _countriesCubit;
  late final DeviceDetailsCubit _deviceDetailsCubit;

  String? countryValue;

  @override
  void initState() {
    _countriesCubit = CountriesCubit.get(context);
    _deviceDetailsCubit = DeviceDetailsCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  height: setHeightValue(
                    portraitValue: 0.15,
                    landscapeValue: 0.23,
                  ),
                  width: setWidthValue(
                    portraitValue: 0.3,
                    landscapeValue: 0.15,
                  ),
                ),
              ),
            ),
            BlocConsumer<DeviceDetailsCubit, DeviceDetailsState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state is AddDeviceDetailsSuccessState) {
                  navigateAndFinishTo(
                      context: context,
                      screen: OnBoardPhoneScreen(
                        showViewDialog: widget.showViewDialog,
                      ));
                }
              },
              builder: (context, state) {
                return BlocConsumer<CountriesCubit, CountriesState>(
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
                                  physics: const NeverScrollableScrollPhysics(),
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
                                        portraitValue: 0.03,
                                        landscapeValue: 0.15,
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
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 2.0)),
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
                                        BlocBuilder<CountriesCubit,
                                            CountriesState>(
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
                                                          country.countriesId ??
                                                              '0',
                                                      groupValue: countryValue,
                                                      onChanged: (value) {
                                                        countryValue = value;
                                                        _countriesCubit
                                                            .changeCountry();
                                                      },
                                                    ),
                                                  )
                                                  .toList(),
                                            );
                                          },
                                        ),
                                        DefaultButton(
                                          function: () {
                                            if (countryValue == null) {
                                              showErrorToast(
                                                error: HttpException(
                                                  appLocalization!
                                                      .pleaseSelectACountry,
                                                ),
                                              );
                                              return;
                                            }
                                            _deviceDetailsCubit
                                                .storeDeviceDetails(
                                                    deviceDetailsModel:
                                                        DeviceDetailsModel(
                                              country: countryValue,
                                              language: widget.languageId,
                                            ));
                                          },
                                          text: appLocalization!.go,
                                          radius: 10.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
