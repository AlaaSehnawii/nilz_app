import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/widget/list/entity_config.dart';
import '../../../../../../../core/widget/list/generic_list_screen.dart';
import '../../../domain/entity/bed_type_entity.dart';
import '../../adapter/bed_type_entity_adapter.dart';
import '../../cubit/bed_type_cubit.dart';
import '../../cubit/bed_type_state.dart';

class BedTypeListScreen extends StatelessWidget {
  const BedTypeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GenericListScreen<BedTypeEntity, BedTypeState, BedTypeCubit>(
      config: EntityConfig(
        addDialogTitle: 'add_bed_type'.tr(),
        editDialogTitle: 'edit_BedType'.tr(),
        deleteDialogTitle: 'delete_BedType'.tr(),
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
        enableCity: false,
        enableStatus: false,
      ),

      adapter: BedTypeEntityAdapter(),

      onAdd: (ctx, nameAr, nameEn, imageName, base64, city, status) {
        ctx.read<BedTypeCubit>().addBedType(
          ctx,
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName,
          base64: base64,
        );
      },

      onEdit: (ctx, id, nameAr, nameEn, imageName, base64, status, removeImage, cityId) {
        ctx.read<BedTypeCubit>().editBedType(
          ctx,
          id: id,
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName,
          base64: base64,
          cityId: cityId,
        );
      },

      onDelete: (ctx, id) {
        ctx.read<BedTypeCubit>().deleteBedType(ctx, id);
      },

      onFetch: (ctx) {
        ctx.read<BedTypeCubit>().getBedType(context: ctx);
      },

      getStatus: (state) => state.status,
      getError: (state) => state.error,
      getItems: (state) => state.entity.bedTypes,
      enableImage: true,
    );
  }
}
