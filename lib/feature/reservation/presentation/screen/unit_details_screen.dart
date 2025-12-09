// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:nilz_app/core/widget/bar/title_app_bar.dart';
import 'package:nilz_app/feature/reservation/domain/entity/response/unit_entity.dart';
import 'package:nilz_app/feature/reservation/presentation/widget/unit/unit_gallery_widget.dart';
import 'package:nilz_app/feature/reservation/presentation/widget/unit/unit_header_wedget.dart';
import 'package:nilz_app/feature/reservation/presentation/widget/unit/unit_info_chips_row.dart';
import 'package:nilz_app/feature/reservation/presentation/widget/unit/unit_price_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UnitDetailsScreen extends StatelessWidget {
  final UnitEntity unit;

  const UnitDetailsScreen({super.key, required this.unit});

  @override
  Widget build(BuildContext context) {
    // ---- Helpers ----
    String localized(LocalizedName? name) => name?.en ?? name?.ar ?? '';
    String normalizeUrl(String? url) =>
        (url == null || url.isEmpty) ? '' : url.replaceAll('files//', 'files/');

    final parent = unit.parent;

    // ---- Basic info ----
    final String name = localized(unit.name);
    final String city = localized(unit.city?.name);
    final String address = unit.address ?? 'Address not available';
    final String hotelName = localized(parent?.name);
    final num stars = unit.stars ?? 0;
    final totalRating = unit.totalRating ?? 0;
    final String price = unit.price ?? 'N/A';
    final bool hasBreakfast = unit.hasBreakfast ?? false;
    final int nightCount = (unit.nightCount ?? 1).toInt();
    final bool isReservable = unit.reservable ?? false;

    // ---- Capacity ----
    final int adultCount = unit.adultCount ?? 2;
    final int childCount = unit.childCount ?? 0;
    final int roomCount = unit.roomCount ?? 1;

    // ---- Room & Bed Info ----
    final List<UnitRoomConf> roomConfigs = unit.roomConf;
    final UnitRoomConf? mainRoomConfig =
        roomConfigs.isNotEmpty ? roomConfigs.first : null;
    final int bedCount = mainRoomConfig?.bedConf.firstOrNull?.count ?? 1;

    // ---- Gallery images ----
    final List<String> galleryImages = {
      if (unit.coverImage?.url != null) normalizeUrl(unit.coverImage!.url),
      ...unit.gallery
          .map((file) => normalizeUrl(file.url))
          .where((url) => url.isNotEmpty),
    }.toList();

    final bool hasImages = galleryImages.isNotEmpty;

    return Scaffold(
      appBar: const MainAppBar(
        title: "",
        showArrowBack: true,
        showSuffixIcon: false,
      ),

      body: Column(
        children: [
          Expanded(
            child: Card(
              margin:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
              elevation: 10,
              shadowColor: Colors.black.withOpacity(0.12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UnitGallerySection(
                    galleryImages: galleryImages,
                    hasImages: hasImages,
                    hotelName: hotelName,
                    hasBreakfast: hasBreakfast,
                    stars: stars,
                  ),
            
                  Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UnitHeaderSection(
                          unitName: name,
                          totalRating: totalRating,
                          city: city,
                          address: address,
                        ),
                        SizedBox(height: 4.h),
            
                        UnitInfoChipsRow(
                          bedCount: bedCount,
                          adultCount: adultCount,
                          childCount: childCount,
                          roomCount: roomCount,
                        ),
            
                        SizedBox(height: 3.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(7.w, 1.h, 4.w, 2.h),
            child: UnitPriceAndButton(
              price: price,
              nightCount: nightCount,
              isReservable: isReservable,
            ),
          ),
        ],
      ),
    );
  }
}
