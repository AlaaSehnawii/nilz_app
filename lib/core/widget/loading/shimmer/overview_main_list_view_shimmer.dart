import 'package:flutter/cupertino.dart';

import '../../../resource/color_manager.dart';
import '../../../resource/size_manager.dart';
import '../../../resource/theme_manager.dart';
import '../../container/shimmer_container.dart';

class OverviewListViewShimmer extends StatelessWidget {
  const OverviewListViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,


      children: [
        Row(

           children: [
            ShimmerContainer(
              width: AppWidthManager.w20,
              height: AppHeightManager.h4,
            ),
            SizedBox(
              width: AppHeightManager.h1,
            ),
            ShimmerContainer(
              width: AppWidthManager.w20,
              height: AppHeightManager.h4,
            ),
            SizedBox(
              width: AppHeightManager.h1,
            ),
            ShimmerContainer(
              width: AppWidthManager.w20,
              height: AppHeightManager.h4,
            ),


             SizedBox(
               width: AppHeightManager.h1,
             ),
             ShimmerContainer(
               width: AppWidthManager.w20,
               height: AppHeightManager.h4,
             ),


           ],
        ),
SizedBox(
  height: AppHeightManager.h5,
),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: ThemeManager.cardShadow,
              color: AppColorManager.white,
              borderRadius: BorderRadius.all(
                Radius.circular(AppRadiusManager.r20),
              ),
            ),
            width: AppWidthManager.w100,
            height: AppHeightManager.h40,

            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ShimmerContainer(
                            width: AppWidthManager.w38,
                            height: AppHeightManager.h15,
                          ),
                          SizedBox(
                            width: AppHeightManager.h2,
                          ),
                          ShimmerContainer(
                            width: AppWidthManager.w38,
                            height: AppHeightManager.h15,
                          ),
                          SizedBox(
                            width: AppHeightManager.h2,
                          ),
                        ],
                      ),
                    ],
                  )
                );
              },
            ),
          ),
        ),



      ],
    );
  }
}
