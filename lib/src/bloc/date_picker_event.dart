import 'package:abushakir/abushakir.dart';
import 'package:equatable/equatable.dart';

/// Base class for all date picker events.
abstract class DatePickerEvent extends Equatable {
  const DatePickerEvent();
}

class AlertIntialEvent extends DatePickerEvent {
  const AlertIntialEvent();
  @override
  List<Object?> get props => [];
}

class GetFirstValue extends DatePickerEvent {
  final int firstValue;
  const GetFirstValue(this.firstValue);
  @override
  List<Object> get props => [firstValue];
}

class GetSecondValueEvent extends DatePickerEvent {
  final int secondValue;
  const GetSecondValueEvent(this.secondValue);
  @override
  List<Object> get props => [secondValue];
}

class RemoveFirstValueEvent extends DatePickerEvent {
  final int firstValue;
  const RemoveFirstValueEvent(this.firstValue);
  @override
  List<Object> get props => [firstValue];
}

class RemoveSecondValueEvent extends DatePickerEvent {
  final int secondValue;
  const RemoveSecondValueEvent(this.secondValue);
  @override
  List<Object> get props => [secondValue];
}

class GetSelectedValuesEvent extends DatePickerEvent {
  final List selectedValues;
  const GetSelectedValuesEvent(this.selectedValues);
  @override
  List<Object> get props => [selectedValues];
}

class CurrentDayCalendar extends DatePickerEvent {
  final ETC currentMonth;
  const CurrentDayCalendar(this.currentMonth);
  @override
  List<Object> get props => [currentMonth];
}

/// Event to navigate to the next month.
class NextMonthCalendar extends DatePickerEvent {
  /// The current month being displayed.
  final ETC currentMonth;
  const NextMonthCalendar(this.currentMonth);
  @override
  List<Object> get props => [currentMonth.nextMonth];
}

/// Event to navigate to the previous month.
class PrevMonthCalendar extends DatePickerEvent {
  /// The current month being displayed.
  final ETC currentMonth;
  const PrevMonthCalendar(this.currentMonth);
  @override
  List<Object> get props => [currentMonth.prevMonth];
}

/// Event to navigate to a specific year.
class CalenderByYear extends DatePickerEvent {
  /// The target year.
  final int year;

  /// The current month.
  final ETC currentMonth;
  const CalenderByYear(this.currentMonth, this.year);
  @override
  List<Object> get props => [currentMonth, year];
}

class NextYearCalendar extends DatePickerEvent {
  final ETC currentMonth;
  const NextYearCalendar(this.currentMonth);
  @override
  List<Object> get props => [currentMonth.nextMonth];
}

class PrevYearCalendar extends DatePickerEvent {
  final ETC currentMonth;
  const PrevYearCalendar(this.currentMonth);
  @override
  List<Object> get props => [currentMonth.prevMonth];
}

class GetDayName extends DatePickerEvent {
  final int dayIndex;
  final int crossAxisCount;
  final String userLanguage;
  const GetDayName(this.dayIndex, this.crossAxisCount, this.userLanguage);
  @override
  List<Object?> get props => [dayIndex, crossAxisCount];
}

class GetYearList extends DatePickerEvent {
  final int startYear;
  final int endYear;
  const GetYearList(this.startYear, this.endYear);
  @override
  List<Object?> get props => [startYear, endYear];
}

class GetSelectedIndex extends DatePickerEvent {
  final int selectedIndex;
  final int startYear;
  final int endYear;
  final int selectedYear;
  const GetSelectedIndex(
    this.selectedIndex,
    this.startYear,
    this.endYear,
    this.selectedYear,
  );
  @override
  List<Object?> get props => [selectedIndex, startYear, endYear, selectedYear];
}

/// Event to add a single date selection.
class AddSingleValues extends DatePickerEvent {
  /// Formatted date string.
  final String singleDate;

  /// Current context moment.
  final ETC currentMoment;

  /// Numeric representation for comparison.
  final int dateForComparision;
  const AddSingleValues(
    this.singleDate,
    this.currentMoment,
    this.dateForComparision,
  );
  @override
  List<Object?> get props => [singleDate, currentMoment, dateForComparision];
}

/// Event to remove a single date selection.
class RemoveItemFromList extends DatePickerEvent {
  /// Formatted date string.
  final String singleDate;

  /// Current context moment.
  final ETC currentMoment;

  /// Numeric representation for comparison.
  final int dateForComparision;
  const RemoveItemFromList(
    this.singleDate,
    this.currentMoment,
    this.dateForComparision,
  );
  @override
  List<Object?> get props => [singleDate, currentMoment, dateForComparision];
}

class AddInitialValue extends DatePickerEvent {
  final String firstDate;
  final int day;
  final int month;
  final int year;
  final int firstDateForComparision;
  final ETC currentMoment;
  const AddInitialValue(
    this.firstDate,
    this.day,
    this.month,
    this.year,
    this.firstDateForComparision,
    this.currentMoment,
  );
  @override
  List<Object?> get props => [
    firstDate,
    day,
    month,
    year,
    firstDateForComparision,
    currentMoment,
  ];
}

class RemoveInitialValue extends DatePickerEvent {
  final String firstDate;
  final int firstDateForComparision;
  final ETC currentMoment;
  const RemoveInitialValue(
    this.firstDate,
    this.firstDateForComparision,
    this.currentMoment,
  );
  @override
  List<Object?> get props => [
    firstDate,
    firstDateForComparision,
    currentMoment,
  ];
}

class AddSecondValue extends DatePickerEvent {
  final String secondDate;
  final int day;
  final int month;
  final int year;
  final int firstDateForComparision;
  final ETC currentMoment;
  const AddSecondValue(
    this.secondDate,
    this.day,
    this.month,
    this.year,
    this.firstDateForComparision,
    this.currentMoment,
  );
  @override
  List<Object?> get props => [
    secondDate,
    day,
    month,
    year,
    firstDateForComparision,
    currentMoment,
  ];
}

class RemoveSecondValue extends DatePickerEvent {
  final String secondDate;
  final int firstDateForComparision;
  final ETC currentMoment;
  const RemoveSecondValue(
    this.secondDate,
    this.firstDateForComparision,
    this.currentMoment,
  );
  @override
  List<Object?> get props => [
    secondDate,
    firstDateForComparision,
    currentMoment,
  ];
}

class RemoveSecondValueAfterBothAdded extends DatePickerEvent {
  final String secondDate;
  final int firstDateForComparision;
  final ETC currentMoment;
  const RemoveSecondValueAfterBothAdded(
    this.secondDate,
    this.firstDateForComparision,
    this.currentMoment,
  );
  @override
  List<Object?> get props => [
    secondDate,
    firstDateForComparision,
    currentMoment,
  ];
}
