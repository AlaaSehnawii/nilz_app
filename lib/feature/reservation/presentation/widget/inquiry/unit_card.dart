// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:nilz_app/feature/reservation/domain/entity/response/unit_entity.dart';

class UnitCard extends StatelessWidget {
  final UnitEntity unit;
  final bool isArabic;
  final VoidCallback? onTap;

  const UnitCard({
    super.key,
    required this.unit,
    required this.isArabic,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final unitName = isArabic
        ? (unit.name?.ar ?? unit.name?.en ?? '')
        : (unit.name?.en ?? unit.name?.ar ?? '');

    final cityName = isArabic
        ? (unit.city?.name?.ar ?? unit.city?.name?.en ?? '')
        : (unit.city?.name?.en ?? unit.city?.name?.ar ?? '');

    final parentName = isArabic
        ? (unit.parent?.name?.ar ?? unit.parent?.name?.en ?? '')
        : (unit.parent?.name?.en ?? unit.parent?.name?.ar ?? '');

    final price = unit.price ?? '';
    final coverUrl = unit.coverImage?.url;

    final int stars = (unit.stars ?? 0).toInt();
    final bool hasBreakfast = unit.hasBreakfast ?? false;

    final int roomsCount = unit.roomCount ?? 1;
    final int adultsCount = unit.adultCount ?? 2;
    final int childrenCount = unit.childCount ?? 0;
    final double distanceKm = (unit.cityDistance ?? 0).toDouble();

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                coverUrl != null && coverUrl.isNotEmpty
                    ? AspectRatio(
                        aspectRatio: 16 / 8,
                        child: Image.network(
                          coverUrl,
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
                          unitName,
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
                    cityName,
                    style: TextStyle(fontSize: 12, color: AppColorManager.denim),
                  ),
                  if (distanceKm > 0) ...[
                    const SizedBox(height: 2),
                    Text(
                      '${distanceKm.toStringAsFixed(1)} KM from city center',
                      style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                    ),
                  ],
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
                        '$roomsCount Room',
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.person, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        '$adultsCount Adult',
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.child_care, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        '$childrenCount Children',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
      
                  const SizedBox(height: 12),
      
                  Text(
                    price,
                    style: TextStyle(
                      color: AppColorManager.denim,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
