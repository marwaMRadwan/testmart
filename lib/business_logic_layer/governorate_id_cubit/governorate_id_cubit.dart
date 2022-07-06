import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/shared/constants/constants.dart';
import 'package:meta/meta.dart';

import '../../data_layer/repository/general_repository.dart';

part 'governorate_id_state.dart';

class GovernorateIdCubit extends Cubit<GovernorateIdState> {
  GovernorateIdCubit() : super(GovernorateIdInitial());

  static GovernorateIdCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final GeneralRepository _generalRepository = GeneralRepository();
  String? govId;

  getGovernorate({required String govName}) {
    emit(GetGovernorateIdLoadingState());
    _generalRepository.getGovernorateId(govName: govName).then(
      (value) {
        govId = value;
        emit(GetGovernorateIdSuccessState());
      },
    ).catchError((error) {
      debugPrint('$error');
      showErrorToast(error: error);
      emit(GetGovernorateIdErrorState());
    });
  }
}
