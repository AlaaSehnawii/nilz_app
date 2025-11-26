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

class _SearchableDropdownState<T> extends State<SearchableDropdown<T>> {
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _fieldKey = GlobalKey();

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  OverlayEntry? _overlayEntry;
  List<T> _filtered = [];
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _filtered = widget.items;
    _setTextFromSelected();
    _focusNode.addListener(_handleFocus);
  }

  @override
  void didUpdateWidget(covariant SearchableDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedItem != widget.selectedItem ||
        oldWidget.items != widget.items) {
      _filtered = widget.items;
      _setTextFromSelected();
      _overlayEntry?.markNeedsBuild();
    }
  }

  void _setTextFromSelected() {
    if (widget.selectedItem != null) {
      _controller.text = widget.labelBuilder(widget.selectedItem as T);
    } else {
      _controller.clear();
    }
  }

  void _handleFocus() {
    if (_focusNode.hasFocus) {
      _openOverlay();
    } else {
      _closeOverlay();
    }
  }

  void _openOverlay() {
    if (_isOpen) return;

    final renderBox =
        _fieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final size = renderBox.size;

    _overlayEntry = _buildOverlay(size);
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _closeOverlay() {
    if (!_isOpen) return;
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isOpen = false);
  }

  void _onChangedText(String value) {
    final q = value.trim().toLowerCase();
    _filtered = widget.items
        .where((item) => widget.filterFn(item, q))
        .toList(growable: false);
    _overlayEntry?.markNeedsBuild();
  }

  OverlayEntry _buildOverlay(Size fieldSize) {
    return OverlayEntry(
      builder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => _focusNode.unfocus(),
          child: Stack(
            children: [
              CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, fieldSize.height + 4),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(8),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 35.h),
                    child: Container(
                      width: fieldSize.width,
                      decoration: BoxDecoration(
                        color: AppColorManager.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColorManager.backgroundGrey,
                          width: 1.3,
                        ),
                      ),
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
                                    _focusNode.unfocus();
                                  },
                                );
                              },
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode
      ..removeListener(_handleFocus)
      ..dispose();
    _overlayEntry?.remove();
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

        CompositedTransformTarget(
          link: _layerLink,
          child: TextFormField(
            key: _fieldKey,
            controller: _controller,
            focusNode: _focusNode,
            onChanged: _onChangedText,
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
              suffixIcon: SvgPicture.asset(
                _isOpen
                    ? AppIconManager.arrowMenuUp
                    : AppIconManager.arrowMenuDown,
                fit: BoxFit.scaleDown,
                color: AppColorManager.textGrey,
              ),
            ),
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColorManager.textAppColor,
            ),
            cursorColor: AppColorManager.textAppColor,
          ),
        ),
      ],
    );
  }
}
