// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:nilz_app/core/resource/icon_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UnitGallerySection extends StatelessWidget {
  final List<String> galleryImages;
  final bool hasImages;
  final String hotelName;
  final num stars;
  final bool hasBreakfast;

  const UnitGallerySection({
    super.key,
    required this.galleryImages,
    required this.hasImages,
    required this.hotelName,
    required this.stars,
    required this.hasBreakfast,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.h,
      width: double.infinity,
      child: Stack(
        children: [
          // ──────── SLIDER BACKGROUND ────────
          ClipRRect(
            // Card above already clips, but this guarantees no overflow
            borderRadius: BorderRadius.circular(0),
            child: hasImages
                ? CarouselSlider.builder(
                    itemCount: galleryImages.length,
                    itemBuilder: (context, index, realIndex) {
                      final imageUrl = galleryImages[index];
                      return CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (_, __) => Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                        errorWidget: (_, __, ___) => Container(
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.broken_image,
                            size: 60,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: double.infinity,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false, // important
                      autoPlay: galleryImages.length > 1,
                      autoPlayInterval: const Duration(seconds: 5),
                      enableInfiniteScroll: galleryImages.length > 1,
                    ),
                  )
                : Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.hotel, size: 80, color: Colors.white70),
                    ),
                  ),
          ),

          // ──────── GRADIENT OVERLAY ────────
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),
          ),

          // ──────── STAR BADGE ────────
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColorManager.amber, width: 2),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    AppIconManager.star,
                    color: AppColorManager.amber,
                    height: 2.5.h,
                    width: 2.5.h,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    stars.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ──────── BREAKFAST BADGE ────────
          if (hasBreakfast)
            Positioned(
              bottom: 50,
              left: 16,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColorManager.green,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.local_dining,
                        color: Colors.white, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'breakfast_included'.tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // ──────── HOTEL NAME ────────
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Text(
              hotelName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                shadows: const [
                  Shadow(
                    blurRadius: 10,
                    color: Colors.black87,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
