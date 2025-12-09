// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:nilz_app/core/resource/icon_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UnitInfoChipsRow extends StatelessWidget {
  final int bedCount;
  final int adultCount;
  final int childCount;
  final int roomCount;

  const UnitInfoChipsRow({
    super.key,
    required this.bedCount,
    required this.adultCount,
    required this.childCount,
    required this.roomCount,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 2.w,
        runSpacing: 1.h,
        children: [
          _buildInfoChip(AppIconManager.room, '$roomCount ${'room'.tr()}'),
          _buildInfoChip(AppIconManager.bed, '$bedCount ${'beds'.tr()}'),
          _buildInfoChip(AppIconManager.profile, '$adultCount ${'adults'.tr()}'),
          _buildInfoChip(AppIconManager.children, '$childCount ${'children'.tr()}'),
        ],
      ),
    );
  } 

  Widget _buildInfoChip(String icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 1.2.h),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(icon, height: 2.h, width: 2.h,color: AppColorManager.denim),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(fontSize: 13.sp, color: Colors.grey[800]),
          ),
        ],
      ),
    );
  }
}
