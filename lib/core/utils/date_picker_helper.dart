import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Helper function to show date picker with custom Arabic button labels
/// This ensures consistent button labels: "موافق" (OK) and "إلغاء" (Cancel) in Arabic
Future<DateTime?> showLocalizedDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
  DatePickerMode initialDatePickerMode = DatePickerMode.day,
  String? helpText,
  String? cancelText,
  String? confirmText,
  SelectableDayPredicate? selectableDayPredicate,
}) async {
  final currentLocale = Get.locale ?? const Locale('ar');
  
  try {
    await initializeDateFormatting(currentLocale.languageCode, null);
  } catch (e) {
    // Continue if initialization fails
  }

  // Set button labels based on locale
  final String localizedCancel = cancelText ?? (currentLocale.languageCode == 'ar' ? 'إلغاء' : 'Cancel');
  final String localizedConfirm = confirmText ?? (currentLocale.languageCode == 'ar' ? 'حسناً' : 'OK');

  return await showDatePicker(
    context: context,
    locale: currentLocale,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    initialDatePickerMode: initialDatePickerMode,
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    helpText: helpText,
    cancelText: localizedCancel,
    confirmText: localizedConfirm,
    selectableDayPredicate: selectableDayPredicate,
  );
}

/// Helper function to show time picker with custom Arabic button labels
/// This ensures consistent button labels: "موافق" (OK) and "إلغاء" (Cancel) in Arabic
Future<TimeOfDay?> showLocalizedTimePicker({
  required BuildContext context,
  required TimeOfDay initialTime,
  TimePickerEntryMode initialEntryMode = TimePickerEntryMode.dial,
  String? helpText,
  String? cancelText,
  String? confirmText,
  String? hourLabelText,
  String? minuteLabelText,
  TransitionBuilder? builder,
}) async {
  final currentLocale = Get.locale ?? const Locale('ar');
  
  try {
    await initializeDateFormatting(currentLocale.languageCode, null);
  } catch (e) {
    // Continue if initialization fails
  }

  // Set button labels based on locale
  final String localizedCancel = cancelText ?? (currentLocale.languageCode == 'ar' ? 'إلغاء' : 'Cancel');
  final String localizedConfirm = confirmText ?? (currentLocale.languageCode == 'ar' ? 'حسناً' : 'OK');

  return await showTimePicker(
    context: context,
    initialTime: initialTime,
    initialEntryMode: initialEntryMode,
    helpText: helpText,
    cancelText: localizedCancel,
    confirmText: localizedConfirm,
    hourLabelText: hourLabelText,
    minuteLabelText: minuteLabelText,
    builder: builder,
  );
}

