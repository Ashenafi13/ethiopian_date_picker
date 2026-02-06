import 'package:abushakir/abushakir.dart';
import '../constants/date_picker_strings.dart';

/// contains constant functions for our library

String ethiopianToGregorianDateConvertor(
  int day,
  ETC ethiopianCalender,
  bool forCalender,
) {
  /// this function will be called when we want to display
  /// gregorian calender with ethiopian calender
  /// it takes ethiopian calender and date as a param and returns gregorian calender
  EtDatetime ethiopianDateTime = EtDatetime(
    year: ethiopianCalender.year,
    month: ethiopianCalender.month,
    day: day,
  );
  DateTime gregorianCalender = DateTime.fromMillisecondsSinceEpoch(
    ethiopianDateTime.moment,
  );
  String result = gregorianCalender.toString().substring(
    0,
    gregorianCalender.toString().indexOf(' '),
  );
  var gregorianConvertedDate = result.split('-');
  return forCalender
      ? gregorianConvertedDate[2].toString().replaceAll(RegExp(r'^0+(?=.)'), '')
      : result;
}

String? returnDayAndMonthName(
  String dayname,
  String currentDate,
  String monthname,
  String userLanguage,
  String year,
  bool isMonthTitle,
) {
  String dayName = '';
  String monthn = '';
  Map<String, Map<String, String>> translations = {
    'am': {
      EnglishDatePickerStrings.monday: EthiopianDatePickerStrings.monday,
      EnglishDatePickerStrings.tuesday: EthiopianDatePickerStrings.tuesday,
      EnglishDatePickerStrings.wednesday: EthiopianDatePickerStrings.wednesday,
      EnglishDatePickerStrings.thursday: EthiopianDatePickerStrings.thursday,
      EnglishDatePickerStrings.friday: EthiopianDatePickerStrings.friday,
      EnglishDatePickerStrings.saturday: EthiopianDatePickerStrings.saturday,
      EnglishDatePickerStrings.sunday: EthiopianDatePickerStrings.sunday,
    },
    'ao': {
      EnglishDatePickerStrings.monday: OromoDatePickerStrings.monday,
      EnglishDatePickerStrings.tuesday: OromoDatePickerStrings.tuesday,
      EnglishDatePickerStrings.wednesday: OromoDatePickerStrings.wednesday,
      EnglishDatePickerStrings.thursday: OromoDatePickerStrings.thursday,
      EnglishDatePickerStrings.friday: OromoDatePickerStrings.friday,
      EnglishDatePickerStrings.saturday: OromoDatePickerStrings.saturday,
      EnglishDatePickerStrings.sunday: OromoDatePickerStrings.sunday,
    },
  };

  Map<String, Map<String, String>> months = {
    'en': {
      EthiopianDatePickerStrings.jan: EnglishDatePickerStrings.jan,
      EthiopianDatePickerStrings.feb: EnglishDatePickerStrings.feb,
      EthiopianDatePickerStrings.mar: EnglishDatePickerStrings.mar,
      EthiopianDatePickerStrings.apr: EnglishDatePickerStrings.apr,
      EthiopianDatePickerStrings.may: EnglishDatePickerStrings.may,
      EthiopianDatePickerStrings.jun: EnglishDatePickerStrings.jun,
      EthiopianDatePickerStrings.jul: EnglishDatePickerStrings.jul,
      EthiopianDatePickerStrings.aug: EnglishDatePickerStrings.aug,
      EthiopianDatePickerStrings.sep: EnglishDatePickerStrings.sep,
      EthiopianDatePickerStrings.oct: EnglishDatePickerStrings.oct,
      EthiopianDatePickerStrings.nov: EnglishDatePickerStrings.nov,
      EthiopianDatePickerStrings.dec: EnglishDatePickerStrings.dec,
      EthiopianDatePickerStrings.pag: EnglishDatePickerStrings.sep,
    },
    'am': {
      EthiopianDatePickerStrings.jan: EthiopianDatePickerStrings.jan,
      EthiopianDatePickerStrings.feb: EthiopianDatePickerStrings.feb,
      EthiopianDatePickerStrings.mar: EthiopianDatePickerStrings.mar,
      EthiopianDatePickerStrings.apr: EthiopianDatePickerStrings.apr,
      EthiopianDatePickerStrings.may: EthiopianDatePickerStrings.may,
      EthiopianDatePickerStrings.jun: EthiopianDatePickerStrings.jun,
      EthiopianDatePickerStrings.jul: EthiopianDatePickerStrings.jul,
      EthiopianDatePickerStrings.aug: EthiopianDatePickerStrings.aug,
      EthiopianDatePickerStrings.sep: EthiopianDatePickerStrings.sep,
      EthiopianDatePickerStrings.oct: EthiopianDatePickerStrings.oct,
      EthiopianDatePickerStrings.nov: EthiopianDatePickerStrings.nov,
      EthiopianDatePickerStrings.dec: EthiopianDatePickerStrings.dec,
      EthiopianDatePickerStrings.pag: EthiopianDatePickerStrings.pag,
    },
    'ao': {
      EthiopianDatePickerStrings.jan: OromoDatePickerStrings.jan,
      EthiopianDatePickerStrings.feb: OromoDatePickerStrings.feb,
      EthiopianDatePickerStrings.mar: OromoDatePickerStrings.mar,
      EthiopianDatePickerStrings.apr: OromoDatePickerStrings.apr,
      EthiopianDatePickerStrings.may: OromoDatePickerStrings.may,
      EthiopianDatePickerStrings.jun: OromoDatePickerStrings.jun,
      EthiopianDatePickerStrings.jul: OromoDatePickerStrings.jul,
      EthiopianDatePickerStrings.aug: OromoDatePickerStrings.aug,
      EthiopianDatePickerStrings.sep: OromoDatePickerStrings.sep,
      EthiopianDatePickerStrings.oct: OromoDatePickerStrings.oct,
      EthiopianDatePickerStrings.nov: OromoDatePickerStrings.nov,
      EthiopianDatePickerStrings.dec: OromoDatePickerStrings.dec,
      EthiopianDatePickerStrings.pag: OromoDatePickerStrings.pag,
    },
  };

  if (translations.containsKey(userLanguage)) {
    final languageTranslations = translations[userLanguage];
    if (languageTranslations!.containsKey(dayname)) {
      dayName = languageTranslations[dayname]!;
    }
  }
  if (months.containsKey(userLanguage)) {
    final mNames = months[userLanguage];
    if (mNames!.containsKey(monthname)) {
      monthn = mNames[monthname]!;
    }
  }

  return isMonthTitle ? '$monthn $year' : '$monthn $dayName $currentDate $year';
}

