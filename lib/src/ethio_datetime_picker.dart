import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abushakir/abushakir.dart';
import 'bloc/date_picker_bloc.dart';
import 'bloc/date_picker_event.dart';
import 'bloc/date_picker_state.dart';
import 'bloc/time_picker_bloc.dart';
import 'bloc/time_picker_event.dart';
import 'bloc/time_picker_state.dart';
import 'constants/date_picker_strings.dart';
import 'utils/date_picker_utils.dart';

/// A customizable Ethiopian DateTime Picker widget with 12-hour Ethiopian time.
///
/// Combines date selection with a modern 12-hour Ethiopian time picker
/// featuring smooth animations and an attractive UI.
class EthiopianDateTimePicker extends StatefulWidget {
  /// Whether to display the Gregorian calendar equivalent.
  final bool displayGregorianCalender;

  /// The language for the picker ('am' for Amharic, 'en' for English, 'ao' for Oromo).
  final String userLanguage;

  /// The background color for today's date in the grid.
  final Color todaysDateBackgroundColor;

  /// The start year for the year selection dropdown.
  final int startYear;

  /// The end year for the year selection dropdown.
  final int endYear;

  /// Whether to allow selection of dates in the past.
  final bool allowPastDates;

  /// Creates an [EthiopianDateTimePicker].
  const EthiopianDateTimePicker({
    super.key,
    required this.displayGregorianCalender,
    required this.userLanguage,
    required this.startYear,
    required this.endYear,
    required this.todaysDateBackgroundColor,
    this.allowPastDates = false,
  });

  @override
  State<EthiopianDateTimePicker> createState() =>
      _EthiopianDateTimePickerState();
}

