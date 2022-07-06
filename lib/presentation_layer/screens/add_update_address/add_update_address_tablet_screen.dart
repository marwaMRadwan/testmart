import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:martizoom/business_logic_layer/add_update_address/add_update_address_cubit.dart';
import 'package:martizoom/business_logic_layer/addresses_cubit/addresses_cubit.dart';
import 'package:martizoom/business_logic_layer/cities_cubit/cities_cubit.dart';
import 'package:martizoom/business_logic_layer/governorate_id_cubit/governorate_id_cubit.dart';
import 'package:martizoom/business_logic_layer/zones_cubit/zones_cubit.dart';
import 'package:martizoom/data_layer/models/address_model.dart';
import 'package:martizoom/data_layer/models/city_model.dart';
import 'package:martizoom/data_layer/models/zone_model.dart';
import 'package:martizoom/main.dart';
import 'package:martizoom/presentation_layer/screens/loading/loading_screen.dart';
import 'package:martizoom/shared/components/default_app_bar/default_tablet_app_bar.dart';
import 'package:martizoom/shared/components/default_button.dart';
import 'package:martizoom/shared/components/default_text_form_field.dart';
import 'package:martizoom/shared/constants/constants.dart';

class AddUpdateAddressTabletScreen extends StatefulWidget {
  final AddressModel? addressModel;
  final bool isDefaultAddress;
  String? govName;
  Placemark? place;

  AddUpdateAddressTabletScreen(
      {Key? key,
      this.addressModel,
      required this.isDefaultAddress,
      this.place,
      this.govName})
      : super(key: key);

  @override
  State<AddUpdateAddressTabletScreen> createState() =>
      _AddUpdateAddressTabletScreenState();
}