String? returnAbrivateWeekNames(String weekName, String userLanguage) {
  String shortendName = '';
  Map<String, Map<String, String>> weekdnames = {
    'am': {
      EthiopianDatePickerStrings.shortMonday:
          EthiopianDatePickerStrings.shortMonday,
      EthiopianDatePickerStrings.shortTuesday:
          EthiopianDatePickerStrings.shortTuesday,
      EthiopianDatePickerStrings.shortWednesday:
          EthiopianDatePickerStrings.shortWednesday,
      EthiopianDatePickerStrings.shortThursday:
          EthiopianDatePickerStrings.shortThursday,
      EthiopianDatePickerStrings.shortFriday:
          EthiopianDatePickerStrings.shortFriday,
      EthiopianDatePickerStrings.shortSaturday:
          EthiopianDatePickerStrings.shortSaturday,
      EthiopianDatePickerStrings.shortSunday:
          EthiopianDatePickerStrings.shortSunday,
    },
    'en': {
      EthiopianDatePickerStrings.shortMonday:
          EnglishDatePickerStrings.shortMonday,
      EthiopianDatePickerStrings.shortTuesday:
          EnglishDatePickerStrings.shortTuesday,
      EthiopianDatePickerStrings.shortWednesday:
          EnglishDatePickerStrings.shortWednesday,
      EthiopianDatePickerStrings.shortThursday:
          EnglishDatePickerStrings.shortThursday,
      EthiopianDatePickerStrings.shortFriday:
          EnglishDatePickerStrings.shortFriday,
      EthiopianDatePickerStrings.shortSaturday:
          EnglishDatePickerStrings.shortSaturday,
      EthiopianDatePickerStrings.shortSunday:
          EnglishDatePickerStrings.shortSunday,
    },
    'ao': {
      EthiopianDatePickerStrings.shortMonday:
          OromoDatePickerStrings.shortMonday,
      EthiopianDatePickerStrings.shortTuesday:
          OromoDatePickerStrings.shortTuesday,
      EthiopianDatePickerStrings.shortWednesday:
          OromoDatePickerStrings.shortWednesday,
      EthiopianDatePickerStrings.shortThursday:
          OromoDatePickerStrings.shortThursday,
      EthiopianDatePickerStrings.shortFriday:
          OromoDatePickerStrings.shortFriday,
      EthiopianDatePickerStrings.shortSaturday:
          OromoDatePickerStrings.shortSaturday,
      EthiopianDatePickerStrings.shortSunday:
          OromoDatePickerStrings.shortSunday,
    },
  };

  if (weekdnames.containsKey(userLanguage)) {
    final languageTranslations = weekdnames[userLanguage];
    if (languageTranslations!.containsKey(weekName)) {
      shortendName = languageTranslations[weekName]!;
    }
  }

  return shortendName;
}

