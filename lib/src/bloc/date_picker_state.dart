import 'package:abushakir/abushakir.dart';
import 'package:equatable/equatable.dart';

/// Base class for all date picker states.
abstract class DatePickerState extends Equatable {
  /// The current moment being displayed in the calendar.
  final ETC currentMoment;
  const DatePickerState(this.currentMoment);
}

/// The initial state of the date picker.
class DatePickerInitial extends DatePickerState {
  const DatePickerInitial(super.currentMoment);
  @override
  List<Object> get props => [currentMoment];
}

/// State emitted when the first value (start date) is selected.
class SelectedFirstValueState extends DatePickerState {
  /// The numeric value of the selected day.
  final int firstNumber;
  const SelectedFirstValueState(super.currentMoment, this.firstNumber);
  @override
  List<Object> get props => [firstNumber];
}

/// State emitted when the second value (end date) is selected.
class SelectedSecondValueState extends DatePickerState {
  /// The numeric value of the selected day.
  final int secondValue;
  const SelectedSecondValueState(super.currentMoment, this.secondValue);
  @override
  List<Object> get props => [secondValue];
}

/// State emitted when a selection is removed.
class RemoveFirstValueState extends DatePickerState {
  /// The numeric value of the day being removed.
  final int firstNumber;
  const RemoveFirstValueState(super.currentMoment, this.firstNumber);
  @override
  List<Object> get props => [firstNumber];
}

/// State emitted when a month is changed.
class MonthsState extends DatePickerState {
  /// The new current month.
  final ETC currentMonth;
  const MonthsState(this.currentMonth) : super(currentMonth);
  @override
  List<Object> get props => [currentMonth];
}

/// State emitted when setting the day name.
class SetDayNameState extends DatePickerState {
  /// The name of the day.
  final String dayName;
  const SetDayNameState(super.currentMoment, this.dayName);
  @override
  List<Object?> get props => [dayName];
}

/// State emitted when the list of years is retrieved.
class GetYearsListState extends DatePickerState {
  /// The list of available years.
  final List yearsList;
  const GetYearsListState(super.currentMoment, this.yearsList);
  @override
  List<Object?> get props => [yearsList];
}

/// State emitted when a year is selected.
class SetSelectedIndexState extends DatePickerState {
  /// The list of years.
  final List yearsList;

  /// The index of the selected year.
  final int selectedIndex;

  /// The selected year.
  final int selectedYear;
  const SetSelectedIndexState(
    this.selectedYear,
    super.currentMoment,
    this.selectedIndex,
    this.yearsList,
  );
  @override
  List<Object?> get props => [yearsList, selectedIndex, selectedYear];
}

/// State emitted for single value selection.
class SingleValuesIndexState extends DatePickerState {
  /// The selected date string.
  final String singleDatesList;

  /// The date value for comparison.
  final int dateForComparsion;
  const SingleValuesIndexState(
    super.currentMoment,
    this.singleDatesList,
    this.dateForComparsion,
  );
  @override
  List<Object?> get props => [singleDatesList, dateForComparsion];
}

/// State emitted when a value is removed from the selection list.
class RemoveValueFromListState extends DatePickerState {
  /// The date string being removed.
  final String singleDatesList;

  /// The date value for comparison.
  final int dateForcomparsion;
  const RemoveValueFromListState(
    super.currentMoment,
    this.singleDatesList,
    this.dateForcomparsion,
  );
  @override
  List<Object?> get props => [singleDatesList, dateForcomparsion];
}

/// State emitted when the first date of a range is added.
class AddFirstValueState extends DatePickerState {
  /// Selected day.
  final int day;

  /// Selected month.
  final int month;

  /// Selected year.
  final int year;

  /// Formatted date string.
  final String firstDate;

  /// Numeric representation for comparison.
  final int firstDateForComparision;
  const AddFirstValueState(
    this.day,
    this.month,
    this.year,
    super.currentMoment,
    this.firstDate,
    this.firstDateForComparision,
  );
  @override
  List<Object?> get props => [
    day,
    month,
    year,
    firstDate,
    firstDateForComparision,
  ];
}

/// State emitted when a long tap first value is removed.
class RemoveLongTapFirstValueState extends DatePickerState {
  /// Formatted date string.
  final String firstDate;

  /// Numeric representation for comparison.
  final int firstDateForComparision;
  const RemoveLongTapFirstValueState(
    super.currentMoment,
    this.firstDate,
    this.firstDateForComparision,
  );
  @override
  List<Object?> get props => [firstDate, firstDateForComparision];
}

/// State emitted when the second date of a range is added.
class AddSecondValueState extends DatePickerState {
  /// Selected day.
  final int day;

  /// Selected month.
  final int month;

  /// Selected year.
  final int year;

  /// Formatted date string.
  final String secondDate;

  /// Numeric representation for comparison.
  final int firstDateForComparision;
  const AddSecondValueState(
    this.day,
    this.month,
    this.year,
    this.secondDate,
    this.firstDateForComparision,
    super.currentMoment,
  );
  @override
  List<Object?> get props => [
    day,
    month,
    year,
    secondDate,
    firstDateForComparision,
  ];
}

/// State emitted when a long tap second value is removed.
class RemoveLongTapSecondValueState extends DatePickerState {
  /// Formatted date string.
  final String secondDate;

  /// Numeric representation for comparison.
  final int secondDateForComparision;
  const RemoveLongTapSecondValueState(
    super.currentMoment,
    this.secondDate,
    this.secondDateForComparision,
  );
  @override
  List<Object?> get props => [secondDate, secondDateForComparision];
}

/// State emitted when a long tap second value is removed after both are added.
class RemoveLongTapSecondValueAfterState extends DatePickerState {
  /// Formatted date string.
  final String secondDate;

  /// Numeric representation for comparison.
  final int secondDateForComparision;
  const RemoveLongTapSecondValueAfterState(
    super.currentMoment,
    this.secondDate,
    this.secondDateForComparision,
  );
  @override
  List<Object?> get props => [secondDate, secondDateForComparision];
}
