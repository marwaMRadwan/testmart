import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/business_logic_layer/countries_cubit/countries_cubit.dart';
import 'package:martizoom/business_logic_layer/user_data_cubit/user_data_cubit.dart';
import 'package:martizoom/presentation_layer/screens/about_app/about_app_tablet_screen.dart';
import 'package:martizoom/presentation_layer/screens/addresses/addresses_tablet_screen.dart';
import 'package:martizoom/presentation_layer/screens/loading/loading_screen.dart';
import 'package:martizoom/presentation_layer/screens/update_country/update_country_tablet_screen.dart';
import 'package:martizoom/presentation_layer/screens/update_languge/update_language_tablet_screen.dart';
import 'package:martizoom/presentation_layer/screens/update_password/update_password_tablet_screen.dart';
import 'package:martizoom/presentation_layer/screens/update_user_profile/update_user_profile_tablet_screen.dart';
import 'package:martizoom/presentation_layer/screens/update_user_view_settings/update_user_view_settings_tablet_screen.dart';
import 'package:martizoom/shared/components/app_icons/app_icons.dart';
import 'package:martizoom/shared/components/default_error_widget.dart';
import 'package:martizoom/shared/constants/constants.dart';
import 'package:martizoom/shared/styles/colors.dart';

import '../../../business_logic_layer/auth_cubit/auth_cubit.dart';
import '../../../main.dart';
import '../../widgets/app_header/app_header_widget.dart';

class ProfileTabletScreen extends StatelessWidget {
  ProfileTabletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authCubit = AuthCubit.get(context);
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        final appUser = UserDataCubit.get(context).appUser;
        return BuildCondition(
            condition: state is GetUserDataErrorState,
            builder: (_) => DefaultErrorWidget(
                  error: (state as GetUserDataErrorState).error,
                  onPressed: () {
                    UserDataCubit.get(context).getUserData();
                  },
                ),
            fallback: (context) {
              return BuildCondition(
                  condition: state is GetUserDataLoadingState,
                  builder: (_) => LoadingScreen(),
                  fallback: (context) {
                    return Container(
                      height: setHeightValue(
                        portraitValue: 1.0,
                        landscapeValue: 1.0,
                      ),
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppHeaderWidget(
                              height: setHeightValue(
                                portraitValue: 0.2,
                                landscapeValue: 0.2,
                              ),
                            ),
                            SizedBox(
                              height: setHeightValue(
                                portraitValue: 0.02,
                                landscapeValue: 0.01,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: setWidthValue(
                                  portraitValue: 0.05,
                                  landscapeValue: 0.06,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${appUser!.firstName} ${appUser.lastName}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: setHeightValue(
                                      portraitValue: 0.025,
                                      landscapeValue: 0.03,
                                    ),
                                  ),
                                  if (appUser.defaultAddress != null)
                                    Row(
                                      children: [
                                        Icon(
                                          AppIcons.map,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(
                                          appUser.defaultAddress?.address ?? '',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  SizedBox(
                                    height: setHeightValue(
                                      portraitValue: 0.027,
                                      landscapeValue: 0.1,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(
                                        bottom: 10.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(
                                        25.0,
                                      ),
                                      border: Border.all(
                                          color: Theme.of(context).primaryColor,
                                          width: 2.0),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: setHeightValue(
                                            portraitValue: 0.03,
                                            landscapeValue: 0.1,
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            appLocalization!.editProfile,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          leading: const Icon(
                                            Icons.edit,
                                            color: defaultColor,
                                          ),
                                          trailing: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.black,
                                          ),
                                          onTap: () {
                                            navigateTo(
                                                context: context,
                                                screen:
                                                    UpdateUserProfileTabletScreen());
                                          },
                                        ),
                                        const Divider(),
                                        ListTile(
                                          title: Text(
                                            appLocalization!.updatePassword,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          leading: const Icon(
                                            Icons.edit,
                                            color: defaultColor,
                                          ),
                                          trailing: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.black,
                                          ),
                                          onTap: () {
                                            navigateTo(
                                                context: context,
                                                screen:
                                                    UpdatePasswordTabletScreen());
                                          },
                                        ),
                                        const Divider(),
                                        ListTile(
                                          title: Text(
                                            appLocalization!.userViewSettings,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          leading: const Icon(
                                            Icons.settings,
                                            color: defaultColor,
                                          ),
                                          trailing: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.black,
                                          ),
                                          onTap: () {
                                            navigateTo(
                                                context: context,
                                                screen:
                                                    UpdateUserViewSettingsTabletScreen());
                                          },
                                        ),
                                        const Divider(),
                                        ListTile(
                                          title: Text(
                                            appLocalization!.manageAddress,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          leading: const Icon(
                                            AppIcons.map,
                                            color: defaultColor,
                                          ),
                                          trailing: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.black,
                                          ),
                                          onTap: () {
                                            navigateTo(
                                                context: context,
                                                screen:
                                                    AddressesTabletScreen());
                                          },
                                        ),
                                        const Divider(),
                                        ListTile(
                                          title: Text(
                                            appLocalization!.languages,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          leading: const Icon(
                                            AppIcons.offers,
                                            color: defaultColor,
                                          ),
                                          trailing: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.black,
                                          ),
                                          onTap: () {
                                            navigateTo(
                                                context: context,
                                                screen:
                                                    UpdateLanguageTabletScreen());
                                          },
                                        ),
                                        const Divider(),
                                        ListTile(
                                          title: Text(
                                            appLocalization!.countries,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          leading: const Icon(
                                            AppIcons.offers,
                                            color: defaultColor,
                                          ),
                                          trailing: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.black,
                                          ),
                                          onTap: () {
                                            final langId = languageCode == 'ar'
                                                ? '4'
                                                : '1';
                                            CountriesCubit.get(context)
                                                .getCountries(langId: langId);

                                            navigateTo(
                                                context: context,
                                                screen:
                                                    UpdateCountryTabletScreen(
                                                  languageId: langId,
                                                ));
                                          },
                                        ),
                                        const Divider(),
                                        ListTile(
                                          title: Text(
                                            appLocalization!.aboutApp,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          leading: const Icon(
                                            Icons.question_mark,
                                            color: defaultColor,
                                          ),
                                          trailing: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.black,
                                          ),
                                          onTap: () {
                                            navigateTo(
                                                context: context,
                                                screen:
                                                    const AboutAppTabletScreen());
                                          },
                                        ),
                                        const Divider(),
                                        SizedBox(
                                          height: setHeightValue(
                                            portraitValue: 0.05,
                                            landscapeValue: 0.05,
                                          ),
                                        ),
                                        BlocConsumer<AuthCubit, AuthState>(
                                          listener: (context, state) {
                                            // TODO: implement listener
                                            if (state is LogoutSuccessState) {
                                              MyApp.restartApp(context);
                                            }
                                          },
                                          builder: (context, state) {
                                            return state is LogoutLoadingState
                                                ? const CircularProgressIndicator()
                                                : TextButton(
                                                    onPressed: () {
                                                      _authCubit.userLogout();
                                                    },
                                                    child: Text(
                                                      appLocalization!.logOut,
                                                      style: const TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18.0,
                                                      ),
                                                    ),
                                                  );
                                          },
                                        ),
                                        SizedBox(
                                          height: setHeightValue(
                                            portraitValue: 0.02,
                                            landscapeValue: 0.05,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            });
      },
    );
  }
}
