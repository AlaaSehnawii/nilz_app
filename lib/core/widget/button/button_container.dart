
import 'package:flutter/material.dart';
import 'package:nilz_app/core/resource/color_manager.dart';

class ButtonContainer extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final double height;
  final double width;
  final double fontSize;
  final FontWeight fontWeight;

  const ButtonContainer({
    super.key,
    required this.text,
    this.onTap,
    this.color = AppColorManager.background,
    this.textColor = AppColorManager.textAppColor,
    this.borderColor = AppColorManager.denim,
    this.height = 100,
    this.width = 200,
    this.fontSize = 30,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
