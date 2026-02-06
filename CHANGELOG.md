## 1.1.0

* **NEW**: Added `EthiopianDateTimePicker` widget with 12-hour Ethiopian time selection.
* Ethiopian time supports 4 traditional periods:
  - ጠዋት (Morning): Ethiopian 12:00-5:59 = Gregorian 6:00 AM - 11:59 AM
  - ከሰአት (Afternoon): Ethiopian 6:00-11:59 = Gregorian 12:00 PM - 5:59 PM
  - ማታ (Evening): Ethiopian 12:00-5:59 = Gregorian 6:00 PM - 11:59 PM
  - ሌሊት (Night): Ethiopian 6:00-11:59 = Gregorian 12:00 AM - 5:59 AM
* Added `EthiopianTime` utility class for time conversion between Ethiopian and Gregorian formats.
* Added `TimePickerBloc` for time state management.
* Modern UI with animated transitions, haptic feedback, and color-coded period buttons.
* Multi-language support (Amharic, English, Oromo) for time picker strings.

## 1.0.1

* Fixed redundant navigation button in month header.
* Updated English month names to phonetic Ethiopian names (e.g., "Meskerem").
* Fixed deprecated `withOpacity` and `Matrix4.scale` calls to use modern Flutter/Dart APIs (`withValues` and `Matrix4.diagonal3Values`).
* Added comprehensive dartdoc comments to all public API elements (widgets, BLOC states, events, and constants).
* Refactored BLOC state classes to use modern Dart **super parameters**.
* Fixed a minor typo in BLOC events.

## 1.0.0

* **BREAKING**: Renamed package to `ethio_date_picker`.
* Redesigned UI with modern, solid-color aesthetic.
* Added `allowPastDates` property to enable/disable past date selection.
* Fixed null safety dependency issues (`abushakir` upgrade).
* Improved performance and animations.

## 0.0.1

* Initial release.
