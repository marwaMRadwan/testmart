import 'dart:io';

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:martizoom/business_logic_layer/addresses_cubit/addresses_cubit.dart';
import 'package:martizoom/data_layer/models/address_model.dart';
import 'package:martizoom/main.dart';
import 'package:martizoom/presentation_layer/screens/add_update_address/add_update_address_tablet_screen.dart';
import 'package:martizoom/presentation_layer/screens/loading/loading_screen.dart';
import 'package:martizoom/presentation_layer/screens/select_location/select_location_tablet_screen.dart';
import 'package:martizoom/shared/constants/constants.dart';

import '../../../shared/components/default_app_bar/default_tablet_app_bar.dart';
import '../../../shared/components/default_button.dart';
import '../../../shared/components/default_empty_items_text.dart';
import '../../../shared/components/default_error_widget.dart';
import '../../widgets/address/address_tablet_widget.dart';

class AddressesTabletScreen extends StatefulWidget {
  AddressesTabletScreen({Key? key}) : super(key: key);

  @override
  State<AddressesTabletScreen> createState() => _AddressesTabletScreenState();
}

class _AddressesTabletScreenState extends State<AddressesTabletScreen> {
  late final AddressesCubit _addressesCubit;

  @override
  void initState() {
    _addressesCubit = AddressesCubit.get(context);
    _addressesCubit.getUserAddresses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultTabletAppBar(
        title: appLocalization!.addresses,
      ),
      body: BlocConsumer<AddressesCubit, AddressesState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is SetDefaultAddressSuccessState) MyApp.restartApp(context);
        },
        builder: (context, state) {
          return BuildCondition(
            condition: state is GetAddressesDataErrorState,
            builder: (context) => DefaultErrorWidget(
              error: (state as GetAddressesDataErrorState).error,
              onPressed: () {
                _addressesCubit.getUserAddresses();
              },
            ),
            fallback: (context) => BuildCondition(
              condition: state is GetAddressesDataLoadingState,
              builder: (context) => LoadingScreen(),
              fallback: (context) {
                return BuildCondition(
                  condition: state is GetAddressesDataEmptyState,
                  builder: (context) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DefaultEmptyItemsText(
                        itemsName: appLocalization!.addAddress,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: setWidthValue(
                            portraitValue: 0.1,
                            landscapeValue: 0.1,
                          ),
                          vertical: setHeightValue(
                            portraitValue: 0.1,
                            landscapeValue: 0.1,
                          ),
                        ),
                        child: DefaultButton(
                          function: () {
                            if (Platform.isAndroid) {
                              checkPlayServices().then((value) {
                                if (value ==
                                    GooglePlayServicesAvailability.success) {
                                  navigateTo(
                                      context: context,
                                      screen: SelectLocationTabletScreen(
                                        isAddressDefault: _addressesCubit
                                            .userAddresses.isEmpty,
                                      ));
                                } else {
                                  AddUpdateAddressTabletScreen(
                                    isDefaultAddress:
                                        _addressesCubit.userAddresses.isEmpty,
                                  );
                                }
                              });
                            } else {
                              navigateTo(
                                context: context,
                                screen: SelectLocationTabletScreen(
                                  isAddressDefault:
                                      _addressesCubit.userAddresses.isEmpty,
                                ),
                              );
                            }
                          },
                          text: appLocalization!.addANewAddress,
                          radius: 10.0,
                        ),
                      ),
                    ],
                  ),
                  fallback: (context) {
                    final List<AddressModel> addresses =
                        _addressesCubit.userAddresses;
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        vertical: setHeightValue(
                          portraitValue: 0.02,
                          landscapeValue: 0.03,
                        ),
                        horizontal: setWidthValue(
                          portraitValue: 0.03,
                          landscapeValue: 0.07,
                        ),
                      ),
                      itemBuilder: (context, index) {
                        if (index == addresses.length) {
                          return DefaultButton(
                            function: () {
                              if (Platform.isAndroid) {
                                checkPlayServices().then((value) {
                                  if (value ==
                                      GooglePlayServicesAvailability.success) {
                                    navigateTo(
                                        context: context,
                                        screen: SelectLocationTabletScreen(
                                          isAddressDefault: _addressesCubit
                                              .userAddresses.isEmpty,
                                        ));
                                  } else {
                                    AddUpdateAddressTabletScreen(
                                      isDefaultAddress:
                                          _addressesCubit.userAddresses.isEmpty,
                                    );
                                  }
                                });
                              } else {
                                navigateTo(
                                  context: context,
                                  screen: SelectLocationTabletScreen(
                                    isAddressDefault:
                                        _addressesCubit.userAddresses.isEmpty,
                                  ),
                                );
                              }
                            },
                            text: appLocalization!.addANewAddress,
                            radius: 10.0,
                          );
                        }
                        return AddressTabletWidget(
                            addressModel: addresses[index]);
                      },
                      itemCount: addresses.length + 1,
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
