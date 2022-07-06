import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:martizoom/business_logic_layer/addresses_cubit/addresses_cubit.dart';
import 'package:martizoom/business_logic_layer/app_info_cubit/app_info_cubit.dart';
import 'package:martizoom/business_logic_layer/contact_us_cubit/contact_us_cubit.dart';
import 'package:martizoom/business_logic_layer/countries_cubit/countries_cubit.dart';
import 'package:martizoom/business_logic_layer/device_details_cubit/device_details_cubit.dart';
import 'package:martizoom/business_logic_layer/home_markets_cubit/home_markets_cubit.dart';
import 'package:martizoom/business_logic_layer/installation_cubit/installation_cubit.dart';
import 'package:martizoom/business_logic_layer/languages_cubit/languages_cubit.dart';
import 'package:martizoom/business_logic_layer/main_page_tablet_cubit/main_page_tablet_cubit.dart';
import 'package:martizoom/business_logic_layer/offers_cubit/offers_cubit.dart';
import 'package:martizoom/business_logic_layer/orders_cubit/orders_cubit.dart';
import 'package:martizoom/business_logic_layer/update_language_cubit/update_language_cubit.dart';
import 'package:martizoom/business_logic_layer/update_password_cubit/update_password_cubit.dart';
import 'package:martizoom/business_logic_layer/update_user_country/update_user_country_cubit.dart';
import 'package:martizoom/business_logic_layer/update_user_profile_cubit/update_user_profile_cubit.dart';
import 'package:martizoom/business_logic_layer/update_user_view_settings_cubit/update_user_view_settings_cubit.dart';
import 'package:martizoom/business_logic_layer/user_data_cubit/user_data_cubit.dart';
import 'package:martizoom/data_layer/services/firebase_messaging_service.dart';
import 'package:martizoom/presentation_layer/base_page/base_phone_page.dart';
import 'package:martizoom/presentation_layer/base_page/base_tablet_page.dart';
import 'package:martizoom/shared/bloc_observer/bloc_server.dart';
import 'package:martizoom/shared/network/remote/firebase_helper.dart';
import 'package:martizoom/shared/styles/themes.dart';
import 'business_logic_layer/auth_cubit/auth_cubit.dart';
import 'business_logic_layer/backend_notifications_cubit/backend_notifications_cubit.dart';
import 'business_logic_layer/google_maps_cubit/google_maps_cubit.dart';
import 'business_logic_layer/home_top_markets_cubit/home_top_markets_cubit.dart';
import 'business_logic_layer/main_page_phone_cubit/main_page_phone_cubit.dart';
import 'business_logic_layer/my_carts_cubit/my_carts_cubit.dart';
import 'business_logic_layer/single_order_cubit/single_order_cubit.dart';
import 'shared/constants/constants.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  DioHelper.init();
  await CacheHelper.init();
  await FirebaseHelper.init();
  await FirebaseMessagingService().initNotifications();
  await checkPlayServices();
  isTabletDevice = await isTablet();
  accessToken = CacheHelper.getData(key: 'access_token');
  isLoggedIn = CacheHelper.getData(key: 'is_logged_in') ?? false;
  languageCode = CacheHelper.getData(key: langCodeKey) ?? 'en';
  viewType = CacheHelper.getData(key: viewTypeKey) ?? '3d';
  debugPrint('accessToken: $accessToken');
  debugPrint('isTabletDevice: $isTabletDevice');

  debugPrint('Device Id: ${await getDeviceId()}');
  Bloc.observer = MyBlocObserver();

  // BlocOverrides.runZoned(
  //   () => runApp(const MyApp()),
  //   blocObserver: MyBlocObserver(),
  // );

  // runApp(
  //   DevicePreview(
  //     enabled: false, // !kReleaseMode,
  //     builder: (context) {
  //       return MediaQuery(
  //         data: const MediaQueryData(),
  //         child: MyApp(),
  //       );
  //     },
  //   ),
  // );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({
    Key? key,
  }) : super(key: key);

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()?.restartApp();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();
  bool showViewDialog = true;

  restartApp() {
    setState(() {
      showViewDialog = false;
      key = UniqueKey();
      navigatorKey = GlobalKey<NavigatorState>();
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<InstallationCubit>(
            create: (context) => InstallationCubit(),
          ),
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(),
          ),
          BlocProvider<UpdatePasswordCubit>(
            create: (context) => UpdatePasswordCubit(),
          ),
          BlocProvider<UserDataCubit>(
            create: (context) {
              if (isLoggedIn) {
                return UserDataCubit()..getUserData();
              }
              return UserDataCubit();
            },
          ),
          BlocProvider<MainPagePhoneCubit>(
            create: (context) => MainPagePhoneCubit(),
          ),
          BlocProvider<MainPageTabletCubit>(
            create: (context) => MainPageTabletCubit(),
          ),
          BlocProvider<AddressesCubit>(
            create: (context) => AddressesCubit(),
          ),
          BlocProvider<CountriesCubit>(
            create: (context) => CountriesCubit(),
          ),
          BlocProvider<LanguagesCubit>(
            create: (context) => LanguagesCubit(),
          ),
          BlocProvider<DeviceDetailsCubit>(
            create: (context) => DeviceDetailsCubit(),
          ),
          BlocProvider<UpdateUserProfileCubit>(
            create: (context) => UpdateUserProfileCubit(),
          ),
          BlocProvider<UpdateLanguageCubit>(
            create: (context) => UpdateLanguageCubit(),
          ),
          BlocProvider<UpdateUserCountryCubit>(
            create: (context) => UpdateUserCountryCubit(),
          ),
          BlocProvider<HomeTopMarketsCubit>(
            create: (context) => HomeTopMarketsCubit(),
          ),
          BlocProvider<HomeMarketsCubit>(
            create: (context) => HomeMarketsCubit(),
          ),
          BlocProvider<MyCartsCubit>(
            create: (context) => MyCartsCubit(),
          ),
          BlocProvider<OrdersCubit>(
            create: (context) => OrdersCubit(),
          ),
          BlocProvider<OffersCubit>(
            create: (context) => OffersCubit()..getOffers(),
          ),
          BlocProvider<UpdateUserViewSettingsCubit>(
            create: (context) => UpdateUserViewSettingsCubit(),
          ),
          BlocProvider<BackendNotificationsCubit>(
            create: (context) => BackendNotificationsCubit(),
          ),
          BlocProvider<SingleOrderCubit>(
            create: (context) => SingleOrderCubit(),
          ),
          BlocProvider<AppInfoCubit>(
            create: (context) => AppInfoCubit(),
          ),
          BlocProvider<ContactUsCubit>(
            create: (context) => ContactUsCubit(),
          ),
          BlocProvider<GoogleMapsCubit>(
            create: (context) => GoogleMapsCubit(),
          ),

        ],
        child: BlocConsumer<InstallationCubit, InstallationState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return MaterialApp(
              navigatorKey: navigatorKey,
              title: 'Marti Zoom',
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              locale: Locale(
                languageCode,
              ),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: isTabletDevice
                  ? BaseTabletPage(
                      showViewDialog: showViewDialog,
                    )
                  : BasePhonePage(
                      showViewDialog: showViewDialog,
                    ),
            );
          },
        ),
      ),
    );
  }
}
