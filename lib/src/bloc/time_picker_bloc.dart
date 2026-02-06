import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/date_picker_utils.dart';
import 'time_picker_event.dart';
import 'time_picker_state.dart';

/// BLoC for managing Ethiopian time picker state
class TimePickerBloc extends Bloc<TimePickerEvent, TimePickerState> {
  TimePickerBloc() : super(TimePickerInitialState()) {
    on<HourChanged>(_onHourChanged);
    on<MinuteChanged>(_onMinuteChanged);
    on<PeriodChanged>(_onPeriodChanged);
    on<ResetToCurrentTime>(_onResetToCurrentTime);
  }

  void _onHourChanged(HourChanged event, Emitter<TimePickerState> emit) {
    emit(
      TimePickerHourChangedState(
        selectedHour: event.hour,
        selectedMinute: event.currentMinute,
        selectedPeriod: event.currentPeriod,
      ),
    );
  }

  void _onMinuteChanged(MinuteChanged event, Emitter<TimePickerState> emit) {
    emit(
      TimePickerMinuteChangedState(
        selectedHour: event.currentHour,
        selectedMinute: event.minute,
        selectedPeriod: event.currentPeriod,
      ),
    );
  }

  void _onPeriodChanged(PeriodChanged event, Emitter<TimePickerState> emit) {
    emit(
      TimePickerPeriodChangedState(
        selectedHour: event.currentHour,
        selectedMinute: event.currentMinute,
        selectedPeriod: event.period,
      ),
    );
  }

  void _onResetToCurrentTime(
    ResetToCurrentTime event,
    Emitter<TimePickerState> emit,
  ) {
    final now = EthiopianTime.now();
    emit(
      TimePickerHourChangedState(
        selectedHour: now.hour,
        selectedMinute: now.minute,
        selectedPeriod: now.period,
      ),
    );
  }
}
