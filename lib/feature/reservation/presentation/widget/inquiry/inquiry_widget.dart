// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nilz_app/core/resource/icon_manager.dart';
import 'package:nilz_app/core/widget/button/main_app_button.dart';
import 'package:nilz_app/feature/reservation/presentation/widget/create_reservation/room_settings/room_settings_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:nilz_app/core/widget/date_picker/date_picker_field.dart';
import 'package:nilz_app/core/widget/form_field/text_form_field/searchable_dropdown.dart';
import 'package:nilz_app/feature/reservation/presentation/model/room_model.dart';

class InquiryWidget extends StatelessWidget {
  const InquiryWidget({
    super.key,
    required this.isInquiry,
    required this.cities,
    required this.selectedCity,
    required this.isArabic,
    required this.fromDate,
    required this.toDate,
    required this.rooms,
    required this.onCityChanged,
    required this.onFromDateChanged,
    required this.onToDateChanged,
    required this.onRoomsChanged,
    required this.onSearch,
  });

  final bool isInquiry;
  final List<dynamic> cities;
  final dynamic selectedCity;
  final bool isArabic;

  final DateTime? fromDate;
  final DateTime? toDate;

  final List<RoomInfo> rooms;

  final ValueChanged<dynamic> onCityChanged;
  final ValueChanged<DateTime?> onFromDateChanged;
  final ValueChanged<DateTime?> onToDateChanged;
  final ValueChanged<List<RoomInfo>> onRoomsChanged;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
        decoration: BoxDecoration(
          color: AppColorManager.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // City dropdown
            SearchableDropdown<dynamic>(
              items: cities,
              selectedItem: selectedCity,
              titleText: "city".tr(),
              hintText: "select_city".tr(),
              labelBuilder: (city) {
                final en = city.name?.en ?? '';
                final ar = city.name?.ar ?? '';
                if (isArabic) {
                  return ar.isNotEmpty ? ar : en;
                } else {
                  return en.isNotEmpty ? en : ar;
                }
              },
              filterFn: (city, query) {
                if (query.isEmpty) return true;
                final q = query.toLowerCase();
                final en = (city.name?.en ?? '').toLowerCase();
                final ar = (city.name?.ar ?? '').toLowerCase();
                return en.contains(q) || ar.contains(q);
              },
              onChanged: onCityChanged,
            ),

            SizedBox(height: 1.5.h),

            // Date pickers row
            Row(
              children: [
                Expanded(
                  child: DatePickerField(
                    hint: 'arrive_date'.tr(),
                    label: 'arrive_date'.tr(),
                    value: fromDate,
                    onChanged: onFromDateChanged,
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: DatePickerField(
                    hint: 'leave_date'.tr(),
                    label: 'leave_date'.tr(),
                    value: toDate,
                    onChanged: onToDateChanged,
                  ),
                ),
              ],
            ),

            SizedBox(height: 1.5.h),

            // Room settings
            Text(
              'room_settings'.tr(),
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: AppColorManager.textAppColor,
              ),
            ),
            SizedBox(height: 0.8.h),
            RoomSettingsField(rooms: rooms, onChanged: onRoomsChanged),

            if (isInquiry) ...[
              SizedBox(height: 1.5.h),
              SizedBox(
                child: MainAppButton(
                  height: 5.2.h,
                  color: AppColorManager.denim,
                  borderRadius: BorderRadius.circular(10),
                  onTap: onSearch,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppIconManager.search,
                        color: AppColorManager.background,
                        width: 18,
                        height: 18,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'search'.tr(),
                        style: TextStyle(
                          color: AppColorManager.background,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
