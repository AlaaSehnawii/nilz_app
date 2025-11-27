// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:nilz_app/feature/dashboard/pending_requests/presentation/widget/pending_req_list.dart';
import 'package:nilz_app/feature/dashboard/res_statistics/presentation/widget/res_statistics_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

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
        return const ResStatisticsList();
      case 1:
        return const PendingRequestList();
      default:
        return const PendingRequestList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // 👇 IMPORTANT: only protect the top; don't add bottom padding
      top: true,
      bottom: false,
      child: Row(
        children: [
          // LEFT SIDE VERTICAL TABS
          Container(
            width: 30,
            decoration: BoxDecoration(
              color: AppColorManager.white,
              border: Border(
                right: BorderSide(
                  color: AppColorManager.backgroundGrey.withOpacity(0.3),
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

          // RIGHT SIDE CONTENT
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _getCurrentWidget(),
            ),
          ),
        ],
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
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.w500,
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
