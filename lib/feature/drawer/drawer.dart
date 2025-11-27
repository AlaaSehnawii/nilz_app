// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:nilz_app/core/resource/icon_manager.dart';
import 'package:nilz_app/feature/drawer/basic_data/bed_types/presentation/cubit/bed_type_cubit.dart';
import 'package:nilz_app/feature/drawer/basic_data/post_category/presentation/cubit/post_category_cubit.dart';
import 'package:nilz_app/feature/drawer/basic_data/reservation_type/presentation/cubit/reservation_type_cubit.dart';
import 'package:nilz_app/feature/drawer/basic_data/reservation_type/presentation/ui/screen/reservation_type_list_screen.dart';
import 'package:nilz_app/feature/drawer/basic_data/service/presentation/cubit/service_cubit.dart';
import 'package:nilz_app/feature/drawer/basic_data/service/presentation/ui/screen/service_list_screen.dart';
import 'package:nilz_app/feature/drawer/finance/payment/presentation/cubit/payment_cubit.dart';
import '../../core/injection/injection_container.dart' as di;
import '../../core/widget/dialog/confirmation_dialog.dart';
import '../auth/login/presentation/cubit/login_cubit/login_cubit.dart';
import 'basic_data/bed_types/presentation/ui/screen/bed_type_list_screen.dart';
import 'basic_data/city/presentation/cubit/city_cubit.dart';
import 'basic_data/city/presentation/ui/screen/city_list_screen.dart';
import 'basic_data/place_types/presentation/cubit/place_type_cubit.dart';
import 'basic_data/place_types/presentation/ui/screen/place_type_list_screen.dart';
import 'basic_data/post_category/presentation/ui/screen/post_category_list_screen.dart';
import 'basic_data/room_types/presentation/cubit/room_type_cubit.dart';
import 'basic_data/room_types/presentation/ui/screen/room_type_list_screen.dart';
import 'basic_data/unit_types/presentation/cubit/unit_type_cubit.dart';
import 'basic_data/unit_types/presentation/ui/screen/unit_type_list_screen.dart';
import 'finance/gift/presentation/cubit/gift_cubit.dart';
import 'finance/gift/presentation/ui/screen/gift_list_screen.dart';
import 'finance/payment/presentation/ui/screen/payment_list_screen.dart';

class MyDrawer extends StatefulWidget {
  final int? id;

