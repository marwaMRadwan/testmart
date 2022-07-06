import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/business_logic_layer/app_info_cubit/app_info_cubit.dart';
import 'package:martizoom/data_layer/models/about_app_model.dart';
import 'package:martizoom/presentation_layer/screens/app_item_info/app_item_info_tablet_screen.dart';
import 'package:martizoom/presentation_layer/screens/contact_us/contact_us_phone_screen.dart';
import 'package:martizoom/presentation_layer/screens/loading/loading_screen.dart';
import 'package:martizoom/shared/components/default_app_bar/default_tablet_app_bar.dart';
import 'package:martizoom/shared/components/default_empty_items_text.dart';
import 'package:martizoom/shared/components/default_error_widget.dart';
import 'package:martizoom/shared/components/my_divider.dart';
import 'package:martizoom/shared/constants/constants.dart';

class AboutAppTabletScreen extends StatefulWidget {
  const AboutAppTabletScreen({Key? key}) : super(key: key);

  @override
  State<AboutAppTabletScreen> createState() => _AboutAppTabletScreenState();
}

class _AboutAppTabletScreenState extends State<AboutAppTabletScreen> {
  late final AppInfoCubit _appInfoCubit;

  @override
  void initState() {
    _appInfoCubit = AppInfoCubit.get(context);
    _appInfoCubit.getAppInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultTabletAppBar(
          title: appLocalization!.aboutApp,
        ),
        body: BlocConsumer<AppInfoCubit, AppInfoState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return BuildCondition(
              condition: state is GetAppInfoErrorState,
              builder: (_) => DefaultErrorWidget(
                error: (state as GetAppInfoErrorState).error,
              ),
              fallback: (context) {
                return BuildCondition(
                    condition: state is GetAppInfoEmptyState,
                    builder: (_) => DefaultEmptyItemsText(
                          itemsName: appLocalization!.information,
                        ),
                    fallback: (context) {
                      return BuildCondition(
                          condition: state is GetAppInfoLoadingState,
                          builder: (_) => LoadingScreen(),
                          fallback: (context) {
                            final List<AboutAppInfoModel> appInfo =
                                _appInfoCubit.appInfo;
                            return ListView.separated(
                              padding: const EdgeInsets.all(
                                15.0,
                              ),
                              itemBuilder: (context, index) {
                                if (index == appInfo.length) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          appLocalization!.contactUs,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        trailing: const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.black,
                                        ),
                                        onTap: () {
                                          navigateTo(
                                            context: context,
                                            screen: ContactUsPhoneScreen(),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                }
                                return Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        appInfo[index].title ?? ' ',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black,
                                      ),
                                      onTap: () {
                                        navigateTo(
                                          context: context,
                                          screen: AppItemInfoTabletScreen(
                                            title: appInfo[index].title ?? ' ',
                                            content:
                                                appInfo[index].content ?? ' ',
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const MyDivider(),
                              itemCount: appInfo.length + 1,
                            );
                          });
                    });
              },
            );
          },
        ));
  }
}
