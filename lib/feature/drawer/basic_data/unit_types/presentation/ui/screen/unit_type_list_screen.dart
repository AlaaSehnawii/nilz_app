import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilz_app/core/widget/list/entity_config.dart';
import 'package:nilz_app/core/widget/list/generic_list_screen.dart';
import '../../../domain/entity/unit_type_entity.dart';
import '../../adapter/unit_type_entity_adapter.dart';
import '../../cubit/unit_type_cubit.dart';
import '../../cubit/unit_type_state.dart';

class UnitTypeListScreen extends StatelessWidget {
  const UnitTypeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GenericListScreen<UnitTypeEntity, UnitTypeState, UnitTypeCubit>(
      config: EntityConfig(
        addDialogTitle: 'add_unit_type'.tr(),
        editDialogTitle: 'edit_unitType'.tr(),
        deleteDialogTitle: 'delete_unitType'.tr(),
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
      adapter: UnitTypeEntityAdapter(),
      onAdd: (ctx, nameAr, nameEn, imageName, base64, city, status) {
        ctx.read<UnitTypeCubit>().addUnitType(
          ctx,
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName ?? '',
          base64: base64 ?? '',
        );
      },
      onEdit:
          (ctx, id, nameAr, nameEn, imageName, base64, status, removeImage, cityId) {
            ctx.read<UnitTypeCubit>().editUnitType(
              ctx,
              id: id,
              nameAr: nameAr,
              nameEn: nameEn,
              imageName: imageName,
              base64: base64,
            );
          },
      enableImage: true,
      onDelete: (ctx, id) {
        ctx.read<UnitTypeCubit>().deleteUnitType(ctx, id);
      },
      onFetch: (ctx) {
        ctx.read<UnitTypeCubit>().getUnitType(context: ctx);
      },
      getStatus: (state) => state.status,
      getError: (state) => state.error,
      getItems: (state) => state.entity.unitTypes,
    );
  }
}
