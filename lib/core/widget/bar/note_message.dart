import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../helper/language_helper.dart';
import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/icon_manager.dart';
import '../../resource/size_manager.dart';
import '../text/app_text_widget.dart';
import 'dart:ui' as ui;

//Customized Snack Bar
abstract class NoteMessage {
  static showErrorSnackBar({
    required BuildContext context,
    required String text,
    void Function()? onTap,
    int? duration,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Directionality(
        textDirection:
            LanguageHelper.isEnglishData(data: text, context: context)
                ? ui.TextDirection.ltr
                : ui.TextDirection.rtl,
        child: GestureDetector(
          onTap: onTap,
          child: SizedBox(
            width: AppWidthManager.w100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: AppTextWidget(
                    text: text,
                    fontSize: FontSizeManager.fs14,
                    color: AppColorManager.red,
                    fontWeight: FontWeight.bold,
                    overflow: overflow ?? TextOverflow.visible,
                    maxLines: maxLines ?? 2,
                    softWrap: true,
                  ),
                ),
                SizedBox(
                  width: AppWidthManager.w2,
                ),
                GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                    child: SvgPicture.asset(AppIconManager.warning,
                        colorFilter: const ColorFilter.mode(
                            AppColorManager.red, BlendMode.srcIn)))
              ],
            ),
          ),
        ),
      ),
      backgroundColor: AppColorManager.rose,
      duration: Duration(seconds: duration ?? 2),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadiusManager.r3),
        side: const BorderSide(width: 2, color: AppColorManager.red),
      ),
    ));
  }

  static showSuccessSnackBar({
    required BuildContext context,
    required String text,
    void Function()? onTap,
    int? duration,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Directionality(
        textDirection:
            LanguageHelper.isEnglishData(data: text, context: context)
                ? ui.TextDirection.ltr
                : ui.TextDirection.rtl,
        child: GestureDetector(
          onTap: onTap,
          child: SizedBox(
            width: AppWidthManager.w100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: AppTextWidget(
                    text: text,
                    fontSize: FontSizeManager.fs14,
                    color: AppColorManager.green,
                    fontWeight: FontWeight.bold,
                    overflow: overflow ?? TextOverflow.visible,
                    maxLines: maxLines ?? 2,
                    softWrap: true,
                  ),
                ),
                SizedBox(
                  width: AppWidthManager.w2,
                ),
                GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                    child: SvgPicture.asset(AppIconManager.done,
                        colorFilter: const ColorFilter.mode(
                            AppColorManager.green, BlendMode.srcIn)))
              ],
            ),
          ),
        ),
      ),
      backgroundColor: AppColorManager.lightGreen,
      duration: Duration(seconds: duration ?? 2),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadiusManager.r3),
        side: const BorderSide(width: 2, color: AppColorManager.green),
      ),
    ));
  }
}
