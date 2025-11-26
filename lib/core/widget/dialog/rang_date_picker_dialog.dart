// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:nilz_app/core/resource/font_manager.dart';
import 'package:nilz_app/core/resource/size_manager.dart';
import 'package:table_calendar/table_calendar.dart';
import '../button/main_app_button.dart';
import '../text/app_text_widget.dart';



void showRangDatePickerDialog(
    {required BuildContext context,
    required Function({required DateTime dF, required DateTime dT})
        onRangeDateSelected}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        elevation: 0,
        backgroundColor: AppColorManager.white,
        insetPadding: EdgeInsets.symmetric(
          horizontal: AppWidthManager.w4,
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child:Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: AppHeightManager.h1,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w2),
                height: AppHeightManager.h45,
                child: FilterTableCalendar(
                    onRangeDateSelected: onRangeDateSelected)),
            SizedBox(
              height: AppHeightManager.h1,
            ),
            MainAppButton(
              width: AppHeightManager.h39,
              height: AppHeightManager.h5,
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                Navigator.of(context).pop();
              },
              alignment: Alignment.center,
              color: AppColorManager.blue,
              child: AppTextWidget(
                text: "Ok",
                color: AppColorManager.white,
                fontSize: FontSizeManager.fs16,
              ),
            ),
            SizedBox(
              height: AppHeightManager.h2,
            ),
          ],
        ),
      );
    },
  );
}

class FilterTableCalendar extends StatefulWidget {
  const FilterTableCalendar({super.key, required this.onRangeDateSelected});

  final Function({required DateTime dF, required DateTime dT})
      onRangeDateSelected;

  @override
  State<FilterTableCalendar> createState() => _FilterTableCalendarState();
}

class _FilterTableCalendarState extends State<FilterTableCalendar> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  final RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.white,
      body: TableCalendar(
        firstDay: DateTime(2024).toLocal(),
        lastDay: DateTime.now().toLocal(),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) {
          // Highlights the selected day
          return isSameDay(_selectedDay, day);
        },
        rangeStartDay: _rangeStart,
        rangeEndDay: _rangeEnd,
        calendarFormat: _calendarFormat,
        rangeSelectionMode: _rangeSelectionMode,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        availableCalendarFormats: const {
          // Hide the format button
          CalendarFormat.month: '',
        },
        availableGestures: AvailableGestures.none,
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: AppColorManager.blue,
            // Change this to the desired color
            shape: BoxShape.circle, // Shape of the selected day
          ),
          todayDecoration: BoxDecoration(
            color: AppColorManager.blue.withOpacity(0.5),
            // Change this to the desired color
            shape: BoxShape.circle,
          ),
          rangeStartDecoration: const BoxDecoration(
            color: AppColorManager.blue,
            // Change this to the desired color
            shape: BoxShape.circle, // Shape of the selected day
          ),
          rangeEndDecoration: BoxDecoration(
            color: AppColorManager.blue,
            // Change this to the desired color
            shape: BoxShape.circle, // Shape of the selected day
          ),
          rangeHighlightColor: AppColorManager.blue.withOpacity(0.25),
          outsideDaysVisible: false,
        ),
        onRangeSelected: (start, end, focusedDay) {
          setState(() {
            _rangeStart = start;
            _rangeEnd = end;
            _focusedDay = focusedDay;

            if (start != null && end != null) {
              widget.onRangeDateSelected(dF: start, dT: end);
            }
          });
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}
