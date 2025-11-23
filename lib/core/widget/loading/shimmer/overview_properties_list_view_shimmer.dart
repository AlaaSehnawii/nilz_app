import 'package:flutter/cupertino.dart';

import '../../../resource/color_manager.dart';
import '../../../resource/size_manager.dart';
import '../../../resource/theme_manager.dart';
import '../../container/shimmer_container.dart';

class PropertiesListViewShimmer extends StatelessWidget {
  const PropertiesListViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: AppWidthManager.w90,
          height: AppHeightManager.h80,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(
              vertical: AppHeightManager.h1point8,
              horizontal: AppWidthManager.w2,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColorManager.white,
                  boxShadow: ThemeManager.cardShadow,
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppRadiusManager.r20),
                  ),
                ),
                height: AppHeightManager.h30,
                width: AppWidthManager.w80,
                margin: EdgeInsets.only(bottom: AppHeightManager.h1point8),
                padding: EdgeInsets.all(AppWidthManager.w3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(height: AppHeightManager.h8),
                            ShimmerContainer(
                              width: AppWidthManager.w20,
                              height: AppHeightManager.h2point5,
                            ),
                            SizedBox(width: AppWidthManager.w1),
                            ShimmerContainer(
                              width: AppWidthManager.w10,
                              height: AppHeightManager.h2point5,
                            ),
                          ],
                        ),
                        ShimmerContainer(
                          width: AppWidthManager.w20,
                          height: AppHeightManager.h2point5,
                        ),
                      ],
                    ),
                    SizedBox(height: AppHeightManager.h1point8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ShimmerContainer(
                          width: AppWidthManager.w35,
                          height: AppHeightManager.h2,
                        ),
                      ],
                    ),
                    SizedBox(height: AppHeightManager.h3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ShimmerContainer(
                              width: AppWidthManager.w15,
                              height: AppHeightManager.h2,
                            ),
                            SizedBox(width: AppWidthManager.w1),
                            ShimmerContainer(
                              width: AppWidthManager.w15,
                              height: AppHeightManager.h2,
                            ),
                          ],
                        ),
                        ShimmerContainer(
                          width: AppWidthManager.w20,
                          height: AppHeightManager.h2,
                        ),
                      ],
                    ),
                    SizedBox(height: AppHeightManager.h2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            ShimmerContainer(
                              width: AppWidthManager.w5,
                              height: AppHeightManager.h2,
                            ),
                            SizedBox(width: AppWidthManager.w25),
                            ShimmerContainer(
                              width: AppWidthManager.w35,
                              height: AppHeightManager.h2,
                            ),
                          ],
                        ),
                        SizedBox(width: AppWidthManager.w3),
                      ],
                    ),
                    SizedBox(height: AppHeightManager.h3),
                    Row(
                      children: [
                        ShimmerContainer(
                          width: AppWidthManager.w5,
                          height: AppHeightManager.h2,
                        ),
                        SizedBox(width: AppWidthManager.w5),
                        ShimmerContainer(
                          width: AppWidthManager.w15,
                          height: AppHeightManager.h2,
                        ),
                        SizedBox(width: AppWidthManager.w10),
                        ShimmerContainer(
                          width: AppWidthManager.w5,
                          height: AppHeightManager.h2,
                        ),
                        SizedBox(width: AppWidthManager.w5),
                        ShimmerContainer(
                          width: AppWidthManager.w15,
                          height: AppHeightManager.h2,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}