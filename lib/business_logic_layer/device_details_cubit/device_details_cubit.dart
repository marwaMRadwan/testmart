import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/device_details_model.dart';
import 'package:martizoom/data_layer/repository/general_repository.dart';
import 'package:martizoom/shared/constants/constants.dart';
import 'package:martizoom/shared/network/local/cache_helper.dart';
import 'package:meta/meta.dart';

part 'device_details_state.dart';

class DeviceDetailsCubit extends Cubit<DeviceDetailsState> {
  DeviceDetailsCubit() : super(DeviceDetailsInitial());

  static DeviceDetailsCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final GeneralRepository _generalRepository = GeneralRepository();

  storeDeviceDetails({required DeviceDetailsModel deviceDetailsModel}) {
    emit(
      AddDeviceDetailsLoadingState(),
    );

    _generalRepository
        .storeDeviceDetails(deviceDetailsModel: deviceDetailsModel)
        .then(
      (value) async {
        await CacheHelper.saveData(key: 'isInstalled', value: true);
        await chooseCountryId(id: deviceDetailsModel.country ?? '1');
        emit(AddDeviceDetailsSuccessState());
      },
    ).catchError(
      (error) {
        showErrorToast(error: error);
        debugPrint('$error');
        emit(AddDeviceDetailsErrorState());
      },
    );
  }
}
