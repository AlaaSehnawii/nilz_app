import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widget/list/generic_entity_list.dart';
import '../../../domain/entity/room_type_entity.dart';
import '../../adapter/room_type_entity_adapter.dart';
import '../../cubit/room_type_cubit.dart';
import '../../cubit/room_type_state.dart';

class RoomTypeList extends StatelessWidget {
  final String query;

  const RoomTypeList({super.key, this.query = ''});

  @override
  Widget build(BuildContext context) {
    return GenericEntityList<RoomTypeEntity, RoomTypeState, RoomTypeCubit>(
      query: query,
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
      somethingWentWrongText: 'something_went_wrong'.tr(),
      noResultsFoundText: 'no_results_found'.tr(),
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
      onFetch: (ctx) {
        ctx.read<RoomTypeCubit>().getRoomType(context: ctx);
      },
      getStatus: (state) => state.status,
      getError: (state) => state.error,
      getItems: (state) => state.entity.RoomTypes,
    );
  }
}
