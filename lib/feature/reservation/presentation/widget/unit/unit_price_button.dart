// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:nilz_app/core/resource/icon_manager.dart';
import 'package:nilz_app/core/widget/button/main_app_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UnitPriceAndButton extends StatelessWidget {
  final String price;
  final int nightCount;
  final bool isReservable;

  const UnitPriceAndButton({
    super.key,
    required this.price,
    required this.nightCount,
    required this.isReservable,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                price,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColorManager.denim,
                ),
              ),
              Text(
                '/ $nightCount ${nightCount > 1 ? 'nights'.tr() : 'night'.tr()}',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),

        SizedBox(width: 3.w),

        Flexible(
          child: MainAppButton(
            onTap: isReservable ? () {} : null,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.8.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColorManager.denim,
                    AppColorManager.denim.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppColorManager.denim.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      'book_now'.tr(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  SvgPicture.asset(
                    AppIconManager.arrowRight,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
