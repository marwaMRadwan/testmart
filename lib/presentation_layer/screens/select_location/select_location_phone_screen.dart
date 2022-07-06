import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:martizoom/business_logic_layer/google_maps_cubit/google_maps_cubit.dart';
import 'package:martizoom/shared/components/default_app_bar/default_phone_app_bar.dart';
import '../../../shared/constants/constants.dart';
import '../add_update_address/add_update_address_phone_screen.dart';

class SelectLocationPhoneScreen extends StatefulWidget {
  final bool isAddressDefault;

  const SelectLocationPhoneScreen({Key? key, required this.isAddressDefault})
      : super(key: key);

  @override
  _SelectLocationPhoneScreenState createState() =>
      _SelectLocationPhoneScreenState();
}

class _SelectLocationPhoneScreenState extends State<SelectLocationPhoneScreen> {
  bool get isAddressDefault => widget.isAddressDefault;

  late final GoogleMapsCubit _googleMapsCubit;
  final startAddressFocusNode = FocusNode();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _googleMapsCubit = GoogleMapsCubit.get(context);
    _googleMapsCubit.checkLocationPermission(0);
  }

  var _isLandscape;

  @override
  Widget build(BuildContext context) {
    _isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      key: _scaffoldKey,
      appBar: DefaultPhoneAppBar(title: appLocalization!.location),
      body: BlocConsumer<GoogleMapsCubit, GoogleMapsState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is CheckLocationPermissionDeniedState ||
              state is GetCurrentLocationErrorState) {
            navigateAndFinishTo(
              context: context,
              screen: AddUpdateAddressPhoneScreen(
                isDefaultAddress: isAddressDefault,
              ),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: Stack(
                  children: <Widget>[
                    // Map View
                    GoogleMap(
                      markers: Set<Marker>.from(_googleMapsCubit.markers),
                      initialCameraPosition: _googleMapsCubit.initialLocation,
                      zoomControlsEnabled: false,
                      mapType: MapType.normal,
                      onMapCreated: (GoogleMapController controller) {
                        _googleMapsCubit.mapController = controller;
                      },
                      onTap: (latLng) {
                        _googleMapsCubit.currentLatLng = latLng;
                        _googleMapsCubit.checkLocationPermission(1);
                      },
                      myLocationButtonEnabled: false,
                    ),
                    // Show zoom buttons
                    SafeArea(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: _isLandscape ? 30.0 : 10.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ClipOval(
                              child: Material(
                                color: Colors.blue.shade100, // button color
                                child: InkWell(
                                  splashColor: Colors.blue, // inkwell color
                                  child: const SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Icon(Icons.add),
                                  ),
                                  onTap: () {
                                    _googleMapsCubit.mapController
                                        .animateCamera(
                                      CameraUpdate.zoomIn(),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            ClipOval(
                              child: Material(
                                color: Colors.blue.shade100, // button color
                                child: InkWell(
                                  splashColor: Colors.blue, // inkwell color
                                  child: const SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Icon(Icons.remove),
                                  ),
                                  onTap: () {
                                    _googleMapsCubit.mapController
                                        .animateCamera(
                                      CameraUpdate.zoomOut(),
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    // Show the place input fields & button for
                    // showing the route
                    SafeArea(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                            width: setWidthValue(
                              portraitValue: 0.9,
                              landscapeValue: 0.7,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                      '${appLocalization!.location}: ${_googleMapsCubit.currentAddress}',
                                      overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Show current location button
                    SafeArea(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 10.0, bottom: 10.0),
                          child: ClipOval(
                            child: Material(
                              color: Colors.orange.shade100, // button color
                              child: InkWell(
                                splashColor: Colors.orange, // inkwell color
                                child: const SizedBox(
                                  width: 56,
                                  height: 56,
                                  child: Icon(Icons.my_location),
                                ),
                                onTap: () {
                                  _googleMapsCubit.checkLocationPermission(0);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      navigateTo(
                        context: context,
                        screen: AddUpdateAddressPhoneScreen(
                          isDefaultAddress: isAddressDefault,
                        ),
                      );
                    },
                    child: Text(
                      appLocalization!.skip,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  TextButton(
                    onPressed: () {
                      if (countryCode.toLowerCase() !=
                          _googleMapsCubit.untranslatedPlace!.isoCountryCode
                              ?.toLowerCase()) {
                        showErrorToast(
                          error: HttpException(
                            appLocalization!
                                .pleaseSelectALocationFromYourCountry,
                          ),
                        );
                        return;
                      }
                      navigateTo(
                        context: context,
                        screen: AddUpdateAddressPhoneScreen(
                          isDefaultAddress: isAddressDefault,
                          place: _googleMapsCubit.currentPlace,
                          govName: _googleMapsCubit.govName,
                        ),
                      );
                    },
                    child: Text(appLocalization!.next),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
