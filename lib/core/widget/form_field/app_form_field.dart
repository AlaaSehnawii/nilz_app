import 'package:flutter/material.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/size_manager.dart';

class AppTextFormField extends StatefulWidget {
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool? enabled;
  final String? Function(String?)? validator;
  final String? Function(String?)? onFilledSubmited;
  final Function()? editingComplete;
  final String? Function(String?)? onChanged;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final FocusNode? focusNode;
  final String? labelText;
  final String? initialValue;
  final TextAlignVertical? textAlignVertical;
  final Color? textColor;
  final Color? labelColor;
  final int? maxLines;
  final int? minLines;
  final Widget? prefixIcon;
  final TextStyle? hintStyle, style;
  final String? hintText;
  final bool? outlinedBorder;
  final bool? expand;
  final bool? autoFoucs;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final bool? filled;
  final bool? readOnly;
  final GlobalKey<FormState>? formKey;
  final bool? isPasswordField;

  const AppTextFormField(
      {Key? key,
      this.borderRadius,
      this.minLines,
      this.filled,
      this.style,
      this.readOnly,
      this.enabled,
      this.suffixIcon,
      this.fillColor,
      this.expand,
      this.contentPadding,
      this.controller,
      this.formKey,
      this.autoFoucs,
      this.validator,
      this.hintStyle,
      this.editingComplete,
      this.onChanged,
      this.textInputType,
      this.textInputAction,
      this.textAlignVertical,
      this.focusNode,
      this.labelText,
      this.textColor,
      this.labelColor,
      this.onFilledSubmited,
      this.initialValue,
      this.maxLines,
      this.prefixIcon,
      this.hintText,
      this.outlinedBorder,
      this.isPasswordField})
      : super(key: key);

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: TextFormField(
        key: Key(widget.initialValue ?? ""),
        readOnly: widget.readOnly ?? false,
        textAlignVertical: widget.textAlignVertical,
        onFieldSubmitted: widget.onFilledSubmited,
        validator: widget.validator,
        controller: widget.controller,
        focusNode: widget.focusNode,
        obscureText: widget.isPasswordField == true ? obscureText : false,
        onChanged: widget.onChanged,
        autofocus: widget.autoFoucs ?? false,
        onEditingComplete: widget.editingComplete,
        keyboardType: widget.textInputType,
        textInputAction: widget.textInputAction,
        minLines: widget.isPasswordField == true ? 1 : widget.minLines,
        maxLines: widget.isPasswordField == true ? 1 : widget.maxLines,
        initialValue: widget.initialValue,
        enabled: widget.enabled,
        expands: widget.expand ?? false,
        decoration: InputDecoration(
          filled: widget.filled ?? true,
          fillColor: widget.fillColor ?? AppColorManager.white,
          hintText: widget.hintText,
          suffixIcon: widget.isPasswordField == true
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: Icon(obscureText == true
                      ? Icons.visibility
                      : Icons.visibility_off))
              : widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
          hintStyle: widget.hintStyle,
          prefixIconColor: Colors.grey,
          suffixIconColor: Colors.grey,
          contentPadding: widget.contentPadding ??
              EdgeInsets.symmetric(
                  horizontal: AppWidthManager.w3,
                  vertical: AppHeightManager.h1),
          labelText: widget.labelText,
          labelStyle: TextStyle(
              color: widget.labelColor,
              fontSize: FontSizeManager.fs16,
              fontWeight: FontWeight.bold,
              fontFamily: FontFamilyManager.cairo),
          errorStyle: TextStyle(
            fontSize: FontSizeManager.fs14,
            fontFamily: FontFamilyManager.cairo,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                  widget.borderRadius != null
                      ? widget.borderRadius!
                      : AppRadiusManager.r10)),
              borderSide: BorderSide(
                color: AppColorManager.lightGreyOpacity6,
              )),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                  widget.borderRadius != null
                      ? widget.borderRadius!
                      : AppRadiusManager.r10)),
              borderSide: const BorderSide(
                color: Colors.transparent,
                // color: Colors.transparent,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                  widget.borderRadius != null
                      ? widget.borderRadius!
                      : AppRadiusManager.r10)),
              borderSide: BorderSide(
                color: AppColorManager.lightGreyOpacity6,
              )),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                  widget.borderRadius != null
                      ? widget.borderRadius!
                      : AppRadiusManager.r10)),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              )),
        ),
        style: widget.style ??
            TextStyle(
                color: widget.textColor,
                fontSize: FontSizeManager.fs16,
                fontFamily: FontFamilyManager.cairo),
      ),
    );
  }
}
