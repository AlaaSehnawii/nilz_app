import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:nilz_app/core/resource/icon_manager.dart';
import 'package:nilz_app/core/widget/text/app_text_widget.dart';
import 'package:nilz_app/feature/dashboard/res_statistics/domain/entity/response/res_statistics_entity.dart';

class ResStatisticsContainer extends StatelessWidget {
  final String title;
  final ResStatisticsCategoryEntity data;

  const ResStatisticsContainer({
    super.key,
    required this.title,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final total = data.totalCount ?? 0;
    final countDiff = data.countDifference ?? 0;
    final trendUp = (data.trend ?? '').toLowerCase() == 'up';
    final pct = data.percentageChange;
    final pctText = pct != null ? '${pct.toStringAsFixed(1)}%' : '-';

    return Card(
      elevation: 1.5,
      margin: const EdgeInsets.all(0),
      color: AppColorManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: AppColorManager.backgroundGrey.withOpacity(0.7),
          width: 1,
        ),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 120),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$total',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColorManager.denim,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 4),

              AppTextWidget(
                text: title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColorManager.textAppColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 10),


              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$countDiff ',
                    style: const TextStyle(
                      color: AppColorManager.textAppColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),


                  if (data.trend != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: SvgPicture.asset(
                        trendUp
                            ? AppIconManager.trendingUp
                            : AppIconManager.trendingDown,
                        width: 18,
                        height: 18,
                        colorFilter: ColorFilter.mode(
                          trendUp ? Colors.green : Colors.red,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),

                  Flexible(
                    child: Text(
                      '$pctText ${"this_month".tr()}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColorManager.textAppColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
