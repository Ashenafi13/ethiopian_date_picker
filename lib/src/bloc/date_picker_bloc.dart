import 'package:abushakir/abushakir.dart';
import '../utils/date_picker_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/date_picker_strings.dart';
import '../bloc/date_picker_event.dart';
import '../bloc/date_picker_state.dart';

class DatePickerBloc extends Bloc<DatePickerEvent, DatePickerState> {
  DatePickerBloc() : super(DatePickerInitial(ETC.today())) {
    on<AlertIntialEvent>((event, emit) {
      emit(DatePickerInitial(ETC.today()));
    });
    on<RemoveSecondValueAfterBothAdded>((event, emit) {
      _removeSecondValueAfterBoth(event, emit);
    });
    on<RemoveSecondValue>((event, emit) {
      _removeSecondValue(event, emit);
    });
    on<AddSecondValue>((event, emit) {
      _addSecondValue(event, emit);
    });
    on<RemoveInitialValue>((event, emit) {
      _removeInitialValue(event, emit);
    });
    on<AddInitialValue>((event, emit) {
      _addInitialValue(event, emit);
    });
    on<RemoveItemFromList>((event, emit) {
      _removeValueFromList(event, emit);
    });
    on<AddSingleValues>((event, emit) {
      _addSingleValuesToList(event, emit);
    });
    on<GetSelectedIndex>((event, emit) {
      _getSelectedIndex(event, emit);
    });
    on<GetYearList>((event, emit) {
      _getYearsList(event, emit);
    });
    on<GetDayName>((event, emit) {
      _getDayName(event, emit, ETC.today());
    });
    on<NextMonthCalendar>((event, emit) {
      _getNextMonth(event, emit);
    });
    on<PrevMonthCalendar>((event, emit) {
      _getPreviousMonth(event, emit);
    });
    on<CalenderByYear>((event, emit) {
      _getCalenderByYear(event, emit);
    });
    on<NextYearCalendar>((event, emit) {
      _getNextYear(event, emit);
    });
    on<PrevYearCalendar>((event, emit) {
      _getPreviousYear(event, emit);
    });
  }

  void _getNextMonth(NextMonthCalendar event, Emitter<DatePickerState> emit) {
    emit(MonthsState(event.currentMonth.nextMonth));
  }

  void _getPreviousMonth(
    PrevMonthCalendar event,
    Emitter<DatePickerState> emit,
  ) {
    emit(MonthsState(event.currentMonth.prevMonth));
  }

  void _getCalenderByYear(CalenderByYear event, Emitter<DatePickerState> emit) {
    emit(MonthsState(getCalenderSpecificYear(event.year)));
  }

  void _getNextYear(NextYearCalendar event, Emitter<DatePickerState> emit) {}

  void _getPreviousYear(
    PrevYearCalendar event,
    Emitter<DatePickerState> emit,
  ) {}

