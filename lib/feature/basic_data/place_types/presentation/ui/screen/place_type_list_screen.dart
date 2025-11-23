import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widget/list/entity_config.dart';
import '../../../../../../core/widget/list/generic_list_screen.dart';
import '../../../domain/entity/place_type_entity.dart';
import '../../adapter/place_type_entity_adapter.dart';
import '../../cubit/place_type_cubit.dart';
import '../../cubit/place_type_state.dart';

class PlaceTypeListScreen extends StatelessWidget {
  const PlaceTypeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GenericListScreen<PlaceTypeEntity, PlaceTypeState, PlaceTypeCubit>(
      config: EntityConfig(
        addDialogTitle: 'add_Place_type'.tr(),
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
        errorTitle: 'error'.tr(),
        somethingWentWrongText: 'something_went_wrong'.tr(),
        noResultsFoundText: 'no_results_found'.tr(),
        enableImage: true,
      ),
      adapter: PlaceTypeEntityAdapter(),
      onAdd: (ctx, nameAr, nameEn, imageName, base64, city, status) {
        ctx.read<PlaceTypeCubit>().addPlaceType(
          ctx,
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName ?? '',
          base64: base64 ?? '',
        );
      },
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