import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'radio_button_state.dart';

class RadioButtonCubit extends Cubit<RadioButtonState> {
  RadioButtonCubit() : super(RadioButtonInitial());
  static RadioButtonCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  dynamic buttonValue;

  changeRadioButtonValue(value) {
    buttonValue = value;
    emit(ChangeRadioButtonValueState());
  }
}