class _EthiopianDateTimePickerState extends State<EthiopianDateTimePicker>
    with TickerProviderStateMixin {
  int? _selectedYear;
  int? _tappedDay;
  bool _showTimePicker = false;

  // Animation controllers
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  // Fixed scroll controllers for time wheels
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;

  // Modern solid color palette
  static const Color _primaryColor = Color(0xFF5B4CDB);
  static const Color _accentColor = Color(0xFF00C896);
  static const Color _headerColor = Color(0xFF1A1A2E);
  static const Color _surfaceColor = Color(0xFFF5F7FA);
  static const Color _cardColor = Color(0xFFFFFFFF);
  static const Color _selectedColor = Color(0xFF00C896);
  static const Color _todayColor = Color(0xFFFF6B6B);
  static const Color _morningColor = Color(0xFFFFB347);
  static const Color _eveningColor = Color(0xFF7B68EE);
  static const Color _textPrimary = Color(0xFF1A1A2E);
  static const Color _textSecondary = Color(0xFF6B7280);
  static const Color _textLight = Color(0xFFFFFFFF);

  @override
  void initState() {
    super.initState();
    _selectedYear = EtDatetime.now().year;

    // Initialize animation controllers
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );

    // Initialize scroll controllers
    final now = EthiopianTime.now();
    _hourController = FixedExtentScrollController(initialItem: now.hour - 1);
    _minuteController = FixedExtentScrollController(initialItem: now.minute);

    // Start animations
    _fadeController.forward();
    _slideController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DatePickerBloc()),
        BlocProvider(create: (_) => TimePickerBloc()),
      ],
      child: BlocBuilder<DatePickerBloc, DatePickerState>(
        builder: (context, dateState) {
          return BlocBuilder<TimePickerBloc, TimePickerState>(
            builder: (context, timeState) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _surfaceColor,
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: _primaryColor.withValues(alpha: 0.2),
                            blurRadius: 40,
                            offset: const Offset(0, 20),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildHeader(context, dateState, timeState),
                            AnimatedCrossFade(
                              duration: const Duration(milliseconds: 350),
                              crossFadeState: _showTimePicker
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              firstChild: _buildDatePicker(context, dateState),
                              secondChild: _buildTimePicker(context, timeState),
                              sizeCurve: Curves.easeInOut,
                            ),
                            _buildFooter(context, dateState, timeState),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    DatePickerState dateState,
    TimePickerState timeState,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_headerColor, Color(0xFF2D2D44)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          // Toggle between Date and Time
          _buildModeToggle(),
          const SizedBox(height: 20),
          // Date/Time display based on mode
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.1),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: _showTimePicker
                ? _buildTimeDisplay(timeState)
                : _buildDateDisplay(context, dateState),
          ),
        ],
      ),
    );
  }

  Widget _buildModeToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildToggleButton(
            icon: Icons.calendar_today_rounded,
            label: widget.userLanguage == 'am' ? 'ቀን' : 'Date',
            isActive: !_showTimePicker,
            onTap: () {
              HapticFeedback.lightImpact();
              setState(() => _showTimePicker = false);
            },
          ),
          const SizedBox(width: 4),
          _buildToggleButton(
            icon: Icons.access_time_rounded,
            label: widget.userLanguage == 'am' ? 'ሰዓት' : 'Time',
            isActive: _showTimePicker,
            onTap: () {
              HapticFeedback.lightImpact();
              setState(() => _showTimePicker = true);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? _accentColor : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: _accentColor.withValues(alpha: 0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? _textLight : _textLight.withValues(alpha: 0.6),
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isActive
                    ? _textLight
                    : _textLight.withValues(alpha: 0.6),
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateDisplay(BuildContext context, DatePickerState dateState) {
    return Column(
      key: const ValueKey('date-display'),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavButton(
              Icons.chevron_left_rounded,
              () => BlocProvider.of<DatePickerBloc>(
                context,
              ).add(PrevMonthCalendar(dateState.currentMoment)),
            ),
            Expanded(
              child: Text(
                returnDayAndMonthName(
                      '',
                      '',
                      dateState.currentMoment.monthName ?? '',
                      widget.userLanguage,
                      dateState.currentMoment.year.toString(),
                      true,
                    ) ??
                    '',
                style: const TextStyle(
                  color: _textLight,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            _buildNavButton(
              Icons.chevron_right_rounded,
              () => BlocProvider.of<DatePickerBloc>(
                context,
              ).add(NextMonthCalendar(dateState.currentMoment)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildYearSelector(context, dateState),
      ],
    );
  }

  Widget _buildTimeDisplay(TimePickerState timeState) {
    final hourStr = timeState.selectedHour.toString().padLeft(2, '0');
    final minuteStr = timeState.selectedMinute.toString().padLeft(2, '0');
    final periodColor = timeState.selectedPeriod == EthiopianTimePeriod.morning
        ? _morningColor
        : _eveningColor;

    return Column(
      key: const ValueKey('time-display'),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '$hourStr:$minuteStr',
              style: const TextStyle(
                color: _textLight,
                fontSize: 52,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: periodColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: periodColor.withValues(alpha: 0.5),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                _getPeriodLabel(timeState.selectedPeriod),
                style: const TextStyle(
                  color: _textLight,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          _getGregorianTimeLabel(timeState),
          style: TextStyle(
            color: _textLight.withValues(alpha: 0.7),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _getPeriodLabel(EthiopianTimePeriod period) {
    if (widget.userLanguage == 'am') {
      return period == EthiopianTimePeriod.morning
          ? EthiopianTimePickerStrings.morning
          : EthiopianTimePickerStrings.evening;
    } else if (widget.userLanguage == 'ao') {
      return period == EthiopianTimePeriod.morning
          ? OromoDatePickerStrings.morning
          : OromoDatePickerStrings.evening;
    }
    return period == EthiopianTimePeriod.morning
        ? EnglishTimePickerStrings.morning
        : EnglishTimePickerStrings.evening;
  }

  String _getGregorianTimeLabel(TimePickerState timeState) {
    final ethiopianTime = EthiopianTime(
      hour: timeState.selectedHour,
      minute: timeState.selectedMinute,
      period: timeState.selectedPeriod,
    );
    final gregorian = ethiopianTime.toGregorianTime();
    final hour = gregorian.hour;
    final minute = gregorian.minute.toString().padLeft(2, '0');
    final amPm = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    return '($displayHour:$minute $amPm Gregorian)';
  }

  Widget _buildNavButton(IconData icon, VoidCallback onPressed) {
    return Material(
      color: Colors.white.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          onPressed();
        },
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(14),
          child: Icon(icon, color: _textLight, size: 28),
        ),
      ),
    );
  }

  Widget _buildYearSelector(BuildContext context, DatePickerState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<int>(
        value: _selectedYear,
        dropdownColor: _headerColor,
        icon: const Icon(Icons.keyboard_arrow_down_rounded, color: _textLight),
        isExpanded: true,
        underline: const SizedBox(),
        style: const TextStyle(
          color: _textLight,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        onChanged: (int? newValue) {
          if (newValue != null) {
            HapticFeedback.selectionClick();
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

  Widget _buildDatePicker(BuildContext context, DatePickerState state) {
    return Column(
      children: [_buildWeekdayHeader(), _buildCalendarGrid(context, state)],
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
        : ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      color: _surfaceColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: weekdays
            .map(
              (day) => Expanded(
                child: Text(
                  day,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: _textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
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
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
          HapticFeedback.lightImpact();
          setState(() => _tappedDay = int.parse('$day$month$year'));
        }
      },
      onTapUp: (_) => setState(() => _tappedDay = null),
      onTapCancel: () => setState(() => _tappedDay = null),
      onTap: () {
        if (isDisabled) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                widget.userLanguage == 'am'
                    ? 'ያለፈ ቀን መምረጥ አይችሉም'
                    : 'Cannot select a past date',
              ),
              backgroundColor: _todayColor,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.all(16),
            ),
          );
          return;
        }

        HapticFeedback.mediumImpact();
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
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        transform: Matrix4.diagonal3Values(
          isTapped ? 0.85 : 1.0,
          isTapped ? 0.85 : 1.0,
          1.0,
        ),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? _selectedColor
              : isToday
              ? _todayColor
              : isDisabled
              ? Colors.grey.shade200
              : _cardColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: isSelected || isToday
              ? [
                  BoxShadow(
                    color: (isSelected ? _selectedColor : _todayColor)
                        .withValues(alpha: 0.45),
                    blurRadius: 14,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Center(
          child: Text(
            '$day',
            style: TextStyle(
              color: isSelected || isToday
                  ? _textLight
                  : isDisabled
                  ? _textSecondary.withValues(alpha: 0.5)
                  : _textPrimary,
              fontSize: 16,
              fontWeight: isSelected || isToday
                  ? FontWeight.w800
                  : FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimePicker(BuildContext context, TimePickerState timeState) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      color: _surfaceColor,
      child: Column(
        children: [
          // Period selector
          _buildPeriodSelector(context, timeState),
          const SizedBox(height: 28),
          // Time wheels
          SizedBox(
            height: 180,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Hour wheel
                _buildTimeWheel(
                  context: context,
                  controller: _hourController,
                  itemCount: 12,
                  itemBuilder: (index) => '${index + 1}'.padLeft(2, '0'),
                  onChanged: (index) {
                    HapticFeedback.selectionClick();
                    BlocProvider.of<TimePickerBloc>(context).add(
                      HourChanged(
                        hour: index + 1,
                        currentMinute: timeState.selectedMinute,
                        currentPeriod: timeState.selectedPeriod,
                      ),
                    );
                  },
                  label: widget.userLanguage == 'am'
                      ? EthiopianTimePickerStrings.hour
                      : EnglishTimePickerStrings.hour,
                ),
                // Colon separator
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    ':',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w800,
                      color: _primaryColor,
                    ),
                  ),
                ),
                // Minute wheel
                _buildTimeWheel(
                  context: context,
                  controller: _minuteController,
                  itemCount: 60,
                  itemBuilder: (index) => index.toString().padLeft(2, '0'),
                  onChanged: (index) {
                    HapticFeedback.selectionClick();
                    BlocProvider.of<TimePickerBloc>(context).add(
                      MinuteChanged(
                        minute: index,
                        currentHour: timeState.selectedHour,
                        currentPeriod: timeState.selectedPeriod,
                      ),
                    );
                  },
                  label: widget.userLanguage == 'am'
                      ? EthiopianTimePickerStrings.minute
                      : EnglishTimePickerStrings.minute,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector(BuildContext context, TimePickerState timeState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: _buildPeriodButton(
            context: context,
            period: EthiopianTimePeriod.morning,
            isSelected: timeState.selectedPeriod == EthiopianTimePeriod.morning,
            color: _morningColor,
            icon: Icons.wb_sunny_rounded,
            timeState: timeState,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildPeriodButton(
            context: context,
            period: EthiopianTimePeriod.evening,
            isSelected: timeState.selectedPeriod == EthiopianTimePeriod.evening,
            color: _eveningColor,
            icon: Icons.nightlight_round,
            timeState: timeState,
          ),
        ),
      ],
    );
  }

  Widget _buildPeriodButton({
    required BuildContext context,
    required EthiopianTimePeriod period,
    required bool isSelected,
    required Color color,
    required IconData icon,
    required TimePickerState timeState,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        BlocProvider.of<TimePickerBloc>(context).add(
          PeriodChanged(
            period: period,
            currentHour: timeState.selectedHour,
            currentMinute: timeState.selectedMinute,
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color : _cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.45),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? _textLight : color, size: 20),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                _getPeriodLabel(period),
                style: TextStyle(
                  color: isSelected ? _textLight : _textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeWheel({
    required BuildContext context,
    required FixedExtentScrollController controller,
    required int itemCount,
    required String Function(int) itemBuilder,
    required ValueChanged<int> onChanged,
    required String label,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: _textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 80,
          height: 150,
          child: Stack(
            children: [
              // Selection highlight
              Positioned.fill(
                child: Center(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: _primaryColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: _primaryColor.withValues(alpha: 0.3),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              // Wheel
              ListWheelScrollView.useDelegate(
                controller: controller,
                itemExtent: 50,
                perspective: 0.005,
                diameterRatio: 1.2,
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: onChanged,
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: itemCount,
                  builder: (context, index) {
                    return Center(
                      child: Text(
                        itemBuilder(index),
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: _textPrimary,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(
    BuildContext context,
    DatePickerState dateState,
    TimePickerState timeState,
  ) {
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
                HapticFeedback.mediumImpact();
                final result = _buildResult(dateState, timeState);
                Navigator.pop(context, result);
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
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: isPrimary
                ? null
                : Border.all(color: Colors.grey.shade300, width: 2),
            boxShadow: isPrimary
                ? [
                    BoxShadow(
                      color: _primaryColor.withValues(alpha: 0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : null,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isPrimary ? _textLight : _textSecondary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
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

  Map<String, dynamic> _buildResult(
    DatePickerState dateState,
    TimePickerState timeState,
  ) {
    // Get selected date
    String selectedDate;
    if (dateState is AddFirstValueState) {
      selectedDate = dateState.firstDate;
    } else if (dateState is AddSecondValueState) {
      selectedDate = dateState.secondDate;
    } else if (dateState is SingleValuesIndexState) {
      selectedDate = dateState.singleDatesList;
    } else {
      final now = EtDatetime.now();
      selectedDate = '${now.day}-${now.month}-${now.year}';
    }

    // Get selected time
    final ethiopianTime = EthiopianTime(
      hour: timeState.selectedHour,
      minute: timeState.selectedMinute,
      period: timeState.selectedPeriod,
    );

    return {
      'date': selectedDate,
      'ethiopianTime': ethiopianTime.format(language: widget.userLanguage),
      'gregorianTime': _getGregorianTimeLabel(
        timeState,
      ).replaceAll(RegExp(r'[()]'), ''),
      'hour': timeState.selectedHour,
      'minute': timeState.selectedMinute,
      'period': timeState.selectedPeriod == EthiopianTimePeriod.morning
          ? 'morning'
          : 'evening',
    };
  }
}
