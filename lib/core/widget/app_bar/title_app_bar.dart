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
    this.showSuffixIcon
  });

  final String title;
  final Widget? suffixIcon;
  final bool? showArrowBack;
  final bool? showSuffixIcon;

  @override
  Size get preferredSize => Size.fromHeight(AppHeightManager.h9);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: AppColorManager.white,
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Row(
        children: [
          Visibility(
            visible: showArrowBack ?? true,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                LanguageHelper.checkIfLTR(context: context)
                    ? AppIconManager.arrowLeft
                    : AppIconManager.arrowRight,
                colorFilter: const ColorFilter.mode(
                  AppColorManager.black,
                  BlendMode.srcIn,
                ),
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
        Visibility(
          visible: showSuffixIcon ?? true,
          child: Padding(
            padding: EdgeInsets.only(
              right: LanguageHelper.checkIfLTR(context: context)
                  ? AppWidthManager.w5point7
                  : 0,
              left: !LanguageHelper.checkIfLTR(context: context)
                  ? AppWidthManager.w5point7
                  : 0,
            ),
            child: DropdownIconButton(
              icon: SvgPicture.asset(
                AppIconManager.nilz,
                colorFilter: const ColorFilter.mode(
                  AppColorManager.black,
                  BlendMode.srcIn,
                ),
              ),
            ),
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

class DropdownIconButton extends StatefulWidget {
  final Widget icon;

  const DropdownIconButton({super.key, required this.icon});

  @override
  State<DropdownIconButton> createState() => _DropdownIconButtonState();
}

class _DropdownIconButtonState extends State<DropdownIconButton> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool _isOpen = false;

  void _toggleDropdown() {
    if (_isOpen) {
      _removeDropdown();
    } else {
      _showDropdown();
    }
  }

  void _showDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
    setState(() {
      _isOpen = true;
    });
  }

  void _removeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isOpen = false;
    });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: _removeDropdown,
                behavior: HitTestBehavior.translucent,
                child: const SizedBox.shrink(),
              ),
            ),
            Positioned(
              left: offset.dx - 60,
              top: offset.dy + size.height + 6,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                    color: AppColorManager.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildItem("profile".tr(), AppIconManager.profile),
                      _buildItem("notifications".tr(), AppIconManager.notification),
                      _buildItem("language".tr(), AppIconManager.language),
                      _buildItem("settings".tr(), AppIconManager.settings),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildItem(String text, String icon) {
    return InkWell(
      onTap: () {
        debugPrint("Selected: $text");
        _removeDropdown();
        
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: [
            SvgPicture.asset(icon, color: AppColorManager.textGrey,),
            const SizedBox(width: 10,),
            Text(text, style: const TextStyle(fontSize: 14, color: AppColorManager.textGrey)),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _removeDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: InkWell(
        onTap: _toggleDropdown,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 34,
          width: 38,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: AppColorManager.grey),
          ),
          padding: const EdgeInsets.all(5.0),
          child: widget.icon,
        ),
      ),
    );
  }
}
