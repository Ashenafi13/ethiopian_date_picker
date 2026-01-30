import 'package:abushakir/abushakir.dart';
import 'package:equatable/equatable.dart';

abstract class DatePickerState extends Equatable {
  final ETC currentMoment;
  const DatePickerState(this.currentMoment);
}

class DatePickerInitial extends DatePickerState {
  const DatePickerInitial(super.currentMoment);
  @override
  List<Object> get props => [currentMoment];
}

class SelectedFirstValueState extends DatePickerState {
  final int firstNumber;
  const SelectedFirstValueState(ETC moment, this.firstNumber) : super(moment);
  @override
  List<Object> get props => [firstNumber];
}

class SelectedSecondValueState extends DatePickerState {
  final int secondValue;
  const SelectedSecondValueState(ETC moment, this.secondValue) : super(moment);
  @override
  List<Object> get props => [secondValue];
}

class RemoveFirstValueState extends DatePickerState {
  final int firstNumber;
  const RemoveFirstValueState(ETC moment, this.firstNumber) : super(moment);
  @override
  List<Object> get props => [firstNumber];
}

class MonthsState extends DatePickerState {
  final ETC currentMonth;
  const MonthsState(this.currentMonth) : super(currentMonth);
  @override
  List<Object> get props => [currentMonth];
}

class SetDayNameState extends DatePickerState {
  final String dayName;
  const SetDayNameState(ETC moment, this.dayName) : super(moment);
  @override
  List<Object?> get props => [dayName];
}

class GetYearsListState extends DatePickerState {
  final List yearsList;
  const GetYearsListState(ETC moment, this.yearsList) : super(moment);
  @override
  List<Object?> get props => [yearsList];
}

class SetSelectedIndexState extends DatePickerState {
  final List yearsList;
  final int selectedIndex;
  final int selectedYear;
  const SetSelectedIndexState(
    this.selectedYear,
    ETC moment,
    this.selectedIndex,
    this.yearsList,
  ) : super(moment);
  @override
  List<Object?> get props => [yearsList, selectedIndex, selectedYear];
}

class SingleValuesIndexState extends DatePickerState {
  final String singleDatesList;
  final int dateForComparsion;
  const SingleValuesIndexState(
    ETC moment,
    this.singleDatesList,
    this.dateForComparsion,
  ) : super(moment);
  @override
  List<Object?> get props => [singleDatesList, dateForComparsion];
}

class RemoveValueFromListState extends DatePickerState {
  final String singleDatesList;
  final int dateForcomparsion;
  const RemoveValueFromListState(
    ETC currentMoment,
    this.singleDatesList,
    this.dateForcomparsion,
  ) : super(currentMoment);
  @override
  List<Object?> get props => [singleDatesList, dateForcomparsion];
}

class AddFirstValueState extends DatePickerState {
  final int day;
  final int month;
  final int year;
  final String firstDate;
  final int firstDateForComparision;
  const AddFirstValueState(
    this.day,
    this.month,
    this.year,
    ETC moment2,
    this.firstDate,
    this.firstDateForComparision,
  ) : super(moment2);
  @override
  List<Object?> get props => [
    day,
    month,
    year,
    firstDate,
    firstDateForComparision,
  ];
}

class RemoveLongTapFirstValueState extends DatePickerState {
  final String firstDate;
  final int firstDateForComparision;
  const RemoveLongTapFirstValueState(
    ETC moment2,
    this.firstDate,
    this.firstDateForComparision,
  ) : super(moment2);
  @override
  List<Object?> get props => [firstDate, firstDateForComparision];
}

class AddSecondValueState extends DatePickerState {
  final int day;
  final int month;
  final int year;
  final String secondDate;
  final int firstDateForComparision;
  const AddSecondValueState(
    this.day,
    this.month,
    this.year,
    this.secondDate,
    this.firstDateForComparision,
    ETC moment2,
  ) : super(moment2);
  @override
  List<Object?> get props => [
    day,
    month,
    year,
    secondDate,
    firstDateForComparision,
  ];
}

class RemoveLongTapSecondValueState extends DatePickerState {
  final String secondDate;
  final int secondDateForComparision;
  const RemoveLongTapSecondValueState(
    ETC moment2,
    this.secondDate,
    this.secondDateForComparision,
  ) : super(moment2);
  @override
  List<Object?> get props => [secondDate, secondDateForComparision];
}

class RemoveLongTapSecondValueAfterState extends DatePickerState {
  final String secondDate;
  final int secondDateForComparision;
  const RemoveLongTapSecondValueAfterState(
    ETC moment2,
    this.secondDate,
    this.secondDateForComparision,
  ) : super(moment2);
  @override
  List<Object?> get props => [secondDate, secondDateForComparision];
}
