import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/data_layer/models/offer_model.dart';
import 'package:martizoom/data_layer/repository/offers_repository.dart';
import 'package:meta/meta.dart';

part 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  OffersCubit() : super(OffersInitial());

  static OffersCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final OffersRepository _offersRepository = OffersRepository();
  final List<OfferModel> offers = [];

  getOffers() {
    offers.clear();
    emit(GetOffersDataLoadingState());
    _offersRepository.getOffers().then(
      (value) {
        offers.addAll(value);
        if (offers.isEmpty) {
          emit(GetOffersDataEmptyState());
        } else {
          emit(GetOffersDataSuccessState());
        }
      },
    ).catchError((error) {
      debugPrint('$error');
      emit(GetOffersDataErrorState(error: error));
    });
  }
}
