import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'text_with_text_field.dart';

class CustomDatePicker extends StatelessWidget {
  final ValueNotifier<String?> selectedDateNotifier;
  final ValueChanged<String?> onChanged;
  final String text;

  const CustomDatePicker({
    super.key,
    required this.selectedDateNotifier,
    required this.onChanged,
    this.text = "date",
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: selectedDateNotifier,
      builder: (context, selectedDateString, _) {
        DateTime now = DateTime.now();
        DateTime initialDate;

        if (selectedDateString != null) {
          try {
            initialDate = DateFormat('yyyy-MM-dd').parse(selectedDateString);
            if (initialDate.isBefore(now)) {
              initialDate = now;
            }
          } catch (_) {
            initialDate = now;
          }
        } else {
          initialDate = now;
        }

        DateTime selectedDate = initialDate;

        return GestureDetector(
          onTap: () async {
            await showModalBottomSheet<Widget>(
              backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: 300.h,
                  child: Column(
                    children: [
                      Container(
                        height: 50.h,
                        color: Theme.of(context).bottomSheetTheme.backgroundColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: GestureDetector(
                                onTap: () {
                                  final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
                                  onChanged(formattedDate);
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'choose'.tr,
                                  style: Theme.of(context).textTheme.displayMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: CupertinoTheme(
                          data: CupertinoThemeData(
                            textTheme: CupertinoTextThemeData(
                              dateTimePickerTextStyle: Theme.of(context).textTheme.displayMedium,
                            ),
                            primaryColor: Theme.of(context).bottomSheetTheme.backgroundColor,
                          ),
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            dateOrder: DatePickerDateOrder.dmy,
                            initialDateTime: initialDate,
                            onDateTimeChanged: (dateTime) {
                              selectedDate = dateTime;
                            },
                            minimumDate: DateTime(
                              now.year,
                              now.month,
                              now.day,
                            ),
                          ),
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
            child:TextWithTextField(
              width: double.infinity,
              text: text,
              hintText: text,
              controller: selectedDateString != null
                  ? TextEditingController(text: selectedDateString)
                  : TextEditingController(),
            ),
          ),
        );
      },
    );
  }
}
