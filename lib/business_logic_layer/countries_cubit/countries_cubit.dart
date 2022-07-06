import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/country_model.dart';
import 'package:martizoom/data_layer/repository/general_repository.dart';
import 'package:martizoom/shared/constants/constants.dart';
import 'package:meta/meta.dart';

part 'countries_state.dart';

class CountriesCubit extends Cubit<CountriesState> {
  CountriesCubit() : super(CountriesInitial());

  static CountriesCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final GeneralRepository _generalRepository = GeneralRepository();
  final List<CountryModel> countries = [];

  getCountries({required String langId}) {
    countries.clear();
    emit(GetCountriesDataLoadingState());
    _generalRepository.getCountries(langId: langId).then(
      (value) {
        countries.addAll(value);
        if (countries.isEmpty) {
          emit(GetCountriesDataEmptyState());
        } else {
          emit(GetCountriesDataSuccessState());
        }
      },
    ).catchError((error) {
      debugPrint('$error');
      showErrorToast(error: error);
      emit(GetCountriesDataErrorState(error: error));
    });
  }

  changeCountry() {
    emit(ChangeCountryState());
  }
}
