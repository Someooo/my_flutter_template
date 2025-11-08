import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_template/core/widgets/text_with_text_field.dart';

class CustomTimePicker extends StatelessWidget {
  final ValueNotifier<TimeOfDay?> selectedTime;
  final ValueChanged<TimeOfDay?> onChanged;
  final String text;

  const CustomTimePicker({
    super.key,
    required this.selectedTime,
    required this.onChanged,
    this.text = "time",
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TimeOfDay?>(
      valueListenable: selectedTime,
      builder: (context, time, _) {
        TimeOfDay initialTime = time ?? TimeOfDay.now();

        return GestureDetector(
          onTap: () async {
            TimeOfDay selected = initialTime;

            await showModalBottomSheet(
              context: context,
              backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
              builder: (context) {
                int hour = selected.hourOfPeriod == 0 ? 12 : selected.hourOfPeriod;
                int minute = selected.minute;
                bool isAm = selected.period == DayPeriod.am;

                if ((!isAm) && hour < 12) {
                  hour += 12;
                }

                return SizedBox(
                  height: 300.h,
                  child: Column(
                    children: [
                      Container(
                        height: 50.h,
                        color: Theme.of(context).bottomSheetTheme.backgroundColor,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: GestureDetector(
                          onTap: () {
                            int finalHour = hour % 12;
                            if (!isAm) finalHour += 12;

                            final newTime = TimeOfDay(hour: finalHour, minute: minute);
                            onChanged(newTime);
                            Navigator.pop(context);
                          },
                          child: Text(
                            'choose'.tr,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MediaQuery(
                              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                              child: CupertinoTheme(
                                data: const CupertinoThemeData(
                                  brightness: Brightness.light, // 👈 important to force light theme
                                  primaryColor: Colors.black,
                                  textTheme: CupertinoTextThemeData(
                                    dateTimePickerTextStyle: TextStyle(
                                      color: Colors.black, // 👈 enforce black
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                child: DefaultTextStyle(
                                  style: const TextStyle(
                                    color: Colors.black, // 👈 still needed for Android
                                    fontSize: 20,
                                  ),
                                  child: CupertinoTimerPicker(
                                    onTimerDurationChanged: (duration) {
                                      hour = duration.inHours % 12;
                                      minute = duration.inMinutes % 60;
                                      isAm = duration.inHours < 12;

                                      initialTime = TimeOfDay(
                                        hour: hour,
                                        minute: minute,
                                      );
                                    },
                                    mode: CupertinoTimerPickerMode.hm,
                                    initialTimerDuration: Duration(
                                      hours: hour,
                                      minutes: minute,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: AbsorbPointer(
            absorbing: true,
            child: TextWithTextField(
              width: double.infinity,
              text: text,
              hintText: text,
              controller:
                  time != null ? TextEditingController(text: time.format(context)) : TextEditingController(),
            ),
          ),
        );
      },
    );
  }
}