ETC getCalenderSpecificYear(int val) {
  final EtDatetime date;
  date = EtDatetime.now();
  return ETC(year: val, month: date.month);
}

/// Ethiopian time period enum (4 periods)
enum EthiopianTimePeriod {
  morning, // ጠዋት (Ethiopian 12:00 - 5:59 = Gregorian 6:00 AM - 11:59 AM)
  afternoon, // ከሰአት (Ethiopian 6:00 - 11:59 = Gregorian 12:00 PM - 5:59 PM)
  evening, // ማታ (Ethiopian 12:00 - 5:59 = Gregorian 6:00 PM - 11:59 PM)
  night, // ሌሊት (Ethiopian 6:00 - 11:59 = Gregorian 12:00 AM - 5:59 AM)
}

/// Represents Ethiopian time in 12-hour format with 4 periods
class EthiopianTime {
  final int hour; // 1-12
  final int minute; // 0-59
  final EthiopianTimePeriod period;

  const EthiopianTime({
    required this.hour,
    required this.minute,
    required this.period,
  });

  /// Convert to Gregorian DateTime (only time portion)
  DateTime toGregorianTime() {
    int gregorianHour;
    int ethiopianHour = hour == 12 ? 0 : hour;

    // Ethiopian time mapping:
    // ጠዋት (morning): Ethiopian 12:00-5:59 = Gregorian 6:00 AM - 11:59 AM
    // ከሰአት (afternoon): Ethiopian 6:00-11:59 = Gregorian 12:00 PM - 5:59 PM
    // ማታ (evening): Ethiopian 12:00-5:59 = Gregorian 6:00 PM - 11:59 PM
    // ሌሊት (night): Ethiopian 6:00-11:59 = Gregorian 12:00 AM - 5:59 AM

    switch (period) {
      case EthiopianTimePeriod.morning:
        // Ethiopian 12:00-5:59 → Gregorian 6:00-11:59 AM
        gregorianHour = ethiopianHour + 6;
        break;
      case EthiopianTimePeriod.afternoon:
        // Ethiopian 6:00-11:59 → Gregorian 12:00-17:59 PM
        gregorianHour = ethiopianHour + 6;
        break;
      case EthiopianTimePeriod.evening:
        // Ethiopian 12:00-5:59 → Gregorian 18:00-23:59 PM
        gregorianHour = ethiopianHour + 18;
        break;
      case EthiopianTimePeriod.night:
        // Ethiopian 6:00-11:59 → Gregorian 0:00-5:59 AM
        gregorianHour = ethiopianHour - 6;
        if (gregorianHour < 0) gregorianHour += 12;
        break;
    }

    return DateTime(2000, 1, 1, gregorianHour, minute);
  }

