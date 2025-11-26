import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widget/list/entity_config.dart';
import '../../../../../../core/widget/list/generic_list_screen.dart';
import '../../../domain/entity/room_type_entity.dart';
import '../../adapter/room_type_entity_adapter.dart';
import '../../cubit/room_type_cubit.dart';
import '../../cubit/room_type_state.dart';

class RoomTypeListScreen extends StatelessWidget {
  const RoomTypeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GenericListScreen<RoomTypeEntity, RoomTypeState, RoomTypeCubit>(
      config: EntityConfig(
        addDialogTitle: 'add_Room_type'.tr(),
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
        errorTitle: 'error'.tr(),
        somethingWentWrongText: 'something_went_wrong'.tr(),
        noResultsFoundText: 'no_results_found'.tr(),
        enableImage: true,
      ),
      adapter: RoomTypeEntityAdapter(),
      onAdd: (ctx, nameAr, nameEn, imageName, base64, city, status) {
        ctx.read<RoomTypeCubit>().addRoomType(
          ctx,
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName ?? '',
          base64: base64 ?? '',
        );
      },
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
      onFetch: (ctx) {
        ctx.read<RoomTypeCubit>().getRoomType(context: ctx);
      },
      enableImage: true,
      getStatus: (state) => state.status,
      getError: (state) => state.error,
      getItems: (state) => state.entity.roomTypes,
    );
  }
}
