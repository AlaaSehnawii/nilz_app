
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widget/list/generic_entity_container.dart';
import '../../../domain/entity/place_type_entity.dart';
import '../../adapter/place_type_entity_adapter.dart';
import '../../cubit/place_type_cubit.dart';

class PlaceTypeContainer extends StatelessWidget {
  final PlaceTypeEntity placeType;

  const PlaceTypeContainer({super.key, required this.placeType});

  @override
  Widget build(BuildContext context) {
    return GenericEntityContainer<PlaceTypeEntity, PlaceTypeCubit>(
      entity: placeType,
      adapter: PlaceTypeEntityAdapter(),
      editDialogTitle: 'edit_PlaceType'.tr(),
      deleteDialogTitle: 'delete_PlaceType'.tr(),
      deleteDialogMessage: 'are_you_sure_to_delete'.tr(),
      nameArHint: 'arabic_name'.tr(),
      nameEnHint: 'english_name'.tr(),
      pickImageText: 'pick_image'.tr(),
      noImageSelectedText: 'no_image_selected'.tr(),
      saveText: 'save'.tr(),
      cancelText: 'cancel'.tr(),
      deleteText: 'delete'.tr(),
      onEdit: (ctx, id, nameAr, nameEn, imageName, base64, status, removeImage, cityId) {
        ctx.read<PlaceTypeCubit>().editPlaceType(
          ctx,
          id: id,
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName,
          base64: base64,
        );
      },
      onDelete: (ctx, id) {
        ctx.read<PlaceTypeCubit>().deletePlaceType(ctx, id);
      },
    );
  }
}