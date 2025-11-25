import 'package:flutter/material.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// todo alaa

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    this.focusedBorder,
    this.enabledBorder,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isObsecureText,
    this.controller,
    this.validator,
    this.fillColor,
    this.hintTextStyle, this.inputTextStyle,
    this.onChanged
  });

  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final bool? isObsecureText;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final TextStyle? inputTextStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final Function(String?)? validator;
  final Color? fillColor;
  final ValueChanged<String>? onChanged;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        fillColor: fillColor ?? AppColorManager.background.withOpacity(0),
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        enabledBorder:
        enabledBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColorManager.backgroundGrey,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
        focusedBorder:
        focusedBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColorManager.denim.withOpacity(0.6),
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.3),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.3),
          borderRadius: BorderRadius.circular(8.0),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintStyle:
        hintTextStyle ??
            TextStyle(fontSize: 14.sp, color: AppColorManager.textGrey),
        hintText: hintText ?? "No hint text added",
      ),
      obscureText: isObsecureText ?? false,

      style: inputTextStyle ?? TextStyle(fontSize: 14.sp, color: AppColorManager.textAppColor),
      cursorColor: AppColorManager.textAppColor,
      validator: (value) {
        return validator!(value);
      },
    );
  }
}
