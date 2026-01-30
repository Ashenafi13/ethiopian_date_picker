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
