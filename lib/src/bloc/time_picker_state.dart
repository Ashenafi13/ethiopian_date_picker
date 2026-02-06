import 'package:equatable/equatable.dart';
import '../utils/date_picker_utils.dart';

/// Base state for the time picker
abstract class TimePickerState extends Equatable {
  final int selectedHour; // 1-12
  final int selectedMinute; // 0-59
  final EthiopianTimePeriod selectedPeriod;

  const TimePickerState({
    required this.selectedHour,
    required this.selectedMinute,
    required this.selectedPeriod,
  });

  @override
  List<Object> get props => [selectedHour, selectedMinute, selectedPeriod];

  /// Get the selected time as EthiopianTime
  EthiopianTime get ethiopianTime => EthiopianTime(
    hour: selectedHour,
    minute: selectedMinute,
    period: selectedPeriod,
  );
}

/// Initial state with current Ethiopian time
class TimePickerInitialState extends TimePickerState {
  TimePickerInitialState()
    : super(
        selectedHour: EthiopianTime.now().hour,
        selectedMinute: EthiopianTime.now().minute,
        selectedPeriod: EthiopianTime.now().period,
      );
}

/// State when hour is changed
class TimePickerHourChangedState extends TimePickerState {
  const TimePickerHourChangedState({
    required super.selectedHour,
    required super.selectedMinute,
    required super.selectedPeriod,
  });
}

/// State when minute is changed
class TimePickerMinuteChangedState extends TimePickerState {
  const TimePickerMinuteChangedState({
    required super.selectedHour,
    required super.selectedMinute,
    required super.selectedPeriod,
  });
}

/// State when period (morning/evening) is changed
class TimePickerPeriodChangedState extends TimePickerState {
  const TimePickerPeriodChangedState({
    required super.selectedHour,
    required super.selectedMinute,
    required super.selectedPeriod,
  });
}
