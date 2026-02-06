import 'package:equatable/equatable.dart';
import '../utils/date_picker_utils.dart';

/// Base event for the time picker
abstract class TimePickerEvent extends Equatable {
  const TimePickerEvent();

  @override
  List<Object> get props => [];
}

/// Event when hour is changed
class HourChanged extends TimePickerEvent {
  final int hour;
  final int currentMinute;
  final EthiopianTimePeriod currentPeriod;

  const HourChanged({
    required this.hour,
    required this.currentMinute,
    required this.currentPeriod,
  });

  @override
  List<Object> get props => [hour, currentMinute, currentPeriod];
}

/// Event when minute is changed
class MinuteChanged extends TimePickerEvent {
  final int minute;
  final int currentHour;
  final EthiopianTimePeriod currentPeriod;

  const MinuteChanged({
    required this.minute,
    required this.currentHour,
    required this.currentPeriod,
  });

  @override
  List<Object> get props => [minute, currentHour, currentPeriod];
}

/// Event when period (morning/evening) is toggled
class PeriodChanged extends TimePickerEvent {
  final EthiopianTimePeriod period;
  final int currentHour;
  final int currentMinute;

  const PeriodChanged({
    required this.period,
    required this.currentHour,
    required this.currentMinute,
  });

  @override
  List<Object> get props => [period, currentHour, currentMinute];
}

/// Event to reset time to current
class ResetToCurrentTime extends TimePickerEvent {
  const ResetToCurrentTime();
}
