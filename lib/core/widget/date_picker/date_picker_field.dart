// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:nilz_app/core/resource/icon_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DatePickerField extends StatefulWidget {
  const DatePickerField({
    super.key,
    required this.label,
    this.hint,
    required this.value,
    required this.onChanged,
    this.firstDate,
    this.lastDate,
  });

  final String label;
  final String? hint;
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _format(widget.value));
  }

  @override
  void didUpdateWidget(covariant DatePickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _controller.text = _format(widget.value);
    }
  }

  String _format(DateTime? date) {
    if (date == null) return '';
    final d = date.day.toString().padLeft(2, '0');
    final m = date.month.toString().padLeft(2, '0');
    final y = date.year.toString();
    return '$d/$m/$y';
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.value ?? now,
      firstDate: widget.firstDate ?? DateTime(2000),
      lastDate: widget.lastDate ?? DateTime(2100),
    );

    if (picked != null) {
      widget.onChanged(picked);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 15.sp,
            color: AppColorManager.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 0.8.h),

        TextFormField(
          // ❌ removed initialValue
          controller: _controller,
          readOnly: true,
          onTap: _pickDate,
          decoration: InputDecoration(
            fillColor: AppColorManager.background.withOpacity(0),
            filled: true,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 2.h,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColorManager.backgroundGrey,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColorManager.denim.withOpacity(0.6),
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            // 👇 use hint as a real hint, shown when controller.text is empty
            hintText: widget.hint ?? widget.label,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: AppColorManager.textGrey,
            ),
            suffixIcon: SvgPicture.asset(
              AppIconManager.calendarAdd,
              fit: BoxFit.scaleDown,
              color: AppColorManager.textGrey,
            ),
          ),
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColorManager.textAppColor,
          ),
          cursorColor: AppColorManager.textAppColor,
        ),
      ],
    );
  }
}
