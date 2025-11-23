import 'package:flutter/material.dart';
import 'package:nilz_app/core/resource/font_manager.dart';
import 'package:nilz_app/core/resource/size_manager.dart';
import 'package:nilz_app/core/widget/text/app_text_widget.dart';

// ignore: must_be_immutable
class DotStatusText extends StatelessWidget {
  DotStatusText(
      {super.key, required this.color, required this.title, this.maxLines = 1});

  final String title;
  final Color color;
  int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: AppWidthManager.w2,
          height: AppWidthManager.w2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.8),
          ),
        ),
        SizedBox(
          width: AppWidthManager.w1,
        ),
        AppTextWidget(
          text: title,
          color: color,
          fontSize: FontSizeManager.fs15,
          maxLines: maxLines,
        )
      ],
    );
  }
}
