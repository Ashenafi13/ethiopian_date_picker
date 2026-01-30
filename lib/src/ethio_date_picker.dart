import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abushakir/abushakir.dart';
import 'bloc/date_picker_bloc.dart';
import 'bloc/date_picker_event.dart';
import 'bloc/date_picker_state.dart';
import 'constants/date_picker_strings.dart';

class EthiopianDatePicker extends StatefulWidget {
  final bool displayGregorianCalender;
  final String userLanguage;
  final Color todaysDateBackgroundColor;
  final int startYear;
  final int endYear;
  final bool allowPastDates;

  const EthiopianDatePicker({
    Key? key,
    required this.displayGregorianCalender,
    required this.userLanguage,
    required this.startYear,
    required this.endYear,
    required this.todaysDateBackgroundColor,
    this.allowPastDates = false,
  }) : super(key: key);

  @override
  _EthiopianDatePickerState createState() => _EthiopianDatePickerState();
}

class _EthiopianDatePickerState extends State<EthiopianDatePicker>
    with SingleTickerProviderStateMixin {
  int? _selectedYear;
  int? _tappedDay;

  // Modern color palette
  static const Color _primaryColor = Color(0xFF6C63FF);
  static const Color _headerColor = Color(0xFF1E1E2E);
  static const Color _surfaceColor = Color(0xFFF8F9FA);
  static const Color _selectedColor = Color(0xFF00BFA6);
  static const Color _todayColor = Color(0xFFFF6B6B);
  static const Color _textPrimary = Color(0xFF2D3436);
  static const Color _textSecondary = Color(0xFF636E72);

  @override
  void initState() {
    super.initState();
    _selectedYear = EtDatetime.now().year;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DatePickerBloc(),
      child: BlocConsumer<DatePickerBloc, DatePickerState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              color: _surfaceColor,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
                BoxShadow(
                  color: _primaryColor.withOpacity(0.1),
                  blurRadius: 60,
                  offset: const Offset(0, 30),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(context, state),
                  _buildWeekdayHeader(),
                  _buildCalendarGrid(context, state),
                  _buildFooter(context, state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, DatePickerState state) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      decoration: const BoxDecoration(color: _headerColor),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavButton(
                Icons.chevron_left_rounded,
                () => BlocProvider.of<DatePickerBloc>(
                  context,
                ).add(PrevMonthCalendar(state.currentMoment)),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      state.currentMoment.monthName ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${state.currentMoment.year}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              _buildNavButton(
                Icons.chevron_right_rounded,
                () => BlocProvider.of<DatePickerBloc>(
                  context,
                ).add(NextMonthCalendar(state.currentMoment)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildYearSelector(context, state),
        ],
      ),
    );
  }

  Widget _buildNavButton(IconData icon, VoidCallback onPressed) {
    return Material(
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
      ),
    );
  }

  Widget _buildYearSelector(BuildContext context, DatePickerState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<int>(
        value: _selectedYear,
        dropdownColor: _headerColor,
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Colors.white,
        ),
        isExpanded: true,
        underline: const SizedBox(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        onChanged: (int? newValue) {
          if (newValue != null) {
            setState(() => _selectedYear = newValue);
            BlocProvider.of<DatePickerBloc>(
              context,
            ).add(CalenderByYear(state.currentMoment, newValue));
          }
        },
        items: List.generate(
          widget.endYear - widget.startYear + 1,
          (index) => DropdownMenuItem<int>(
            value: widget.startYear + index,
            child: Text('${widget.startYear + index}'),
          ),
        ),
      ),
    );
  }

  Widget _buildWeekdayHeader() {
    final List<String> weekdays = widget.userLanguage == 'am'
        ? [
            EthiopianDatePickerStrings.shortSunday,
            EthiopianDatePickerStrings.shortMonday,
            EthiopianDatePickerStrings.shortTuesday,
            EthiopianDatePickerStrings.shortWednesday,
            EthiopianDatePickerStrings.shortThursday,
            EthiopianDatePickerStrings.shortFriday,
            EthiopianDatePickerStrings.shortSaturday,
          ]
        : ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      color: _surfaceColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: weekdays
            .map(
              (day) => SizedBox(
                width: 40,
                child: Text(
                  day,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: _textSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildCalendarGrid(BuildContext context, DatePickerState state) {
    final monthDaysList = state.currentMoment.monthDays().toList();
    if (monthDaysList.isEmpty || monthDaysList[0].length < 4) {
      return const SizedBox(height: 200);
    }

    final paddingDays = (monthDaysList[0][3] as num).toInt();

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      color: _surfaceColor,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        itemCount: monthDaysList.length + paddingDays,
        itemBuilder: (context, index) {
          if (index < paddingDays) {
            return const SizedBox();
          }

          final dayIndex = index - paddingDays;
          final day = (monthDaysList[dayIndex][2] as num).toInt();
          final month = (monthDaysList[dayIndex][1] as num).toInt();
          final year = (monthDaysList[dayIndex][0] as num).toInt();

          final isSelected = _isDateSelected(state, day, month, year);
          final now = EtDatetime.now();
          final isToday =
              day == now.day && month == now.month && year == now.year;
          final isPast = EtDatetime(
            year: year,
            month: month,
            day: day,
          ).isBefore(now);

          return _buildDateCell(
            context,
            state,
            day,
            month,
            year,
            isSelected,
            isToday,
            isPast,
          );
        },
      ),
    );
  }

  Widget _buildDateCell(
    BuildContext context,
    DatePickerState state,
    int day,
    int month,
    int year,
    bool isSelected,
    bool isToday,
    bool isPast,
  ) {
    final isDisabled = !widget.allowPastDates && isPast && !isToday;
    final isTapped = _tappedDay == int.parse('$day$month$year');

    return GestureDetector(
      onTapDown: (_) {
        if (!isDisabled) {
          setState(() => _tappedDay = int.parse('$day$month$year'));
        }
      },
      onTapUp: (_) {
        setState(() => _tappedDay = null);
      },
      onTapCancel: () {
        setState(() => _tappedDay = null);
      },
      onTap: () {
        if (isDisabled) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Cannot select a past date'),
              backgroundColor: _todayColor,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(16),
            ),
          );
          return;
        }

        if (isSelected) {
          BlocProvider.of<DatePickerBloc>(context).add(
            RemoveItemFromList(
              '$day-$month-$year',
              state.currentMoment,
              int.parse('$day$month$year'),
            ),
          );
        } else {
          BlocProvider.of<DatePickerBloc>(context).add(
            AddSingleValues(
              '$day-$month-$year',
              state.currentMoment,
              int.parse('$day$month$year'),
            ),
          );
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..scale(isTapped ? 0.9 : 1.0),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? _selectedColor
              : isToday
              ? _todayColor
              : isDisabled
              ? Colors.grey.shade200
              : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: isToday && !isSelected
              ? Border.all(color: _todayColor, width: 2)
              : null,
          boxShadow: isSelected || isToday
              ? [
                  BoxShadow(
                    color: (isSelected ? _selectedColor : _todayColor)
                        .withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Center(
          child: Text(
            '$day',
            style: TextStyle(
              color: isSelected || (isToday && !isDisabled)
                  ? Colors.white
                  : isDisabled
                  ? _textSecondary.withOpacity(0.5)
                  : _textPrimary,
              fontSize: 16,
              fontWeight: isSelected || isToday
                  ? FontWeight.w700
                  : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context, DatePickerState state) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _surfaceColor,
        border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildFooterButton(
              widget.userLanguage == 'am'
                  ? EthiopianDatePickerStrings.cancel
                  : 'Cancel',
              onPressed: () => Navigator.pop(context),
              isPrimary: false,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildFooterButton(
              widget.userLanguage == 'am'
                  ? EthiopianDatePickerStrings.okay
                  : 'Confirm',
              onPressed: () {
                List<String> selectedDates = _getSelectedDates(state);
                if (selectedDates.isEmpty) {
                  final now = EtDatetime.now();
                  selectedDates.add('${now.day}-${now.month}-${now.year}');
                }
                Navigator.pop(context, selectedDates);
              },
              isPrimary: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterButton(
    String text, {
    required VoidCallback onPressed,
    required bool isPrimary,
  }) {
    return Material(
      color: isPrimary ? _primaryColor : Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: isPrimary
                ? null
                : Border.all(color: Colors.grey.shade300, width: 1.5),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isPrimary ? Colors.white : _textSecondary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  bool _isDateSelected(DatePickerState state, int day, int month, int year) {
    final dateString = '$day-$month-$year';
    if (state is AddFirstValueState && state.firstDate == dateString) {
      return true;
    }
    if (state is AddSecondValueState && state.secondDate == dateString) {
      return true;
    }
    if (state is SingleValuesIndexState &&
        state.singleDatesList == dateString) {
      return true;
    }
    return false;
  }

  List<String> _getSelectedDates(DatePickerState state) {
    final selectedDates = <String>[];
    if (state is AddFirstValueState) selectedDates.add(state.firstDate);
    if (state is AddSecondValueState) selectedDates.add(state.secondDate);
    if (state is SingleValuesIndexState) {
      selectedDates.add(state.singleDatesList);
    }
    return selectedDates;
  }
}
