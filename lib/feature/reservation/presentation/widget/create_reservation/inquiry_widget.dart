import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:nilz_app/core/widget/date_picker/date_picker_field.dart';
import 'package:nilz_app/core/widget/form_field/text_form_field/searchable_dropdown.dart';
import 'package:nilz_app/feature/reservation/presentation/model/room_model.dart';
import 'package:nilz_app/feature/reservation/presentation/widget/create_reservation/room_settings/room_settings_field.dart';

class InquiryWidget extends StatelessWidget {
  const InquiryWidget({
    super.key,
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
  });

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // City dropdown
        Padding(
          padding: const EdgeInsets.all(15),
          child: SearchableDropdown<dynamic>(
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
        ),

        // Date pickers row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Expanded(
                child: DatePickerField(
                  hint: 'arrive_date'.tr(),
                  label: 'arrive_date'.tr(),
                  value: fromDate,
                  onChanged: onFromDateChanged,
                ),
              ),
              const SizedBox(width: 12),
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
        ),

        const SizedBox(height: 12),

        // Room settings
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'room_settings'.tr(),
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 0.8.h),
              RoomSettingsField(rooms: rooms, onChanged: onRoomsChanged),
            ],
          ),
        ),

        const SizedBox(height: 6),
        const Divider(color: AppColorManager.textGrey),
      ],
    );
  }
}