class _AddUpdateAddressTabletScreenState
    extends State<AddUpdateAddressTabletScreen> {
  AddressModel? get addressModel => widget.addressModel;

  bool get isDefaultAddress => widget.isDefaultAddress;

  String? get govName => widget.govName;

  Placemark? get place => widget.place;

  set govName(String? value) {
    widget.govName = value;
  }

  set place(Placemark? value) {
    widget.place = value;
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _neighbourHoodNameTextEditingController =
      TextEditingController();

  final TextEditingController _streetNameTextEditingController =
      TextEditingController();

  final TextEditingController _buildingNameTextEditingController =
      TextEditingController();

  final TextEditingController _floorNumberTextEditingController =
      TextEditingController();

  final TextEditingController _apartmentTextEditingController =
      TextEditingController();

  final TextEditingController _additionalAddressInfoTextEditingController =
      TextEditingController();

  final TextEditingController _addressNieckNameTextEditingController =
      TextEditingController();

  String? govDropDownValue;
  String? cityDropDownValue;

  late final AddUpdateAddressCubit _addUpdateAddressCubit;

  late final ZonesCubit _zonesCubit;
  late final CitiesCubit _citiesCubit;
  late final GovernorateIdCubit _governorateIdCubit;

  @override
  void initState() {
    _addUpdateAddressCubit = AddUpdateAddressCubit();
    _zonesCubit = ZonesCubit();
    _citiesCubit = CitiesCubit();
    _governorateIdCubit = GovernorateIdCubit();

    if (govName != null && govName!.isNotEmpty && place != null) {
      try {
        int? buildNum = int.tryParse(
            (place?.street ?? '').split('،').first.substring(0, 2));
        if (buildNum != null) {
          _buildingNameTextEditingController.text = buildNum.toString();
        }
        _streetNameTextEditingController.text = place?.street ?? '';
        _governorateIdCubit.getGovernorate(govName: govName ?? '');
      } catch (error) {
        debugPrint('$error');
      }
    } else {
      _zonesCubit.getZones();
    }
    if (addressModel != null) {
      _neighbourHoodNameTextEditingController.text =
          addressModel!.neighbourHood ?? '';
      _streetNameTextEditingController.text = addressModel!.street ?? '';
      _buildingNameTextEditingController.text = addressModel!.building ?? '';
      _floorNumberTextEditingController.text = addressModel!.floor ?? '';
      _apartmentTextEditingController.text = addressModel!.apartment ?? '';
      _additionalAddressInfoTextEditingController.text =
          addressModel!.additionalAddressInfo ?? '';
      _addressNieckNameTextEditingController.text =
          addressModel!.addressNieckName ?? '';
    }
    super.initState();
  }

  @override
  void dispose() {
    _zonesCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _addUpdateAddressCubit,
        ),
        BlocProvider(
          create: (context) => _governorateIdCubit,
        ),
      ],
      child: BlocConsumer<AddUpdateAddressCubit, AddUpdateAddressState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is AddUpdateAddressSuccessState) {
            if (isDefaultAddress) {
              MyApp.restartApp(context);
            } else {
              AddressesCubit.get(context).getUserAddresses();
              Navigator.of(context).pop();
            }
          }
        },
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async => state is! AddUpdateAddressLoadingState,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: DefaultTabletAppBar(
                title: addressModel != null
                    ? appLocalization!.editAddress
                    : appLocalization!.addAddress,
                backButtonPressed:
                    state is! AddUpdateAddressLoadingState ? null : () {},
              ),
              body: BlocConsumer<GovernorateIdCubit, GovernorateIdState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if (state is! GetGovernorateIdLoadingState) {
                    if (state is GetGovernorateIdErrorState) {
                      place = null;
                      govName = null;
                    }
                    _zonesCubit.getZones();
                  }
                },
                builder: (context, state) {
                  return BuildCondition(
                      condition: state is GetGovernorateIdLoadingState,
                      builder: (_) => Container(
                            color: Colors.white,
                            child: LoadingScreen(),
                          ),
                      fallback: (context) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: setHeightValue(
                                portraitValue: 0.01,
                                landscapeValue: 0.02,
                              ),
                              horizontal: setWidthValue(
                                portraitValue: 0.03,
                                landscapeValue: 0.03,
                              ),
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: setHeightValue(
                                      portraitValue: 0.05,
                                      landscapeValue: 0.03,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: setWidthValue(
                                        portraitValue: 0.05,
                                        landscapeValue: 0.05,
                                      ),
                                      vertical: setHeightValue(
                                        portraitValue: 0.03,
                                        landscapeValue: 0.05,
                                      ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: setHeightValue(
                                            portraitValue: 0.01,
                                            landscapeValue: 0.1,
                                          ),
                                        ),
                                        BlocProvider(
                                          create: (context) => _zonesCubit,
                                          child: BlocConsumer<ZonesCubit,
                                              ZonesState>(
                                            listener: (context, state) {
                                              // TODO: implement listener
                                              if (state
                                                  is GetZonesDataSuccessState) {
                                                if (addressModel != null) {
                                                  govDropDownValue =
                                                      addressModel?.govId ??
                                                          '1';
                                                } else if (govName != null &&
                                                    govName!.isNotEmpty) {
                                                  govDropDownValue =
                                                      _governorateIdCubit
                                                              .govId ??
                                                          '1';
                                                  final ZoneModel tempZone =
                                                      _zonesCubit.zones.firstWhere(
                                                          (element) =>
                                                              element.zoneId ==
                                                              govDropDownValue,
                                                          orElse: () =>
                                                              ZoneModel(
                                                                  zoneId:
                                                                      '-1'));
                                                  if (tempZone.zoneId == '-1') {
                                                    govDropDownValue = null;
                                                  }
                                                }
                                                _citiesCubit.getCities(
                                                    zoneId: govDropDownValue ??
                                                        '1');
                                              }
                                            },
                                            builder: (context, state) {
                                              return DropdownButtonFormField(
                                                value: govDropDownValue,
                                                items: _zonesCubit.zones
                                                    .map((ZoneModel zone) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    child: Text(
                                                        '${zone.zoneName}'),
                                                    value: zone.zoneId,
                                                  );
                                                }).toList(),
                                                onChanged: (String? value) {
                                                  if (value !=
                                                      govDropDownValue) {
                                                    govDropDownValue = value;
                                                    _zonesCubit.changeZone();
                                                    _citiesCubit.getCities(
                                                        zoneId:
                                                            govDropDownValue ??
                                                                '1');
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  label: FittedBox(
                                                    fit: BoxFit.cover,
                                                    child: Text(
                                                      state is ChangeZoneState
                                                          ? appLocalization!
                                                              .governorate
                                                          : appLocalization!
                                                              .chooseGovernorate,
                                                    ),
                                                  ),
                                                  hintText: appLocalization!
                                                      .chooseGovernorate,
                                                ),
                                                elevation: 8,
                                                isExpanded: true,
                                                validator: (v) {
                                                  if (v == null) {
                                                    return appLocalization!
                                                        .governorateIsRequired;
                                                  }
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: setHeightValue(
                                              portraitValue: 0.015,
                                              landscapeValue: 0.02,
                                            ),
                                          ),
                                          child: BlocProvider(
                                            create: (context) => _citiesCubit,
                                            child: BlocConsumer<CitiesCubit,
                                                CitiesState>(
                                              listener: (context, state) {
                                                // TODO: implement listener
                                                if (state
                                                    is GetCitiesDataSuccessState) {
                                                  cityDropDownValue = null;
                                                  if (addressModel != null &&
                                                      addressModel?.govId ==
                                                          govDropDownValue) {
                                                    cityDropDownValue =
                                                        addressModel?.zoneId;
                                                  }
                                                }
                                              },
                                              builder: (context, state) {
                                                return DropdownButtonFormField(
                                                  value: cityDropDownValue,
                                                  items: _citiesCubit.cities
                                                      .map((CityModel city) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      child:
                                                          Text('${city.name}'),
                                                      value: city.id,
                                                    );
                                                  }).toList(),
                                                  onChanged: (String? value) {
                                                    if (value !=
                                                        cityDropDownValue) {
                                                      cityDropDownValue = value;
                                                      _citiesCubit.changeCity();
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    label: FittedBox(
                                                      fit: BoxFit.cover,
                                                      child: Text(
                                                        state is ChangeCityState
                                                            ? appLocalization!
                                                                .area
                                                            : appLocalization!
                                                                .chooseAnArea,
                                                      ),
                                                    ),
                                                    hintText: appLocalization!
                                                        .chooseAnArea,
                                                  ),
                                                  elevation: 8,
                                                  isExpanded: true,
                                                  validator: (v) {
                                                    if (v == null) {
                                                      return appLocalization!
                                                          .areaIsRequired;
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: setHeightValue(
                                              portraitValue: 0.015,
                                              landscapeValue: 0.02,
                                            ),
                                          ),
                                          child: DefaultTextFormField(
                                            controller:
                                                _neighbourHoodNameTextEditingController,
                                            type: TextInputType.text,
                                            label: appLocalization!
                                                .neighbourhoodName,
                                            validate: (String value) {
                                              if (value.isEmpty) {
                                                return appLocalization!
                                                    .neighbourHoodNameIsRequired;
                                              }
                                              if (isWhiteSpacesWord(value)) {
                                                return appLocalization!
                                                    .neighbourHoodNameIsNotValid;
                                              }
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: setHeightValue(
                                              portraitValue: 0.015,
                                              landscapeValue: 0.02,
                                            ),
                                          ),
                                          child: DefaultTextFormField(
                                            controller:
                                                _streetNameTextEditingController,
                                            type: TextInputType.text,
                                            label: appLocalization!.streetName,
                                            validate: (String value) {
                                              if (value.isEmpty) {
                                                return appLocalization!
                                                    .streetNameIsRequired;
                                              }
                                              if (isWhiteSpacesWord(value)) {
                                                return appLocalization!
                                                    .streetNameIsNotValid;
                                              }
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: setHeightValue(
                                              portraitValue: 0.015,
                                              landscapeValue: 0.02,
                                            ),
                                          ),
                                          child: DefaultTextFormField(
                                            controller:
                                                _buildingNameTextEditingController,
                                            type: TextInputType.text,
                                            label:
                                                appLocalization!.buildingName,
                                            validate: (String value) {
                                              if (value.isEmpty) {
                                                return appLocalization!
                                                    .buildingNameIsRequired;
                                              }
                                              if (isWhiteSpacesWord(value)) {
                                                return appLocalization!
                                                    .buildingNameIsNotValid;
                                              }
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: setHeightValue(
                                              portraitValue: 0.015,
                                              landscapeValue: 0.02,
                                            ),
                                          ),
                                          child: DefaultTextFormField(
                                            controller:
                                                _floorNumberTextEditingController,
                                            type: TextInputType.number,
                                            label: appLocalization!.floorNumber,
                                            validate: (String value) {
                                              if (value.isEmpty) {
                                                return appLocalization!
                                                    .floorNumberIsRequired;
                                              }
                                              if (isWhiteSpacesWord(value)) {
                                                return appLocalization!
                                                    .floorNumberIsNotValid;
                                              }
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: setHeightValue(
                                              portraitValue: 0.015,
                                              landscapeValue: 0.02,
                                            ),
                                          ),
                                          child: DefaultTextFormField(
                                            controller:
                                                _apartmentTextEditingController,
                                            type: TextInputType.text,
                                            label: appLocalization!.apartment,
                                            validate: (String value) {
                                              if (value.isEmpty) {
                                                return appLocalization!
                                                    .apartmentIsRequired;
                                              }
                                              if (isWhiteSpacesWord(value)) {
                                                return appLocalization!
                                                    .apartmentIsNotValid;
                                              }
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: setHeightValue(
                                              portraitValue: 0.015,
                                              landscapeValue: 0.02,
                                            ),
                                          ),
                                          child: DefaultTextFormField(
                                            controller:
                                                _additionalAddressInfoTextEditingController,
                                            type: TextInputType.text,
                                            label: appLocalization!
                                                .additionalAddressInfo,
                                            validate: (String value) {
                                              if (value.isEmpty) {
                                                return appLocalization!
                                                    .additionalAddressInfoIsRequired;
                                              }
                                              if (isWhiteSpacesWord(value)) {
                                                return appLocalization!
                                                    .additionalAddressInfoIsNotValid;
                                              }
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: setHeightValue(
                                              portraitValue: 0.015,
                                              landscapeValue: 0.02,
                                            ),
                                          ),
                                          child: DefaultTextFormField(
                                            controller:
                                                _addressNieckNameTextEditingController,
                                            type: TextInputType.text,
                                            label: appLocalization!
                                                .addressNickName,
                                            validate: (String value) {
                                              if (value.isEmpty) {
                                                return appLocalization!
                                                    .addressNickNameIsRequired;
                                              }
                                              if (isWhiteSpacesWord(value)) {
                                                return appLocalization!
                                                    .addressNickNameIsNotValid;
                                              }
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: setHeightValue(
                                            portraitValue: 0.03,
                                            landscapeValue: 0.04,
                                          ),
                                        ),
                                        BuildCondition(
                                          condition: state
                                              is! AddUpdateAddressLoadingState,
                                          builder: (context) {
                                            return DefaultButton(
                                                function: () {
                                                  _submit(context);
                                                },
                                                text: addressModel != null
                                                    ? appLocalization!.edit
                                                    : appLocalization!.add);
                                          },
                                          fallback: (_) =>
                                              const CircularProgressIndicator(),
                                        ),
                                        SizedBox(
                                          height: setHeightValue(
                                            portraitValue: 0.03,
                                            landscapeValue: 0.04,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _submit(context) {
    if (!_formKey.currentState!.validate()) return;
    if (addressModel == null) {
      _addUpdateAddressCubit.addUserAddress(
        addressModel: AddressModel(
          govId: govDropDownValue,
          zoneId: cityDropDownValue,
          neighbourHood: _neighbourHoodNameTextEditingController.text.trim(),
          street: _streetNameTextEditingController.text.trim(),
          building: _buildingNameTextEditingController.text.trim(),
          floor: _floorNumberTextEditingController.text.trim(),
          apartment: _apartmentTextEditingController.text.trim(),
          additionalAddressInfo:
              _additionalAddressInfoTextEditingController.text.trim(),
          addressNieckName: _addressNieckNameTextEditingController.text.trim(),
          isDefault: '0',
          location:
              "https://www.google.com/maps/place/30%C2%B005'09.4%22N+31%C2%B018'27.8%22E/@30.085952,31.3099097,17z/data=!3m1!4b1!4m6!3m5!1s0x0:0x0!7e2!8m2!3d30.085952!4d31.3077206",
        ),
      );
    } else {
      _addUpdateAddressCubit.updateUserAddress(
        addressModel: addressModel!
          ..zoneId = cityDropDownValue
          ..govId = govDropDownValue
          ..neighbourHood = _neighbourHoodNameTextEditingController.text.trim()
          ..street = _streetNameTextEditingController.text.trim()
          ..building = _buildingNameTextEditingController.text.trim()
          ..floor = _floorNumberTextEditingController.text.trim()
          ..apartment = _apartmentTextEditingController.text.trim()
          ..additionalAddressInfo =
              _additionalAddressInfoTextEditingController.text.trim()
          ..addressNieckName =
              _addressNieckNameTextEditingController.text.trim(),
      );
    }
  }
}