  const MyDrawer({super.key, this.id});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  int? _hoveredIndex;
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppColorManager.background,
        boxShadow: [
          BoxShadow(
            color: AppColorManager.textAppColor.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(10, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: SvgPicture.asset(AppIconManager.nilz),
          ),
          const Divider(height: 20, color: AppColorManager.grey),
          Expanded(child: _buildMenuItems()),
          _buildBottomItem(),
        ],
      ),
    );
  }

  Widget _buildBottomItem() {
    final bottomItems = [
      _BottomItem(
        icon: SvgPicture.asset(
          AppIconManager.phone,
          color: AppColorManager.textGrey,
        ),
        title: "contact_us".tr(),
        isLogout: false,
        onTap: () {},
      ),
      _BottomItem(
        icon: SvgPicture.asset(
          AppIconManager.shield,
          color: AppColorManager.textGrey,
        ),
        title: "general_settings".tr(),
        isLogout: false,
        onTap: () {},
      ),
      _BottomItem(
        icon: SvgPicture.asset(
          AppIconManager.logout,
          color: AppColorManager.textGrey,
        ),
        title: "logout".tr(),
        isLogout: true,
        onTap: () async {
          final result = await showConfirmDialog(
            context,
            title: "logout".tr(),
            message: "are_you_sure_you_want_to_logout".tr(),
            confirmText: "logout".tr(),
            cancelText: "cancel".tr(),
            confirmColor: AppColorManager.denim,
            cancelColor: AppColorManager.denim,
            barrierDismissible: false,
          );

          if (result) {
            // ignore: use_build_context_synchronously
            context.read<LoginCubit>().logout(context);
          }
        },
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: bottomItems.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: item.onTap,
                child: Row(
                  children: [
                    SizedBox(height: 29, width: 29, child: item.icon),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Text(
                        item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColorManager.textGrey,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMenuItems() {
    final menuItems = [
      _MenuItem(
        icon: SvgPicture.asset(
          AppIconManager.menus,
          color: AppColorManager.textGrey,
        ),
        title: "menus".tr(),
        isLogout: false,
        children: [
          SubItem(title: "Reservation_type".tr(), onTap: () => debugPrint("A")),
          SubItem(title: "city".tr(), onTap: () => debugPrint("B")),
          SubItem(title: "bed_type".tr(), onTap: () => debugPrint("C")),
          SubItem(title: "post_category".tr(), onTap: () => debugPrint("C")),
          SubItem(title: "room_type".tr(), onTap: () => debugPrint("C")),
          SubItem(title: "service".tr(), onTap: () => debugPrint("C")),
          SubItem(title: "place_type".tr(), onTap: () => debugPrint("C")),
          SubItem(title: "reservation_type".tr(), onTap: () => debugPrint("C")),
        ],
      ),
      _MenuItem(
        icon: SvgPicture.asset(
          AppIconManager.management,
          color: AppColorManager.textGrey,
        ),
        title: "management".tr(),
        isLogout: false,
        children: [
          SubItem(title: "Users", onTap: () => debugPrint("Users")),
          SubItem(title: "Roles", onTap: () => debugPrint("Roles")),
        ],
      ),
      _MenuItem(
        icon: SvgPicture.asset(
          AppIconManager.finance,
          color: AppColorManager.textGrey,
        ),
        title: "finance".tr(),
        isLogout: false,
        children: [
          SubItem(
            title: "random_gifts".tr(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) =>
                        di.sl<GiftCubit>()..getGift(context: context),
                    child: const GiftListScreen(),
                  ),
                ),
              );
            },
          ),
          SubItem(
            title: "payments_management".tr(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) =>
                        di.sl<PaymentCubit>()..getPayment(context: context),
                    child: const PaymentListScreen(),
                  ),
                ),
              );
            },
          ),
          SubItem(
            title: "discount_based_on_classification".tr(),
            onTap: () => debugPrint("Invoices"),
          ),
          SubItem(title: "coupons".tr(), onTap: () => debugPrint("Invoices")),
        ],
      ),
      _MenuItem(
        icon: SvgPicture.asset(
          AppIconManager.data,
          color: AppColorManager.textGrey,
        ),
        title: "basic_data".tr(),
        isLogout: false,
        children: [
          SubItem(
            title: "unit_type".tr(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) =>
                        di.sl<UnitTypeCubit>()..getUnitType(context: context),
                    child: const UnitTypeListScreen(),
                  ),
                ),
              );
            },
          ),
          SubItem(
            title: "city".tr(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) =>
                        di.sl<CityCubit>()..getCity(context: context),
                    child: const CityListScreen(),
                  ),
                ),
              );
            },
          ),
          SubItem(
            title: "bed_type".tr(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) =>
                        di.sl<BedTypeCubit>()..getBedType(context: context),
                    child: const BedTypeListScreen(),
                  ),
                ),
              );
            },
          ),
          SubItem(
            title: "post_category".tr(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) =>
                        di.sl<PostCategoryCubit>()
                          ..getPostCategory(context: context),
                    child: const PostCategoryListScreen(),
                  ),
                ),
              );
            },
          ),
          SubItem(
            title: "room_type".tr(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) =>
                        di.sl<RoomTypeCubit>()..getRoomType(context: context),
                    child: const RoomTypeListScreen(),
                  ),
                ),
              );
            },
          ),
          SubItem(
            title: "service".tr(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (_) =>
                            di.sl<ServiceCubit>()..getService(context: context),
                      ),
                      BlocProvider(
                        create: (_) =>
                            di.sl<CityCubit>()..getCity(context: context),
                      ),
                    ],
                    child: const ServiceListScreen(),
                  ),
                ),
              );
            },
          ),
          SubItem(
            title: "place_type".tr(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) =>
                        di.sl<PlaceTypeCubit>()..getPlaceType(context: context),
                    child: const PlaceTypeListScreen(),
                  ),
                ),
              );
            },
          ),
          SubItem(
            title: "reservation_type".tr(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) =>
                        di.sl<ReservationTypeCubit>()
                          ..getReservationType(context: context),
                    child: const ReservationTypeListScreen(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      itemCount: menuItems.length,
      itemBuilder: (context, index) => _buildMenuItem(menuItems[index], index),
    );
  }

  Widget _buildMenuItem(_MenuItem item, int index) {
    final isHovered = _hoveredIndex == index;
    final isExpanded = _expandedIndex == index;
    final isLogout = item.isLogout;

    return Column(
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => _hoveredIndex = index),
          onExit: (_) => setState(() => _hoveredIndex = null),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              if (item.children.isEmpty) return;

              setState(() {
                if (isExpanded) {
                  _expandedIndex = null;
                } else {
                  _expandedIndex = index;
                }
              });
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Row(
                children: [
                  SizedBox(height: 26, width: 26, child: item.icon),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Text(
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: isHovered
                            ? FontWeight.w700
                            : FontWeight.w600,
                        color: isLogout ? Colors.red : AppColorManager.textGrey,
                      ),
                    ),
                  ),
                  if (item.children.isNotEmpty)
                    AnimatedRotation(
                      turns: isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: SvgPicture.asset(
                        AppIconManager.arrowMenuDown,
                        color: AppColorManager.grey,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),

        // ======== children list ===============
        if (isExpanded && item.children.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              children: List.generate(
                item.children.length,
                (i) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: item.children[i].onTap,
                    child: Row(
                      children: [
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            item.children[i].title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColorManager.black,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _BottomItem {
  final Widget icon;
  final String title;
  final bool isLogout;
  final VoidCallback onTap;

  _BottomItem({
    required this.icon,
    required this.title,
    required this.isLogout,
    required this.onTap,
  });
}

class _MenuItem {
  final Widget icon;
  final String title;
  final bool isLogout;
  final List<SubItem> children;

  _MenuItem({
    required this.icon,
    required this.title,
    required this.isLogout,
    required this.children,
  });
}

class SubItem {
  final String title;
  final VoidCallback onTap;

  SubItem({required this.title, required this.onTap});
}
