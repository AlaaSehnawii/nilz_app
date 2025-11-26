// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:nilz_app/feature/dashboard/pending_requests/domain/entity/response/pending_req_entity.dart';

class PendingRequestContainer extends StatelessWidget {
  final PendingRequestResponseEntity response;

  const PendingRequestContainer({super.key, required this.response});

  String formatDate(String? iso) {
    if (iso == null || iso.isEmpty) return "-";
    final date = DateTime.tryParse(iso);
    if (date == null) return "-";
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final item = response.data!.first;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(0),
      color: AppColorManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: AppColorManager.backgroundGrey.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (item.placeLogo?.url?.isNotEmpty ?? false)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item.placeLogo!.url!,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.placeName?.en ?? "-",
                        style: const TextStyle(
                          color: AppColorManager.textAppColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.clientName ?? "-",
                        style: TextStyle(
                          color: AppColorManager.denim.withOpacity(0.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildInfoItem(
                    "total_price".tr(),
                    item.totalPrice ?? "-",
                  ),
                ),
                Expanded(
                  child: _buildInfoItem("rooms".tr(), "${item.roomCount ?? 0}"),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildInfoItem(
                    "check_in".tr(),
                    formatDate(item.fromDate),
                  ),
                ),
                Expanded(
                  child: _buildInfoItem(
                    "check-out".tr(),
                    formatDate(item.toDate),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildInfoItem("booking_date".tr(), formatDate(item.createdAt)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColorManager.textAppColor.withOpacity(0.6),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: AppColorManager.textAppColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
