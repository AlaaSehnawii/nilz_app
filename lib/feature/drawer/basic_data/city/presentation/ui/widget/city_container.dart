import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/widget/list/generic_entity_container.dart';
import '../../../domain/entity/city_entity.dart';
import '../../adapter/city_entity_adapter.dart';
import '../../cubit/city_cubit.dart';

class CityContainer extends StatelessWidget {
  final CityEntity city;

  const CityContainer({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return GenericEntityContainer<CityEntity, CityCubit>(
      entity: city,
      adapter: CityEntityAdapter(),
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
    );
  }
}
