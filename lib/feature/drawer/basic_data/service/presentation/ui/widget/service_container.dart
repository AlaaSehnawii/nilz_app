import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/widget/dialog/generic_add_dialog.dart';
import '../../../../../../../core/widget/list/generic_entity_container.dart';
import '../../../../city/presentation/cubit/city_cubit.dart';
import '../../../domain/entity/service_entity.dart';
import '../../adapter/service_entity_adapter.dart';
import '../../cubit/service_cubit.dart';

class ServiceContainer extends StatelessWidget {
  final ServiceEntity service;

  const ServiceContainer({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final cityState = context.watch<CityCubit>().state;
    final localeIsAr = context.locale.languageCode == 'ar';

    final List<SimpleOption> cityOptions = (cityState.entity.cities)
        .where((c) => (c.id ?? '').isNotEmpty)
        .map(
          (c) => SimpleOption(
        id: c.id!,
        label: localeIsAr ? (c.name?.ar ?? '') : (c.name?.en ?? ''),
      ),
    )
        .toList();
    return GenericEntityContainer<ServiceEntity, ServiceCubit>(
      entity: service,
      adapter: ServiceEntityAdapter(),
      editDialogTitle: 'edit_Service'.tr(),
      deleteDialogTitle: 'delete_Service'.tr(),
      deleteDialogMessage: 'are_you_sure_to_delete'.tr(),
      nameArHint: 'arabic_name'.tr(),
      nameEnHint: 'english_name'.tr(),
      pickImageText: 'pick_image'.tr(),
      noImageSelectedText: 'no_image_selected'.tr(),
      saveText: 'save'.tr(),
      cancelText: 'cancel'.tr(),
      deleteText: 'delete'.tr(),
      enableImage: true,
      enableStatus: true,
      enableCity: true,
      cityOptions: cityOptions,
      onEdit: (ctx, id, nameAr, nameEn, imageName, base64, status, removeImage, cityId) {
        ctx.read<ServiceCubit>().editService(
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
        ctx.read<ServiceCubit>().deleteService(ctx, id);
      },
    );
  }
}
