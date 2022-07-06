import 'dart:io';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart' as intl;
import 'package:martizoom/shared/network/local/cache_helper.dart';

import '../../data_layer/models/file_model.dart';

const remoteBaseURL = 'https://Martizoom.com/api/';
const remoteStorageBaseURL = 'http://new.marwaradwan.co/storage/app/public/';

const localBaseURL = 'https://10.0.2.2/HRApp/api/';
const localStorageBaseURL = 'https://10.0.2.2/HRApp/storage/app/public/';

const baseURL = remoteBaseURL;
const storageBaseURL = remoteStorageBaseURL;

String? accessToken;
bool isLoggedIn = false;
bool isTabletDevice = false;
String viewType = '3d';
const viewTypeKey = 'view_type';
const langCodeKey = 'lang';
const countryIdKey = 'country';

AppLocalizations? appLocalization;

bool isWhiteSpacesWord(String value) {
  if (value.isEmpty) return false;
  value = value.trim();
  debugPrint('value: ${value.length}');
  return value.isEmpty;
}

navigateTo({
  required context,
  required Widget screen,
}) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => screen,
    ),
  );
}

navigateAndFinishTo({
  required context,
  required Widget screen,
  Function? then,
}) {
  Navigator.of(context)
      .pushReplacement(
        MaterialPageRoute(
          builder: (_) => screen,
        ),
      )
      .then((value) => then);
}

showToast({
  required String message,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 18.0);
}

chooseToastColor(ToastStates state) {
  switch (state) {
    case ToastStates.SUCCESS:
      return Colors.green;
    case ToastStates.FAILED:
      return Colors.red;
    case ToastStates.WARNING:
      return Colors.amber;
  }
}

// Toasts enum
enum ToastStates { SUCCESS, FAILED, WARNING }

getErrorMessage(error) {
  if (error is DioError && error.error is SocketException) {
    return appLocalization!.noInternetConnection;
  } else if (error is HttpException) {
    return error.message;
  } else if (error is FormatException) {
    return error.message;
  } else if (error is PermissionDeniedException) {
    return error.message;
  } else {
    // return 'حدث خطأ ما!';
    return appLocalization!.thereIsAnError;
  }
}

showErrorToast({required error}) {
  showToast(message: getErrorMessage(error), state: ToastStates.FAILED);
}

showSuccessToast({required String successMessage}) {
  showToast(message: successMessage, state: ToastStates.SUCCESS);
}

showLoadingToast() {
  showToast(message: appLocalization!.loading, state: ToastStates.WARNING);
}

DateTime getParsedDateTime(String? formattedString) {
  try {
    return intl.DateFormat('yyyy/MM/dd').parse(formattedString ?? '');
  } catch (e) {
    debugPrint('getParsedDateTime: $e');
  }
  return DateTime.now();
}

String convertDateTimeToString(DateTime date) {
  intl.DateFormat dateFormat = intl.DateFormat("yyyy/MM/dd");
  try {
    return dateFormat.format(date);
  } catch (e) {
    debugPrint('convertDateTimeToString: $e');
  }
  return '';
}

void showNetworkImageDialog(context,
    {required String imageTitle, required String imageURL}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: SimpleDialog(
          title: Center(child: Text(imageTitle)),
          children: [
            Image.network(
              '$storageBaseURL/$imageURL',
              fit: BoxFit.fill,
              errorBuilder: (_, __, ___) => Container(
                height: 100.0,
                width: 100.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    },
  );
}

Future<String> getDeviceId() async {
  String identifier = '';
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo build = await deviceInfoPlugin.androidInfo;
    AndroidBuildVersion deviceVersion = build.version;
    double release = double.parse(deviceVersion.release!);

    identifier = build.androidId!; //UUID for Android

  } else if (Platform.isIOS) {
    var data = await deviceInfoPlugin.iosInfo;

    double release = double.parse(data.systemVersion!);
    identifier = data.identifierForVendor!;
  }

  return identifier + '.martiZoom';
}

String languageCode = 'en';

chooseLanguageCode({
  required String langCode,
}) async {
  await CacheHelper.saveData(key: langCodeKey, value: langCode);
  languageCode = CacheHelper.getData(key: langCodeKey);
  print('lang code :$languageCode');
}

String countryId = '0';
String countryCode = '';

chooseCountryId({required String id}) async {
  await CacheHelper.saveData(key: countryIdKey, value: id);
  countryId = CacheHelper.getData(key: countryIdKey);
}

Future<bool> isTablet() async {
  if (Platform.isIOS) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

    return iosInfo.model?.toLowerCase() == "ipad";
  } else {
    // The equivalent of the "smallestWidth" qualifier on Android.
    var shortestSide =
        MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
            .size
            .shortestSide;
    print('shortestSide : $shortestSide');
    // Determine if we should use mobile layout or not, 600 here is
    // a common breakpoint for a typical 7-inch tablet.
    return shortestSide > 550.0;
  }
}

bool isPortrait() {
  return MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
          .orientation ==
      Orientation.portrait;
}

setWidthValue({required double portraitValue, required double landscapeValue}) {
  if (isPortrait()) {
    return MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
            .size
            .width *
        portraitValue;
  } else {
    return MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
            .size
            .width *
        landscapeValue;
  }
}

setHeightValue(
    {required double portraitValue, required double landscapeValue}) {
  if (isPortrait()) {
    return MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
            .size
            .height *
        portraitValue;
  } else {
    return MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
            .size
            .height *
        landscapeValue;
  }
}

// Platform messages are asynchronous, so we initialize in an async method.
Future<GooglePlayServicesAvailability> checkPlayServices() async {
  GooglePlayServicesAvailability playStoreAvailability;
  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    playStoreAvailability = await GoogleApiAvailability.instance
        .checkGooglePlayServicesAvailability();
  } on PlatformException {
    playStoreAvailability = GooglePlayServicesAvailability.unknown;
  }
  return playStoreAvailability;
}
