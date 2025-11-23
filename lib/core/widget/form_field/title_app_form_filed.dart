import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/size_manager.dart';
import '../text/app_text_widget.dart';
import 'app_form_field.dart';



class TitleAppFormFiled extends StatefulWidget {
  const TitleAppFormFiled(
      {super.key,
      required this.hint,
      required this.title,
      required this.onChanged,
      required this.validator,
      this.initValue,
      this.style,
      this.suffixIcon,
      this.onIconTaped,
      this.maxLines,
      this.minLines,
      this.isRequired,
      this.readOnly,
      this.multiLines,
      this.textInputType,
      this.controller,
      this.formKey,
      this.isPasswordField});

  final String title, hint;
  final String? Function(String?) onChanged;
  final String? Function(String?) validator;
  final String? suffixIcon, initValue;
  final bool? readOnly;
  final bool? multiLines;
  final TextStyle? style;
  final Function()? onIconTaped;
  final bool? isRequired;
  final int? maxLines;
  final int? minLines;
  final TextEditingController? controller;
  final GlobalKey<FormState>? formKey;
  final TextInputType? textInputType;
  final bool? isPasswordField;

  @override
  State<TitleAppFormFiled> createState() => _TitleAppFormFiledState();
}

class _TitleAppFormFiledState extends State<TitleAppFormFiled> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextWidget(
          text: widget.title,
          fontSize: FontSizeManager.fs16,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(
          height: AppHeightManager.h1point5,
        ),
        SizedBox(
          child: AppTextFormField(
            isPasswordField: widget.isPasswordField,
            formKey: widget.formKey,
            controller: widget.controller,
            style: widget.style,
            readOnly: widget.readOnly,
            suffixIcon: widget.suffixIcon != null && widget.onIconTaped != null
                ? InkWell(
                    overlayColor: const MaterialStatePropertyAll(
                        AppColorManager.transparent),
                    onTap: widget.onIconTaped,
                    child: Padding(
                      padding: EdgeInsets.all(AppWidthManager.w2point5),
                      child: SvgPicture.asset(
                        widget.suffixIcon ?? "",
                      ),
                    ),
                  )
                : null,
            initialValue: widget.initValue,
            minLines: widget.multiLines == true ? widget.minLines ?? 5 : 1,
            maxLines: widget.maxLines,
            validator: widget.validator,
            onChanged: widget.onChanged,
            textInputAction: TextInputAction.next,
            hintText: widget.hint,
            textInputType: widget.textInputType,
          ),
        ),
      ],
    );
  }
}
