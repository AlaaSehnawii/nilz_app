import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widget/list/entity_config.dart';
import '../../../../../../core/widget/list/generic_list_screen.dart';
import '../../../../../../core/widget/dialog/generic_add_dialog.dart'
    show SimpleOption;
import '../../../../city/presentation/cubit/city_cubit.dart';
import '../../../domain/entity/service_entity.dart';
import '../../adapter/service_entity_adapter.dart';
import '../../cubit/service_cubit.dart';
import '../../cubit/service_state.dart';

class ServiceListScreen extends StatelessWidget {
  const ServiceListScreen({super.key});

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

    return GenericListScreen<ServiceEntity, ServiceState, ServiceCubit>(
      config: EntityConfig(
        addDialogTitle: 'add_service'.tr(),
        editDialogTitle: 'edit_service'.tr(),
        deleteDialogTitle: 'delete_service'.tr(),
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
        enableStatus: true,
        enableCity: true,
        cityOptions: cityOptions,
      ),
      adapter: ServiceEntityAdapter(),
      onAdd: (ctx, nameAr, nameEn, imageName, base64, cityId, status) {
        ctx.read<ServiceCubit>().addService(
          ctx,
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName ?? '',
          base64: base64 ?? '',
          city: cityId ?? '',
          status: status ?? true,
        );
      },

      onEdit:
          (ctx, id, nameAr, nameEn, imageName, base64, status, removeImage, cityId) {
            ctx.read<ServiceCubit>().editService(
              ctx,
              id: id,
              nameAr: nameAr,
              nameEn: nameEn,
              imageName: imageName,
              base64: base64,
              cityId: cityId,
              status: status,
            );
          },

      onDelete: (ctx, id) {
        ctx.read<ServiceCubit>().deleteService(ctx, id);
      },

      onFetch: (ctx) {
        ctx.read<ServiceCubit>().getService(context: ctx);
      },
      enableCity: true,
      enableImage: true,
      enableStatus: true,
      getStatus: (state) => state.status,
      getError: (state) => state.error,
      getItems: (state) => state.entity.services,
    );
  }
}
