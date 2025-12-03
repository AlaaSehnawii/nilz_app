import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:nilz_app/core/resource/icon_manager.dart';
import 'package:nilz_app/core/widget/button/main_app_button.dart';
import 'package:nilz_app/feature/reservation/domain/entity/response/unit_entity.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UnitDetailsScreen extends StatelessWidget {
  final UnitEntity unit;

  const UnitDetailsScreen({Key? key, required this.unit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final parent = unit.parent;

    String localized(LocalizedName? name) => name?.en ?? name?.ar ?? '';

    String normalizeUrl(String? url) =>
        (url == null || url.isEmpty) ? '' : url.replaceAll('files//', 'files/');

    final name = localized(unit.name);
    final description = unit.description?.en ?? unit.description?.ar ?? '';
    final roomTypeLabel = unit.unitType;
    final nightCount = unit.nightCount ?? 1;
    final isReservable = unit.reservable ?? false;
    final isFeatured = unit.featured ?? false;
    final city = unit.city?.name?.en;
    final address = unit.address ?? 'Address is not available';

    final String parentName = localized(parent?.name);
    final String parentDescription =
        parent?.description?.en ?? parent?.description?.ar ?? '';
    final stars = unit.stars ?? 0;
    final hotelTotalRating = unit.totalRating ?? 0;

    final price = unit.price;
    final bool hasBreakfast = unit.hasBreakfast ?? false;
    final List<BreakfastPrice> breakfastPrices = unit.breakfastPrice;

    final adultCount = unit.adultCount ?? 0;
    final childCount = unit.childCount ?? 0;
    final roomCount = unit.roomCount ?? 1;
    final bathroomCount = unit.bathroomCount ?? 1;
    final maxExtraBed = unit.maxExtraBedCount ?? 0;
    final approvedRes = unit.approvedReservationCount ?? 0;
    final cancelledRes = unit.cancelledReservationCount ?? 0;

    final List<UnitRoomConf> roomConfigs = unit.roomConf;
    final UnitRoomConf? mainRoomConfig = roomConfigs.isNotEmpty
        ? roomConfigs.first
        : null;

    final String mainRoomTypeName = localized(mainRoomConfig?.roomType?.name);
    final int mainRoomAdult = mainRoomConfig?.adultCount ?? adultCount;
    final int mainRoomChild = mainRoomConfig?.childCount ?? childCount;

    final List<BedConf> bedConfigs = mainRoomConfig?.bedConf ?? [];
    final BedConf? firstBed = bedConfigs.isNotEmpty ? bedConfigs.first : null;
    final int firstBedCount = firstBed?.count ?? 0;
    final String firstBedTypeName = localized(firstBed?.bedType?.name);

    final String coverImageUrl = normalizeUrl(unit.coverImage?.url);
    final String unitLogoUrl = normalizeUrl(unit.logo?.url);

    final List<FileInfo> unitGallery = unit.gallery;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              coverImageUrl != null && coverImageUrl.isNotEmpty
                  ? AspectRatio(
                      aspectRatio: 16 / 8,
                      child: Image.network(
                        coverImageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  : AspectRatio(
                      aspectRatio: 16 / 8,
                      child: Container(
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.hotel,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                    ),

              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black87.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        stars.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              if (hasBreakfast)
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColorManager.green,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Text(
                        'Breakfast included',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      stars.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        parentName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
                Text(
                  city ?? '',
                  style: TextStyle(fontSize: 12, color: AppColorManager.denim),
                ),
                const SizedBox(height: 10),

                Container(height: 1, color: Colors.grey[200]),
                const SizedBox(height: 8),

                const Text(
                  'Public information',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(Icons.bed, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      '$roomCount Room',
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.person, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      '$adultCount Adult',
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.child_care, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      '$childCount Children',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price ?? '',
                      style: TextStyle(
                        color: AppColorManager.denim,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    MainAppButton(
                      child: Container(
                        height: 5.h,
                        width: 15.h,
                        decoration: BoxDecoration(
                          color: AppColorManager.denim,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "book_now".tr(),
                                style: TextStyle(
                                  color: AppColorManager.background,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 1.w),
                              SvgPicture.asset(
                                AppIconManager.arrowRight,
                                color: AppColorManager.background,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
