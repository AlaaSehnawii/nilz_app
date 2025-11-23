import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import 'package:nilz_app/core/widget/dialog/generic_add_dialog.dart';

import '../../resource/icon_manager.dart';
import '../dialog/confirmation_dialog.dart';
import '../dialog/generic_edit_dialog.dart';
import 'entity_adapter.dart';

class GenericEntityContainer<T, C extends Cubit> extends StatelessWidget {
  const GenericEntityContainer({
    super.key,
    required this.entity,
    required this.adapter,
    required this.editDialogTitle,
    required this.deleteDialogTitle,
    required this.deleteDialogMessage,
    required this.nameArHint,
    required this.nameEnHint,
    required this.pickImageText,
    required this.noImageSelectedText,
    required this.saveText,
    required this.cancelText,
    required this.deleteText,
    required this.onDelete,
    required this.onEdit,
    this.enableImage = false,
    this.enableCity = false,
    this.enableStatus = false,
    this.cityHint = 'Select city',
    this.cityLabel = 'City',
    this.cityOptions = const [],
    this.initialCityId,
  });

  final T entity;
  final EntityAdapter<T> adapter;

  // labels
  final String editDialogTitle;
  final String deleteDialogTitle;
  final String deleteDialogMessage;
  final String nameArHint;
  final String nameEnHint;
  final String pickImageText;
  final String noImageSelectedText;
  final String saveText;
  final String cancelText;
  final String deleteText;

  // flags
  final bool enableImage;
  final bool enableCity;
  final bool enableStatus;

  final String cityLabel;
  final String cityHint;
  final List<SimpleOption> cityOptions;
  final String? initialCityId;

  // actions
  final void Function(
      BuildContext context,
      String id,
      String? nameAr,
      String? nameEn,
      String? imageName,
      String? base64,
      bool? status,
      bool removeImage,
      String? cityId,
      ) onEdit;

  final void Function(BuildContext context, String id) onDelete;

  static const double _thumbSize = 50;
  static const BorderRadius _cardRadius =
  BorderRadius.all(Radius.circular(14));
  static const BorderRadius _thumbRadius =
  BorderRadius.all(Radius.circular(8));

  @override
  Widget build(BuildContext context) {
    final primaryName = (adapter.getPrimaryName(entity) ?? '').trim();
    final secondaryName = (adapter.getSecondaryName(entity) ?? '').trim();
    final imageUrl = adapter.getImageUrl(entity) ?? '';
    final creatorName = adapter.getCreatorName(entity) ?? ' ';
    final statusRaw = adapter.getStatus(entity) ?? '';
    final id = adapter.getId(entity) ?? '';
    final isArabic = context.locale.languageCode.toLowerCase() == 'ar';

    final displayName = isArabic
        ? (secondaryName.isNotEmpty
        ? secondaryName
        : (primaryName.isNotEmpty ? primaryName : '-'))
        : (primaryName.isNotEmpty
        ? primaryName
        : (secondaryName.isNotEmpty ? secondaryName : '-'));

    final bool? isActive = statusRaw.isEmpty
        ? null
        : (statusRaw.toLowerCase() == 'true'
        ? true
        : (statusRaw.toLowerCase() == 'false' ? false : null));

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        color: AppColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: _cardRadius,
          side: BorderSide(
            color: AppColorManager.backgroundGrey.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: _Thumbnail(imageUrl: imageUrl),
            title: Text(
              displayName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColorManager.textAppColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                creatorName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColorManager.textGrey,
                  fontSize: 14,
                ),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isActive != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: SvgPicture.asset(
                      isActive
                          ? AppIconManager.checkCircle
                          : AppIconManager.closeCircle,
                      height: 28,
                      width: 28,
                      color: isActive
                          ? AppColorManager.lightGreen
                          : AppColorManager.red,
                    ),
                  ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTapDown: (details) async {
                    final position = details.globalPosition;
                    final selected = await showMenu<String>(
                      context: context,
                      position: RelativeRect.fromLTRB(
                        position.dx,
                        position.dy,
                        position.dx,
                        position.dy,
                      ),
                      items: [
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'edit'.tr(),
                                style: TextStyle(
                                  color: AppColorManager.textGrey,
                                ),
                              ),
                              SvgPicture.asset(
                                AppIconManager.edit,
                                color: AppColorManager.textGrey,
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'delete'.tr(),
                                style: TextStyle(
                                  color: AppColorManager.textGrey,
                                ),
                              ),
                              SvgPicture.asset(
                                AppIconManager.delete,
                                color: AppColorManager.textGrey,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );

                    if (selected == 'edit') {
                      final input = await showGenericEditDialog(
                        context,
                        title: editDialogTitle,
                        initialNameAr: secondaryName,
                        initialNameEn: primaryName,
                        initialImageUrl: imageUrl,
                        nameArHint: nameArHint,
                        nameEnHint: nameEnHint,
                        pickImageText: pickImageText,
                        noImageSelectedText: noImageSelectedText,
                        confirmText: saveText,
                        cancelText: cancelText,
                        enableImage: enableImage,
                        enableCity: enableCity,
                        enableStatus: enableStatus,
                        initialStatus: isActive,
                        cityLabel: cityLabel,
                        cityOptions: cityOptions,
                        cityHint: cityHint,
                        initialCityId: adapter.getCityId(entity),
                      );

                      if (input == null) return;

                      onEdit(
                        context,
                        id,
                        input.nameAr,
                        input.nameEn,
                        input.imageName,
                        input.base64,
                        input.status,
                        input.removeImage,
                        input.cityId,
                      );
                    } else if (selected == 'delete') {
                      final confirmed = await showConfirmDialog(
                        context,
                        title: deleteDialogTitle,
                        message: '$deleteDialogMessage $displayName?',
                        confirmText: deleteText,
                        cancelText: cancelText,
                      );
                      if (confirmed) onDelete(context, id);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      AppIconManager.dots,
                      width: 26,
                      height: 26,
                      color: AppColorManager.textGrey,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.imageUrl});

  final String imageUrl;

  static const double _size = GenericEntityContainer._thumbSize;
  static const BorderRadius _radius =
      GenericEntityContainer._thumbRadius;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isNotEmpty) {
      return ClipRRect(
        borderRadius: _radius,
        child: Image.network(
          imageUrl,
          key: ValueKey(imageUrl),
          height: _size,
          width: _size,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              _GradientPlaceholder(child: const Icon(Icons.broken_image)),
        ),
      );
    }
    return const _GradientPlaceholder();
  }
}

class _GradientPlaceholder extends StatelessWidget {
  const _GradientPlaceholder({this.child});

  final Widget? child;

  static const double _size = GenericEntityContainer._thumbSize;
  static const BorderRadius _radius =
      GenericEntityContainer._thumbRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: _radius,
      child: Container(
        height: _size,
        width: _size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColorManager.lightGrey,
              AppColorManager.shadow,
            ],
          ),
        ),
        child: child,
      ),
    );
  }
}