  /// Create from Gregorian DateTime
  factory EthiopianTime.fromGregorian(DateTime dateTime) {
    int gregorianHour = dateTime.hour;
    int ethiopianHour;
    EthiopianTimePeriod period;

    // Gregorian to Ethiopian mapping:
    // 6:00 AM - 11:59 AM → ጠዋት (morning) Ethiopian 12:00 - 5:59
    // 12:00 PM - 5:59 PM → ከሰአት (afternoon) Ethiopian 6:00 - 11:59
    // 6:00 PM - 11:59 PM → ማታ (evening) Ethiopian 12:00 - 5:59
    // 12:00 AM - 5:59 AM → ሌሊት (night) Ethiopian 6:00 - 11:59

    if (gregorianHour >= 6 && gregorianHour < 12) {
      // Morning (ጠዋት): Gregorian 6-11 → Ethiopian 12, 1, 2, 3, 4, 5
      period = EthiopianTimePeriod.morning;
      ethiopianHour = gregorianHour - 6;
      if (ethiopianHour == 0) ethiopianHour = 12;
    } else if (gregorianHour >= 12 && gregorianHour < 18) {
      // Afternoon (ከሰአት): Gregorian 12-17 → Ethiopian 6, 7, 8, 9, 10, 11
      period = EthiopianTimePeriod.afternoon;
      ethiopianHour = gregorianHour - 6;
    } else if (gregorianHour >= 18 && gregorianHour < 24) {
      // Evening (ማታ): Gregorian 18-23 → Ethiopian 12, 1, 2, 3, 4, 5
      period = EthiopianTimePeriod.evening;
      ethiopianHour = gregorianHour - 18;
      if (ethiopianHour == 0) ethiopianHour = 12;
    } else {
      // Night (ሌሊት): Gregorian 0-5 → Ethiopian 6, 7, 8, 9, 10, 11
      period = EthiopianTimePeriod.night;
      ethiopianHour = gregorianHour + 6;
    }

    return EthiopianTime(
      hour: ethiopianHour,
      minute: dateTime.minute,
      period: period,
    );
  }

  /// Get current Ethiopian time
  factory EthiopianTime.now() {
    return EthiopianTime.fromGregorian(DateTime.now());
  }

  /// Format as string (e.g., "2:30 ጠዋት" or "2:30 Morning")
  String format({String language = 'am'}) {
    final minuteStr = minute.toString().padLeft(2, '0');
    String periodStr = getPeriodLabel(period, language);
    return '$hour:$minuteStr $periodStr';
  }

  /// Get period label for given language
  static String getPeriodLabel(EthiopianTimePeriod period, String language) {
    if (language == 'am') {
      switch (period) {
        case EthiopianTimePeriod.morning:
          return 'ጠዋት';
        case EthiopianTimePeriod.afternoon:
          return 'ከሰአት';
        case EthiopianTimePeriod.evening:
          return 'ማታ';
        case EthiopianTimePeriod.night:
          return 'ሌሊት';
      }
    } else if (language == 'ao') {
      switch (period) {
        case EthiopianTimePeriod.morning:
          return 'Ganama';
        case EthiopianTimePeriod.afternoon:
          return 'Guyyaa';
        case EthiopianTimePeriod.evening:
          return 'Galgala';
        case EthiopianTimePeriod.night:
          return 'Halkan';
      }
    } else {
      switch (period) {
        case EthiopianTimePeriod.morning:
          return 'Morning';
        case EthiopianTimePeriod.afternoon:
          return 'Afternoon';
        case EthiopianTimePeriod.evening:
          return 'Evening';
        case EthiopianTimePeriod.night:
          return 'Night';
      }
    }
  }

  @override
  String toString() => format();
}
