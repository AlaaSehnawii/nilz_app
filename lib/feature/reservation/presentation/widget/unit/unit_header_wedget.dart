// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nilz_app/core/resource/icon_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:nilz_app/core/resource/color_manager.dart';

class UnitHeaderSection extends StatelessWidget {
  final String unitName;
  final totalRating;
  final String city;
  final String address;

  const UnitHeaderSection({
    super.key,
    required this.unitName,
    required this.totalRating,
    required this.city,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title + Rating
        Row(
          children: [
            Expanded(
              child: Text(
                unitName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColorManager.textAppColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 19.sp,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(AppIconManager.star, color: AppColorManager.amber, height: 3.h, width: 3.h,),
                const SizedBox(width: 4),
                Text(
                  '$totalRating',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: 1.h),

        // Location
        Row(
          children: [
            SvgPicture.asset(AppIconManager.location, color: AppColorManager.textGrey,),
            const SizedBox(width: 8),
            Expanded( 
              child: Text(
                '$city • $address',
                style: TextStyle(fontSize: 14.sp, color: AppColorManager.textGrey),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
