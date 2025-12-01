// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:nilz_app/core/resource/icon_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchableDropdown<T> extends StatefulWidget {
  const SearchableDropdown({
    super.key,
    required this.items,
    required this.labelBuilder,
    required this.filterFn,
    required this.onChanged,
    this.selectedItem,
    this.hintText = '',
    this.titleText = '',
  });

  final List<T> items;
  final String Function(T) labelBuilder;
  final bool Function(T item, String query) filterFn;
  final ValueChanged<T?> onChanged;
  final T? selectedItem;
  final String hintText;
  final String titleText;

  @override
  State<SearchableDropdown<T>> createState() => _SearchableDropdownState<T>();
}

class _SearchableDropdownState<T> extends State<SearchableDropdown<T>>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late List<T> _filtered;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _filtered = List<T>.from(widget.items);
    _setTextFromSelected();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(covariant SearchableDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.items != widget.items ||
        oldWidget.selectedItem != widget.selectedItem) {
      _filtered = List<T>.from(widget.items);
      _setTextFromSelected();
      // no overlay / markNeedsBuild here anymore
      if (mounted) setState(() {});
    }
  }

  void _setTextFromSelected() {
    if (widget.selectedItem != null) {
      _controller.text = widget.labelBuilder(widget.selectedItem as T);
    } else {
      _controller.clear();
    }
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      // Close suggestions when field loses focus
      if (_isOpen) {
        setState(() {
          _isOpen = false;
        });
      }
    }
  }

  void _onChangedText(String value) {
    final q = value.trim().toLowerCase();
    _filtered = widget.items
        .where((item) => widget.filterFn(item, q))
        .toList(growable: false);

    if (!_isOpen && _focusNode.hasFocus) {
      setState(() => _isOpen = true);
    } else {
      setState(() {});
    }
  }

  void _toggleOpen() {
    if (!_focusNode.hasFocus) {
      _focusNode.requestFocus();
    }
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode
      ..removeListener(_onFocusChange)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.titleText.isNotEmpty) ...[
          Text(
            widget.titleText,
            style: TextStyle(
              fontSize: 15.sp,
              color: AppColorManager.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 0.8.h),
        ],

        // TextField
        TextFormField(
          controller: _controller,
          focusNode: _focusNode,
          onChanged: _onChangedText,
          readOnly: false,
          decoration: InputDecoration(
            fillColor: AppColorManager.background.withOpacity(0),
            filled: true,
            isDense: true,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: AppColorManager.textGrey,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 2.h,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColorManager.backgroundGrey,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColorManager.denim.withOpacity(0.6),
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            suffixIcon: IconButton(
              icon: SvgPicture.asset(
                _isOpen
                    ? AppIconManager.arrowMenuUp
                    : AppIconManager.arrowMenuDown,
                fit: BoxFit.scaleDown,
                color: AppColorManager.textGrey,
              ),
              onPressed: _toggleOpen,
            ),
          ),
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColorManager.textAppColor,
          ),
          cursorColor: AppColorManager.textAppColor,
        ),

        // Suggestions list (in-tree, no overlay)
        AnimatedSize(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          child: _isOpen && _filtered.isNotEmpty
              ? Container(
                  margin: EdgeInsets.only(top: 0.8.h),
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: AppColorManager.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColorManager.backgroundGrey,
                      width: 1.3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  constraints: BoxConstraints(maxHeight: 35.h),
                  child: _filtered.isEmpty
                      ? Padding(
                          padding: EdgeInsets.all(2.h),
                          child: Text(
                            'no_results_found'.tr(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColorManager.textGrey,
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: _filtered.length,
                          itemBuilder: (context, index) {
                            final item = _filtered[index];
                            final label = widget.labelBuilder(item);
                            final isSelected =
                                widget.selectedItem != null &&
                                widget.selectedItem == item;

                            return ListTile(
                              dense: true,
                              title: Text(
                                label,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColorManager.textAppColor,
                                ),
                              ),
                              trailing: isSelected
                                  ? Icon(
                                      Icons.check,
                                      color: AppColorManager.denim,
                                    )
                                  : null,
                              onTap: () {
                                _controller.text = label;
                                widget.onChanged(item);
                                setState(() {
                                  _isOpen = false;
                                });
                                _focusNode.unfocus();
                              },
                            );
                          },
                        ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
