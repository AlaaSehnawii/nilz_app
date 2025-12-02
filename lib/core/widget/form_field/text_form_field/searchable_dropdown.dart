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

  // For overlay positioning
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _fieldKey = GlobalKey();

  OverlayEntry? _overlayEntry;

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
      if (mounted) {
        setState(() {});
        _rebuildOverlayIfOpen();
      }
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
      _closeOverlay();
    }
  }

  void _onChangedText(String value) {
    final q = value.trim().toLowerCase();
    _filtered = widget.items
        .where((item) => widget.filterFn(item, q))
        .toList(growable: false);

    if (_focusNode.hasFocus && _filtered.isNotEmpty) {
      _openOverlay();
    } else {
      _closeOverlay();
    }

    setState(() {});
  }

  void _toggleOpen() {
    if (!_focusNode.hasFocus) {
      _focusNode.requestFocus();
    }
    if (_isOpen) {
      _closeOverlay();
    } else {
      _openOverlay();
    }
  }

  void _openOverlay() {
    if (_isOpen) {
      _rebuildOverlayIfOpen();
      return;
    }
    _isOpen = true;
    _overlayEntry = _buildOverlayEntry();
    final overlay = Overlay.of(context);
    if (_overlayEntry != null) {
      overlay.insert(_overlayEntry!);
    }
    setState(() {});
  }

  void _closeOverlay() {
    if (!_isOpen) return;
    _isOpen = false;
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {});
  }

  void _rebuildOverlayIfOpen() {
    if (!_isOpen) return;
    _overlayEntry?.remove();
    _overlayEntry = _buildOverlayEntry();
    final overlay = Overlay.of(context);
    if (_overlayEntry != null) {
      overlay.insert(_overlayEntry!);
    }
  }

  OverlayEntry _buildOverlayEntry() {
    final RenderBox? renderBox =
        _fieldKey.currentContext?.findRenderObject() as RenderBox?;
    final Size fieldSize = renderBox?.size ?? Size(100.w, 6.h);

    return OverlayEntry(
      builder: (context) {
        return Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              _closeOverlay();
              _focusNode.unfocus();
            },
            child: Stack(
              children: [
                CompositedTransformFollower(
                  link: _layerLink,
                  showWhenUnlinked: false,
                  offset: Offset(0, fieldSize.height + 0.5.h),
                  child: Material(
                    elevation: 4,
                    color: Colors.transparent,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 35.h,
                        minWidth: fieldSize.width,
                      ),
                      child: Container(
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
                                      _closeOverlay();
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
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _closeOverlay();
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
        CompositedTransformTarget(
          link: _layerLink,
          child: Container(
            key: _fieldKey,
            child: TextFormField(
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
          ),
        ),
      ],
    );
  }
}
