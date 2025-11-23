import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/resource/color_manager.dart';
import '../../../../core/resource/icon_manager.dart';
import '../../domain/entity/response/reservation_entity.dart';

class ReservationContainer extends StatelessWidget {
  final ReservationEntity reservation;

  const ReservationContainer({super.key, required this.reservation});

  String _formatDate(String? iso) {
    if (iso == null || iso.isEmpty) return "-";
    final date = DateTime.tryParse(iso);
    if (date == null) return "-";
    return DateFormat('yyyy-MM-dd').format(date);
  }

  Color _hexToColor(String? hex, {Color fallback = Colors.grey}) {
    if (hex == null || hex.isEmpty) return fallback;
    var value = hex.replaceAll('#', '');
    if (value.length == 6) value = 'FF$value';
    try {
      return Color(int.parse(value, radix: 16));
    } catch (_) {
      return fallback;
    }
  }

  @override
  Widget build(BuildContext context) {
    final unit = reservation.unit;
    final parent = unit?.parent;

    final placeName = parent?.name?.ar ?? parent?.name?.en ?? "-";
    final clientName = reservation.user?.fullName ?? "-";
    final statusName =
        reservation.reservationStatus?.name?.ar ??
        reservation.reservationStatus?.name?.en ??
        "-";
    final statusColor = _hexToColor(
      reservation.reservationStatus?.color,
      fallback: AppColorManager.denim,
    );

    final coverUrl = unit?.coverImage?.url ?? parent?.coverImage?.url;
    final cityName = parent?.city?.name?.ar ?? parent?.city?.name?.en ?? "";

    final totalPrice = reservation.totalPrice ?? "-";
    final nights = reservation.nightCount ?? reservation.daysNumber ?? 0;
    final adults = reservation.adultCount ?? 0;
    final children = reservation.childCount ?? 0;

    final rooms =
        unit?.roomCount ??
        (reservation.roomConfig.isNotEmpty ? reservation.roomConfig.length : 0);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColorManager.backgroundGrey.withOpacity(0.08),
            AppColorManager.denim.withOpacity(0.04),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Material(
          color: AppColorManager.white,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildStatusChip(statusName, statusColor),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      // onTapDown: (details) async {
                      //   final position = details.globalPosition;
                      //   final selected = await showMenu<String>(
                      //     context: context,
                      //     position: RelativeRect.fromLTRB(
                      //       position.dx,
                      //       position.dy,
                      //       position.dx,
                      //       position.dy,
                      //     ),
                      //     items: [
                      //       PopupMenuItem(
                      //         value: 'edit',
                      //         child: Row(
                      //           mainAxisAlignment:
                      //           MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Text(
                      //               'edit'.tr(),
                      //               style: TextStyle(
                      //                 color: AppColorManager.textGrey,
                      //               ),
                      //             ),
                      //             SvgPicture.asset(
                      //               AppIconManager.edit,
                      //               color: AppColorManager.textGrey,
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       PopupMenuItem(
                      //         value: 'delete',
                      //         child: Row(
                      //           mainAxisAlignment:
                      //           MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Text(
                      //               'delete'.tr(),
                      //               style: TextStyle(
                      //                 color: AppColorManager.textGrey,
                      //               ),
                      //             ),
                      //             SvgPicture.asset(
                      //               AppIconManager.delete,
                      //               color: AppColorManager.textGrey,
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   );
                      //
                      //   if (selected == 'edit') {
                      //     final input = await showGenericEditDialog(
                      //       context,
                      //       title: editDialogTitle,
                      //       initialNameAr: secondaryName,
                      //       initialNameEn: primaryName,
                      //       initialImageUrl: imageUrl,
                      //       nameArHint: nameArHint,
                      //       nameEnHint: nameEnHint,
                      //       pickImageText: pickImageText,
                      //       noImageSelectedText: noImageSelectedText,
                      //       confirmText: saveText,
                      //       cancelText: cancelText,
                      //       enableImage: enableImage,
                      //       enableCity: enableCity,
                      //       enableStatus: enableStatus,
                      //       initialStatus: isActive,
                      //       cityLabel: cityLabel,
                      //       cityOptions: cityOptions,
                      //       cityHint: cityHint,
                      //       initialCityId: adapter.getCityId(entity),
                      //     );
                      //
                      //     if (input == null) return;
                      //
                      //     onEdit(
                      //       context,
                      //       id,
                      //       input.nameAr,
                      //       input.nameEn,
                      //       input.imageName,
                      //       input.base64,
                      //       input.status,
                      //       input.removeImage,
                      //       input.cityId,
                      //     );
                      //   } else if (selected == 'delete') {
                      //     final confirmed = await showConfirmDialog(
                      //       context,
                      //       title: deleteDialogTitle,
                      //       message: '$deleteDialogMessage $displayName?',
                      //       confirmText: deleteText,
                      //       cancelText: cancelText,
                      //     );
                      //     if (confirmed) onDelete(context, id);
                      //   }
                      // },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          AppIconManager.dots,
                          width: 20,
                          height: 20,
                          color: AppColorManager.textGrey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImage(coverUrl),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTitleSection(
                        placeName,
                        clientName,
                        cityName,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),
                const Divider(height: 1),

                const SizedBox(height: 10),
                _buildTimeline(nights),

                const SizedBox(height: 10),
                const Divider(height: 1),

                const SizedBox(height: 10),
                _buildInfoGrid(
                  totalPrice: totalPrice,
                  rooms: rooms,
                  adults: adults,
                  children: children,
                ),

                const SizedBox(height: 8),
                _buildBookingDate(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String? coverUrl) {
    final hasImage = coverUrl != null && coverUrl.isNotEmpty;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: hasImage
          ? Image.network(coverUrl, height: 60, width: 60, fit: BoxFit.cover)
          : Container(
              height: 60,
              width: 60,
              color: AppColorManager.backgroundGrey,
              child: const Icon(Icons.hotel, size: 28),
            ),
    );
  }

  Widget _buildTitleSection(
    String placeName,
    String clientName,
    String cityName,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          placeName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColorManager.textAppColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.person_outline, size: 16, color: Colors.grey),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                clientName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColorManager.denim.withOpacity(0.85),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        if (cityName.isNotEmpty) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 16,
                color: Colors.grey,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  cityName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColorManager.textAppColor.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildStatusChip(String statusName, Color statusColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: Text(
        statusName,
        style: TextStyle(
          color: statusColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTimeline(int nights) {
    final nightsText = "${nights > 0 ? nights : 1} ${"nights".tr()}";

    return Row(
      children: [
        Expanded(
          child: _TimelineItem(
            label: "check_in".tr(),
            date: _formatDate(reservation.fromDate),
            icon: Icons.login_rounded,
          ),
        ),
        SizedBox(
          width: 40,
          child: Column(
            children: [
              const Icon(Icons.arrow_forward, size: 18),
              const SizedBox(height: 2),
              Text(
                nightsText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: AppColorManager.textAppColor.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: _TimelineItem(
            label: "check-out".tr(),
            date: _formatDate(reservation.toDate),
            icon: Icons.logout_rounded,
            alignRight: true,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoGrid({
    required String totalPrice,
    required int rooms,
    required int adults,
    required int children,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _InfoTile(
                label: "total_price".tr(),
                value: totalPrice,
                icon: Icons.payments_outlined,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _InfoTile(
                label: "rooms".tr(),
                value: rooms.toString(),
                icon: Icons.meeting_room_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _InfoTile(
                label: "guests".tr(),
                value:
                    "$adults ${"adults".tr()} • $children ${"children".tr()}",
                icon: Icons.group_outlined,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _InfoTile(
                label: "booking_date".tr(),
                value: _formatDate(reservation.createdAt),
                icon: Icons.calendar_today_outlined,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBookingDate() {
    return const SizedBox.shrink();
  }
}

/// Timeline item (check-in / check-out)
class _TimelineItem extends StatelessWidget {
  final String label;
  final String date;
  final IconData icon;
  final bool alignRight;

  const _TimelineItem({
    required this.label,
    required this.date,
    required this.icon,
    this.alignRight = false,
  });

  @override
  Widget build(BuildContext context) {
    final align = alignRight
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    final textAlign = alignRight ? TextAlign.end : TextAlign.start;

    return Column(
      crossAxisAlignment: align,
      children: [
        Row(
          mainAxisAlignment: alignRight
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (!alignRight) ...[
              Icon(icon, size: 18, color: Colors.grey),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (alignRight) ...[
              const SizedBox(width: 4),
              Icon(icon, size: 18, color: Colors.grey),
            ],
          ],
        ),
        const SizedBox(height: 4),
        Text(
          date,
          textAlign: textAlign,
          style: const TextStyle(
            color: AppColorManager.textAppColor,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

/// Info tile (price, rooms, guests, booking date)
class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _InfoTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColorManager.backgroundGrey.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColorManager.textAppColor.withOpacity(0.6),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColorManager.textAppColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
