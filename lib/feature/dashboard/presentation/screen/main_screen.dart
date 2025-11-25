import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:nilz_app/core/resource/icon_manager.dart';
import 'package:nilz_app/core/widget/bar/title_app_bar.dart';
import 'package:nilz_app/feature/dashboard/pending_requests/presentation/widget/pending_req_list.dart';
import 'package:nilz_app/feature/dashboard/res_statistics/presentation/widget/res_statistics_list.dart';
import 'package:nilz_app/feature/drawer/drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool isDrawerOpen = false;

  void toggleDrawer() => setState(() => isDrawerOpen = !isDrawerOpen);

  List<String> get _tabTitles => [
    'statistics'.tr(),
    'pending_requests'.tr(),
    'rating'.tr(),
  ];

  final List<IconData> _tabIcons = [
    Icons.pending_actions,
    Icons.bar_chart,
    Icons.star_rate_outlined,
  ];

  Widget _getCurrentWidget() {
    switch (_selectedIndex) {
      case 0:
        return ResStatisticsList();
      case 1:
        return PendingRequestList();
      default:
        return PendingRequestList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: kToolbarHeight),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    decoration: BoxDecoration(
                      color: AppColorManager.white,
                      border: Border(
                        right: BorderSide(
                          color: AppColorManager.backgroundGrey.withOpacity(
                            0.3,
                          ),
                          width: 5,
                        ),
                      ),
                    ),
                    child: Column(
                      children: List.generate(
                        _tabTitles.length,
                        (index) => _buildNavItem(index),
                      ),
                    ),
                  ),

                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: _getCurrentWidget(),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: kToolbarHeight,
              width: double.infinity,
              child: MainAppBar(
                title: 'dashboard'.tr(),
                showArrowBack: false,
                suffixIcon: GestureDetector(
                  onTap: toggleDrawer,
                  child: SvgPicture.asset(AppIconManager.menu),
                ),
              ),
            ),

            if (isDrawerOpen)
              Positioned.fill(
                child: GestureDetector(
                  onTap: toggleDrawer,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 250),
                    opacity: 1.0,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Container(
                        color: AppColorManager.black.withOpacity(0.2),
                      ),
                    ),
                  ),
                ),
              ),

            AnimatedPositioned(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOut,
              top: 0,
              bottom: 0,
              left: isDrawerOpen ? 0 : -300,
              child: Container(
                width: 300,
                height: double.infinity,
                color: AppColorManager.white,
                child: const MyDrawer(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final isSelected = _selectedIndex == index;

    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: isSelected ? AppColorManager.denim : Colors.transparent,
              width: 4,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _tabIcons[index],
              color: isSelected
                  ? AppColorManager.denim
                  : AppColorManager.textAppColor.withOpacity(0.5),
              size: 20,
            ),
            const SizedBox(height: 12),
            RotatedBox(
              quarterTurns: 1,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  _tabTitles[index],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(
                    color: isSelected
                        ? AppColorManager.denim
                        : AppColorManager.textAppColor.withOpacity(0.6),
                    fontSize: 11,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
