import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/city_model.dart';
import 'package:meta/meta.dart';

import '../../data_layer/repository/general_repository.dart';

part 'cities_state.dart';

class CitiesCubit extends Cubit<CitiesState> {
  CitiesCubit() : super(CitiesInitial());

  static CitiesCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final GeneralRepository _generalRepository = GeneralRepository();
  final List<CityModel> cities = [];

  getCities({required String zoneId}) {
    cities.clear();
    emit(GetCitiesDataLoadingState());

    _generalRepository.getCities(zoneId: zoneId).then((value) {
      cities.addAll(value);
      if (cities.isEmpty) {
        emit(GetCitiesDataEmptyState());
      } else {
        emit(GetCitiesDataSuccessState());
      }
    }).catchError((error) {
      debugPrint('$error');
      emit(GetCitiesDataErrorState());
    });
  }

  changeCity() {
    emit(ChangeCityState());
  }
}