  void _getDayName(
    GetDayName event,
    Emitter<DatePickerState> emit,
    ETC currentMoment,
  ) {
    if ((event.dayIndex % event.crossAxisCount) + 1 == 1) {
      if (event.userLanguage == "am") {
        emit(SetDayNameState(currentMoment, EthiopianDatePickerStrings.monday));
      } else if (event.userLanguage == "ao") {
        emit(SetDayNameState(currentMoment, OromoDatePickerStrings.monday));
      } else {
        emit(SetDayNameState(currentMoment, EnglishDatePickerStrings.monday));
      }
    } else if ((event.dayIndex % event.crossAxisCount) + 1 == 2) {
      if (event.userLanguage == "am") {
        emit(
          SetDayNameState(currentMoment, EthiopianDatePickerStrings.tuesday),
        );
      } else if (event.userLanguage == "ao") {
        emit(SetDayNameState(currentMoment, OromoDatePickerStrings.tuesday));
      } else {
        emit(SetDayNameState(currentMoment, EnglishDatePickerStrings.tuesday));
      }
    } else if ((event.dayIndex % event.crossAxisCount) + 1 == 3) {
      if (event.userLanguage == "am") {
        emit(
          SetDayNameState(currentMoment, EthiopianDatePickerStrings.wednesday),
        );
      } else if (event.userLanguage == "ao") {
        emit(SetDayNameState(currentMoment, OromoDatePickerStrings.wednesday));
      } else {
        emit(
          SetDayNameState(currentMoment, EnglishDatePickerStrings.wednesday),
        );
      }
    } else if ((event.dayIndex % event.crossAxisCount) + 1 == 4) {
      if (event.userLanguage == "am") {
        emit(
          SetDayNameState(currentMoment, EthiopianDatePickerStrings.thursday),
        );
      } else if (event.userLanguage == "ao") {
        emit(SetDayNameState(currentMoment, OromoDatePickerStrings.thursday));
      } else {
        emit(SetDayNameState(currentMoment, EnglishDatePickerStrings.thursday));
      }
    } else if ((event.dayIndex % event.crossAxisCount) + 1 == 5) {
      if (event.userLanguage == "am") {
        emit(SetDayNameState(currentMoment, EthiopianDatePickerStrings.friday));
      } else if (event.userLanguage == "ao") {
        emit(SetDayNameState(currentMoment, OromoDatePickerStrings.friday));
      } else {
        emit(SetDayNameState(currentMoment, EnglishDatePickerStrings.friday));
      }
    } else if ((event.dayIndex % event.crossAxisCount) + 1 == 6) {
      if (event.userLanguage == "am") {
        emit(
          SetDayNameState(currentMoment, EthiopianDatePickerStrings.saturday),
        );
      } else if (event.userLanguage == "ao") {
        emit(SetDayNameState(currentMoment, OromoDatePickerStrings.saturday));
      } else {
        emit(SetDayNameState(currentMoment, EnglishDatePickerStrings.saturday));
      }
    } else if ((event.dayIndex % event.crossAxisCount) + 1 == 7) {
      if (event.userLanguage == "am") {
        emit(SetDayNameState(currentMoment, EthiopianDatePickerStrings.sunday));
      } else if (event.userLanguage == "ao") {
        emit(SetDayNameState(currentMoment, OromoDatePickerStrings.sunday));
      } else {
        emit(SetDayNameState(currentMoment, EnglishDatePickerStrings.sunday));
      }
    }
  }

  void _getYearsList(GetYearList event, Emitter<DatePickerState> emit) {
    List yearsList = [];
    for (int i = event.startYear; i <= event.endYear; i++) {
      yearsList.add(i);
    }
    emit(GetYearsListState(ETC.today(), yearsList));
  }

  void _getSelectedIndex(
    GetSelectedIndex event,
    Emitter<DatePickerState> emit,
  ) {
    List yearsList = [];
    for (int i = event.startYear; i <= event.endYear; i++) {
      yearsList.add(i);
    }
    emit(
      SetSelectedIndexState(
        event.selectedYear,
        ETC.today(),
        event.selectedIndex,
        yearsList,
      ),
    );
  }

  void _addSingleValuesToList(
    AddSingleValues event,
    Emitter<DatePickerState> emit,
  ) {
    emit(
      SingleValuesIndexState(
        event.currentMoment,
        event.singleDate,
        event.dateForComparision,
      ),
    );
  }

  void _removeValueFromList(
    RemoveItemFromList event,
    Emitter<DatePickerState> emit,
  ) {
    emit(
      RemoveValueFromListState(
        event.currentMoment,
        event.singleDate,
        event.dateForComparision,
      ),
    );
  }

  void _addInitialValue(AddInitialValue event, Emitter<DatePickerState> emit) {
    emit(
      AddFirstValueState(
        event.day,
        event.month,
        event.year,
        event.currentMoment,
        event.firstDate,
        event.firstDateForComparision,
      ),
    );
  }

  void _removeInitialValue(
    RemoveInitialValue event,
    Emitter<DatePickerState> emit,
  ) {
    emit(
      RemoveLongTapFirstValueState(
        event.currentMoment,
        event.firstDate,
        event.firstDateForComparision,
      ),
    );
  }

  void _removeSecondValue(
    RemoveSecondValue event,
    Emitter<DatePickerState> emit,
  ) {
    emit(
      RemoveLongTapSecondValueState(
        event.currentMoment,
        event.secondDate,
        event.firstDateForComparision,
      ),
    );
  }

  void _addSecondValue(AddSecondValue event, Emitter<DatePickerState> emit) {
    emit(
      AddSecondValueState(
        event.day,
        event.month,
        event.year,
        event.secondDate,
        event.firstDateForComparision,
        event.currentMoment,
      ),
    );
  }

  void _removeSecondValueAfterBoth(
    RemoveSecondValueAfterBothAdded event,
    Emitter<DatePickerState> emit,
  ) {
    emit(
      RemoveLongTapSecondValueAfterState(
        event.currentMoment,
        event.secondDate,
        event.firstDateForComparision,
      ),
    );
  }
}
