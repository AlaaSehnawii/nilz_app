import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widget/list/generic_entity_container.dart';
import '../../../domain/entity/room_type_entity.dart';
import '../../adapter/room_type_entity_adapter.dart';
import '../../cubit/room_type_cubit.dart';

class RoomTypeContainer extends StatelessWidget {
  final RoomTypeEntity roomType;

  const RoomTypeContainer({super.key, required this.roomType});

  @override
  Widget build(BuildContext context) {
    return GenericEntityContainer<RoomTypeEntity, RoomTypeCubit>(
      entity: roomType,
      adapter: RoomTypeEntityAdapter(),
      editDialogTitle: 'edit_RoomType'.tr(),
      deleteDialogTitle: 'delete_RoomType'.tr(),
      deleteDialogMessage: 'are_you_sure_to_delete'.tr(),
      nameArHint: 'arabic_name'.tr(),
      nameEnHint: 'english_name'.tr(),
      pickImageText: 'pick_image'.tr(),
      noImageSelectedText: 'no_image_selected'.tr(),
      saveText: 'save'.tr(),
      cancelText: 'cancel'.tr(),
      deleteText: 'delete'.tr(),
      enableImage: true,
      onEdit: (ctx, id, nameAr, nameEn, imageName, base64, status, removeImage, cityId) {
        ctx.read<RoomTypeCubit>().editRoomType(
          ctx,
          id: id,
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName,
          base64: base64,
        );
      },
      onDelete: (ctx, id) {
        ctx.read<RoomTypeCubit>().deleteRoomType(ctx, id);
      },
    );
  }
}
