import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:nilz_app/feature/dashboard/presentation/screen/main_screen.dart';
import 'package:nilz_app/feature/dashboard/rating_statistics/presentation/cubit/rating_statistics_cubit.dart';
import 'package:nilz_app/feature/menus/ui/screen/menus_screen.dart';
import 'package:nilz_app/feature/reservation/presentation/cubit/reservation_cubit.dart';
import 'package:nilz_app/feature/reservation/presentation/screen/reservation_list_screen.dart';
import '../../core/injection/injection_container.dart' as di;
import '../../core/resource/icon_manager.dart';
import '../../core/widget/dialog/confirmation_dialog.dart';
import '../auth/login/presentation/cubit/login_cubit/login_cubit.dart';
import '../drawer/drawer.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int page = 1;

  late final List<Widget> _pages = <Widget>[
    MenusScreen(),
    BlocProvider(
      create: (_) => di.sl<ResStatisticsCubit>(),
      child: const MainScreen(),
    ),
    BlocProvider(
      create: (_) => di.sl<ReservationCubit>(),
      child: const ReservationListScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (_) => di.sl<LoginCubit>()),
        //  --------------------------global cubits here
      ],
      // ignore: deprecated_member_use
      child: WillPopScope(
        onWillPop: () async {
          final result = await showConfirmDialog(
            context,
            title: "exit_app".tr(),
            message: "are_you_sure_you_want_to_exit".tr(),
            confirmText: "Yes",
            cancelText: "No",
            confirmColor: AppColorManager.denim,
            cancelColor: AppColorManager.denim,
            barrierDismissible: false,
          );
          if (result) {
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else if (Platform.isIOS) {
              exit(0);
            }
          }
          return false;
        },
        child: Scaffold(
          drawer: const MyDrawer(),
          body: _pages.elementAt(page),

          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _buildCenterFab(),

          bottomNavigationBar: _buildBottomBar(context),
        ),
      ),
    );
  }

  // -------- UI pieces

  Widget _buildCenterFab() {
    return Container(
      width: 74,
      height: 74,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () => setState(() => page = 1),
          elevation: 0,
          backgroundColor: AppColorManager.denim,
          child: SvgPicture.asset(AppIconManager.home, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
        child: BottomAppBar(
          color: AppColorManager.background,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          elevation: 10,
          child: SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: _NavItem(
                    icon: AppIconManager.menus,
                    label: "menus".tr(),
                    selected: page == 0,
                    onTap: () => setState(() => page = 0),
                  ),
                ),
                const SizedBox(width: 72),
                Expanded(
                  child: _NavItem(
                    icon: AppIconManager.reservations,
                    label: "reservations".tr(),
                    selected: page == 2,
                    onTap: () => setState(() => page = 2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color iconColor = selected
        ? AppColorManager.denim
        : AppColorManager.grey.withOpacity(0.6);
    final Color textColor = selected
        ? AppColorManager.denim
        : AppColorManager.grey.withOpacity(0.6);
    final FontWeight textWeight = selected ? FontWeight.w700 : FontWeight.w500;

    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ignore: deprecated_member_use
          SvgPicture.asset(icon, color: iconColor, height: 30, width: 30),
          Text(
            label,
            style: TextStyle(
              fontSize: 17,
              color: textColor,
              fontWeight: textWeight,
            ),
          ),
        ],
      ),
    );
  }
}
