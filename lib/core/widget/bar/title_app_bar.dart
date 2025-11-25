import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../helper/language_helper.dart';
import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/icon_manager.dart';
import '../../resource/size_manager.dart';
import '../text/app_text_widget.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    required this.title,
    this.showArrowBack,
    this.suffixIcon,
    this.showSuffixIcon,
  });

  final String title;
  final Widget? suffixIcon;
  final bool? showArrowBack;
  final bool? showSuffixIcon;

  @override
  Size get preferredSize => Size.fromHeight(AppHeightManager.h9);

  @override
  Widget build(BuildContext context) {
    final isLtr = LanguageHelper.checkIfLTR(context: context);

    return AppBar(
      surfaceTintColor: AppColorManager.white,
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Row(
        children: [
          if (showArrowBack ?? true)
            InkWell(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset(
                isLtr ? AppIconManager.arrowLeft : AppIconManager.arrowRight,
                colorFilter: const ColorFilter.mode(
                  AppColorManager.black,
                  BlendMode.srcIn,
                ),
              ),
            ),
          SizedBox(width: AppWidthManager.w2),
          AppTextWidget(
            text: title,
            fontSize: FontSizeManager.fs18,
            color: AppColorManager.black,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        if (showSuffixIcon ?? true)
          Padding(
            padding: EdgeInsets.only(
              right: isLtr ? AppWidthManager.w5point7 : 0,
              left: !isLtr ? AppWidthManager.w5point7 : 0,
            ),
            child: AppBarMenuButton(
              icon: SvgPicture.asset(
                AppIconManager.nilz,
                colorFilter: const ColorFilter.mode(
                  AppColorManager.black,
                  BlendMode.srcIn,
                ),
              ),
              onItemSelected: (item) {
                // TODO: handle navigation based on item
                // e.g. if (item == AppBarMenuItem.profile) { ... }
              },
            ),
          ),
        if (suffixIcon != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w2),
            child: suffixIcon!,
          ),
      ],
    );
  }
}

/// Simple enum to describe the menu items
enum AppBarMenuItem { profile, notifications, language, settings }

class AppBarMenuButton extends StatelessWidget {
  const AppBarMenuButton({super.key, required this.icon, this.onItemSelected});

  final Widget icon;
  final ValueChanged<AppBarMenuItem>? onItemSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      width: 38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: AppColorManager.grey),
      ),
      child: PopupMenuButton<AppBarMenuItem>(
        padding: EdgeInsets.zero,
        onSelected: onItemSelected,
        icon: Padding(padding: const EdgeInsets.all(5.0), child: icon),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        itemBuilder: (context) => [
          _buildMenuItem(
            context,
            AppBarMenuItem.profile,
            "profile".tr(),
            AppIconManager.profile,
          ),
          _buildMenuItem(
            context,
            AppBarMenuItem.notifications,
            "notifications".tr(),
            AppIconManager.notification,
          ),
          _buildMenuItem(
            context,
            AppBarMenuItem.language,
            "language".tr(),
            AppIconManager.language,
          ),
          _buildMenuItem(
            context,
            AppBarMenuItem.settings,
            "settings".tr(),
            AppIconManager.settings,
          ),
        ],
      ),
    );
  }

  PopupMenuItem<AppBarMenuItem> _buildMenuItem(
    BuildContext context,
    AppBarMenuItem value,
    String text,
    String iconPath,
  ) {
    return PopupMenuItem<AppBarMenuItem>(
      value: value,
      child: Row(
        children: [
          SvgPicture.asset(iconPath, color: AppColorManager.textGrey),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: AppColorManager.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}
