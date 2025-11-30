// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nilz_app/feature/auth/login/presentation/cubit/login_cubit/login_cubit.dart';

import 'package:nilz_app/feature/dashboard/presentation/screen/main_screen.dart';
import 'package:nilz_app/feature/dashboard/rating_statistics/presentation/cubit/rating_statistics_cubit.dart';
import 'package:nilz_app/feature/drawer/drawer.dart';
import 'package:nilz_app/feature/posts/presentation/cubit/post_cubit.dart';
import 'package:nilz_app/feature/posts/presentation/ui/screen/post_list_screen.dart';
import 'package:nilz_app/feature/reservation/presentation/cubit/reservation_cubit.dart';
import 'package:nilz_app/feature/reservation/presentation/screen/reservation_list_screen.dart';

import '../../../core/resource/color_manager.dart';
import '../../../core/resource/icon_manager.dart';
import '../../../core/widget/dialog/confirmation_dialog.dart';
import '../../../core/widget/bar/title_app_bar.dart';
import '../../../core/injection/injection_container.dart' as di;

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int page = 1;

  final List<String> _titles = [
    "advertisements".tr(),
    "dashboard".tr(),
    "reservations".tr(),
  ];

  late final List<Widget> _pages = [
    BlocProvider(create: (_) => di.sl<PostCubit>(), child: const PostListScreen()),
    BlocProvider(create: (_) => di.sl<ResStatisticsCubit>(), child: const MainScreen()),
    BlocProvider(create: (_) => di.sl<ReservationCubit>(), child: const ReservationListScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (_) => di.sl<LoginCubit>()),
      ],
      child: WillPopScope(
        onWillPop: () async {
          final result = await showConfirmDialog(
            context,
            title: "exit_app".tr(),
            message: "are_you_sure_you_want_to_exit".tr(),
            confirmText: "Yes",
            cancelText: "No",
            confirmColor: AppColorManager.denim,
            cancelColor: AppColorManager.red,
            barrierDismissible: false,
          );
      
          if (result) {
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else {
              exit(0);
            }
          }
          return false;
        },
        child: Scaffold(
          key: _scaffoldKey,
          drawer: const MyDrawer(),
      
          appBar: MainAppBar(
            title: _titles[page],
            showArrowBack: false,
            showSuffixIcon: true,
            suffixIcon: GestureDetector(
              onTap: () => _scaffoldKey.currentState?.openDrawer(),
              child: SvgPicture.asset(AppIconManager.menu),
            ),
          ),
      
          body: _pages[page],
      
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _buildCenterFab(),
      
          bottomNavigationBar: _buildBottomBar(),
        ),
      ),
    );
  }

  Widget _buildCenterFab() {
    return Container(
      width: 74,
      height: 74,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: AppColorManager.denim,
        elevation: 5,
        onPressed: () => setState(() => page = 1),
        child: SvgPicture.asset(AppIconManager.home, color: Colors.white),
      ),
    );
  }

  Widget _buildBottomBar() {
    return BottomAppBar(
      notchMargin: 8,
      shape: const CircularNotchedRectangle(),
      color: AppColorManager.background,
      child: SizedBox(
        height: 65,
        child: Row(
          children: [
            _bottomItem(0, AppIconManager.advertisement, "advertisements".tr()),
            const Spacer(),
            _bottomItem(2, AppIconManager.reservations, "reservations".tr()),
          ],
        ),
      ),
    );
  }

  Widget _bottomItem(int index, String icon, String label) {
    final bool selected = page == index;

    return GestureDetector(
      onTap: () => setState(() => page = index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              color: selected ? AppColorManager.denim : AppColorManager.grey,
            ),
            Text(
              label,
              style: TextStyle(
                color: selected ? AppColorManager.denim : AppColorManager.grey,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
