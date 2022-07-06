import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/about_app_model.dart';
import 'package:martizoom/data_layer/repository/general_repository.dart';
import 'package:meta/meta.dart';

part 'app_info_state.dart';

class AppInfoCubit extends Cubit<AppInfoState> {
  AppInfoCubit() : super(AppInfoInitial());
  static AppInfoCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final GeneralRepository _generalRepository = GeneralRepository();
  final List<AboutAppInfoModel> appInfo = [];

  getAppInfo() {
    appInfo.clear();
    emit(GetAppInfoLoadingState());
    _generalRepository.getAppInfo().then(
          (value) {
        appInfo.addAll(value);
        if (appInfo.isEmpty) {
          emit(GetAppInfoEmptyState());
        } else {
          emit(GetAppInfoSuccessState());
        }
      },
    ).catchError((error) {
      debugPrint('$error');
      emit(GetAppInfoErrorState(error: error));
    });
  }
}
