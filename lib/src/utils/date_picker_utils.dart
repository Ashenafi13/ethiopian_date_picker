import 'package:abushakir/abushakir.dart';
import '../constants/date_picker_strings.dart';

/// contains constant functions for our library

ethiopianToGregorianDateConvertor(
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

getCalenderSpecificYear(int val) {
  final EtDatetime date;
  date = EtDatetime.now();
  return ETC(year: val, month: date.month);
}
