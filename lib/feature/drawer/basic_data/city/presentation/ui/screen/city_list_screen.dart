import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/widget/list/entity_config.dart';
import '../../../../../../../core/widget/list/generic_list_screen.dart';
import '../../../domain/entity/city_entity.dart';
import '../../adapter/city_entity_adapter.dart';
import '../../cubit/city_cubit.dart';
import '../../cubit/city_state.dart';

class CityListScreen extends StatelessWidget {
  const CityListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GenericListScreen<CityEntity, CityState, CityCubit>(
      config: EntityConfig(
        addDialogTitle: 'add_city'.tr(),
        editDialogTitle: 'edit_city'.tr(),
        deleteDialogTitle: 'delete_city'.tr(),
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
      adapter: CityEntityAdapter(),
      onAdd: (ctx, nameAr, nameEn, imageName, base64, city, status) {
        ctx.read<CityCubit>().addCity(
          ctx,
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName ?? '',
          base64: base64 ?? '',
        );
      },
      onEdit: (ctx, id, nameAr, nameEn, imageName, base64, status, removeImage, cityId) {
        ctx.read<CityCubit>().editCity(
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
        ctx.read<CityCubit>().deleteCity(ctx, id);
      },
      onFetch: (ctx) {
        ctx.read<CityCubit>().getCity(context: ctx);
      },
      getStatus: (state) => state.status,
      getError: (state) => state.error,
      getItems: (state) => state.entity.cities,
      enableImage: true,
    );
  }
}
