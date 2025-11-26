// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:nilz_app/core/resource/icon_manager.dart';

class CustomSearchBar extends StatefulWidget {
  final double? height;
  final double? width;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final EdgeInsetsGeometry? padding;

  const CustomSearchBar({
    super.key,
    this.height,
    this.width,
    this.controller,
    this.onChanged,
    this.hintText,
    this.padding,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() => _hasFocus = _focusNode.hasFocus);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = widget.width ?? MediaQuery.of(context).size.width - 32;
    final height = widget.height ?? 56;

    return Container(
      height: height,
      width: maxWidth,
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            AppColorManager.backgroundGrey.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: _hasFocus
              ? AppColorManager.denim
              : AppColorManager.backgroundGrey.withOpacity(0.2),
          width: _hasFocus ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColorManager.backgroundGrey.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 10,),
          Center(
            child: SvgPicture.asset(
              AppIconManager.search,
              height: 25,
              width: 25,
              colorFilter: ColorFilter.mode(
                AppColorManager.grey ,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              onChanged: widget.onChanged,
              cursorColor: AppColorManager.textAppColor,
              decoration: InputDecoration(
                hintText: widget.hintText ?? "search".tr(),
                hintStyle: TextStyle(
                  color: AppColorManager.textGrey.withOpacity(0.5),
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.2,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              style: TextStyle(
                color: AppColorManager.textAppColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
