import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widget/list/generic_entity_list.dart';
import '../../../domain/entity/place_type_entity.dart';
import '../../adapter/place_type_entity_adapter.dart';
import '../../cubit/place_type_cubit.dart';
import '../../cubit/place_type_state.dart';

class PlaceTypeList extends StatelessWidget {
  final String query;

  const PlaceTypeList({super.key, this.query = ''});

  @override
  Widget build(BuildContext context) {
    return GenericEntityList<PlaceTypeEntity, PlaceTypeState, PlaceTypeCubit>(
      query: query,
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
      somethingWentWrongText: 'something_went_wrong'.tr(),
      noResultsFoundText: 'no_results_found'.tr(),
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
      onFetch: (ctx) {
        ctx.read<PlaceTypeCubit>().getPlaceType(context: ctx);
      },
      getStatus: (state) => state.status,
      getError: (state) => state.error,
      getItems: (state) => state.entity.PlaceTypes,
    );
  }
}