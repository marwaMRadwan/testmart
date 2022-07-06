import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/zone_model.dart';
import 'package:martizoom/data_layer/repository/general_repository.dart';

part 'zones_state.dart';

class ZonesCubit extends Cubit<ZonesState> {
  ZonesCubit() : super(ZonesInitial());

  static ZonesCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final GeneralRepository _generalRepository = GeneralRepository();
  final List<ZoneModel> zones = [];

  getZones() {
    zones.clear();
    emit(GetZonesDataLoadingState());

    _generalRepository.getZones().then((value) {
      zones.addAll(value);
      if (zones.isEmpty) {
        emit(GetZonesDataEmptyState());
      } else {
        emit(GetZonesDataSuccessState());
      }
    }).catchError((error) {
      debugPrint('$error');
      emit(GetZonesDataErrorState());
    });
  }

  changeZone() {
    emit(ChangeZoneState());
  }
}
