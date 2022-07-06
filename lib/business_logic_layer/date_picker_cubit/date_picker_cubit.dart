import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'date_picker_state.dart';

class DatePickerCubit extends Cubit<DatePickerState> {
  DatePickerCubit() : super(DatePickerInitial());

  static DatePickerCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  DateTime selectedDate = DateTime.now();

  changeDate(
      {required BuildContext context,
      required DateTime firstDate,
      required lastDate}) {
    showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: firstDate,
      lastDate: lastDate,
    ).then((value) {
      if (value != null) {
        selectedDate = value;
      }
      emit(ChangeDateState());
    }).catchError((error) {
      debugPrint('$error');
    });
  }
}
