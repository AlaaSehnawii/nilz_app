// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:nilz_app/core/resource/icon_manager.dart';
import 'package:nilz_app/core/widget/button/main_app_button.dart';
import 'package:nilz_app/feature/drawer/basic_data/city/presentation/cubit/city_cubit.dart';
import 'package:nilz_app/feature/reservation/presentation/cubit/unit_cubit.dart';
import 'package:nilz_app/feature/reservation/presentation/widget/unit/unit_booking_dialog.dart';
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
            onTap: isReservable
                ? () async {
                    final result = await showUnitBookingDialog(
                      context: context,
                      clients: context.read<CityCubit>().state.entity.cities,
                      salesmen: context.read<CityCubit>().state.entity.cities,
                      nameBuilder: (item) => item.name?.en ?? "",
                    );
          
                    if (result == null) return;
          
                    print("Client:  ${result.selectedClient}");
                    print("Salesman: ${result.selectedSalesman}");
                    print("Coupon:   ${result.coupon}");
                    print("Breakfast: ${result.breakfast}");
          
                    final cubit = context.read<UnitCubit>();
          
                    await cubit.getUnitDetails(
                      context,
                      toStartTimeIso: "_toIsoDayAtNine(_fromDate!)",
                      toEndTimeIso: "_toIsoDayAtNine(_toDate!)",
                      unitId: '',
                    );
                  }
                : null,
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
