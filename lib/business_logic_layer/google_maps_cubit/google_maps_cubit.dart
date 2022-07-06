import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../shared/constants/constants.dart';

part 'google_maps_state.dart';

class GoogleMapsCubit extends Cubit<GoogleMapsState> {
  GoogleMapsCubit() : super(GoogleMapsInitial());

  static GoogleMapsCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);

  final CameraPosition initialLocation =
      const CameraPosition(target: LatLng(0.0, 0.0));
  late GoogleMapController mapController;

  late LatLng currentLatLng;

  String currentAddress = '';
  String govName = '';

  Placemark currentPlace = Placemark();
  Placemark? untranslatedPlace;

  final startAddressFocusNode = FocusNode();

  Set<Marker> markers = {};

  Future<Position?> checkLocationPermission(int getAddressFlag) async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(CheckLocationPermissionDeniedState());
      }
    }

    if (permission == LocationPermission.deniedForever) {
      emit(CheckLocationPermissionDeniedState());
    }
    emit(CheckLocationPermissionSuccessState());

    if (getAddressFlag == 0) {
      return await _getCurrentLocation();
    } else {
      return await _getAddress();
    }
  }

  // Method for retrieving the current location
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      currentLatLng = LatLng(position.latitude, position.longitude);
      debugPrint('CURRENT POS: $position');
      emit(GetCurrentLocationSuccessState());
      await _getAddress();
    }).catchError((e) {
      debugPrint(e);
      emit(GetCurrentLocationErrorState());
    });
  }

  // Method for retrieving the address
  _getAddress() async {
    String localId = languageCode + '_' + countryCode.toUpperCase();
    try {
      List<Placemark> translatedPlaceMarks = await placemarkFromCoordinates(
          currentLatLng.latitude, currentLatLng.longitude,
          localeIdentifier: localId);

      currentPlace = translatedPlaceMarks[0];

      currentAddress = "${currentPlace.street}";
      List<Placemark> p = await placemarkFromCoordinates(
        currentLatLng.latitude,
        currentLatLng.longitude,
      );
      untranslatedPlace = p[0];

      if (countryCode.toLowerCase() !=
          untranslatedPlace!.isoCountryCode?.toLowerCase()) {
        showErrorToast(
            error: HttpException(
                appLocalization!.pleaseSelectALocationFromYourCountry));
      }
      govName = currentPlace.administrativeArea ?? '';

      // your Location Marker
      Marker yourMarker = Marker(
        markerId: MarkerId(appLocalization!.you),
        position: currentLatLng,
        infoWindow: InfoWindow(
          title: appLocalization!.you,
          snippet: currentAddress,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Adding the markers to the list
      markers.add(yourMarker);

      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: currentLatLng,
            zoom: 18.0,
          ),
        ),
      );
      emit(GetAddressState());
    } catch (e) {
      debugPrint('$e');
    }
  }
}
