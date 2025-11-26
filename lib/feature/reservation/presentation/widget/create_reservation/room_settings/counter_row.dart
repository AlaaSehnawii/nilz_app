// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:nilz_app/core/resource/icon_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CounterRow extends StatelessWidget {
  const CounterRow({super.key, 
    required this.label,
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
  });

  final String label;
  final int value;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Row(
          children: [
            IconButton(
              icon: SvgPicture.asset(
                AppIconManager.minusCircle,
                color: AppColorManager.denim,
              ),
              onPressed: onDecrement,
            ),
            Text(
              value.toString(),
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            IconButton(
              icon: SvgPicture.asset(
                AppIconManager.addCircle,
                color: AppColorManager.denim,
              ),
              onPressed: onIncrement,
            ),
          ],
        ),
      ],
    );
  }
}