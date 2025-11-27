import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilz_app/core/widget/list/entity_config.dart';
import 'package:nilz_app/core/widget/list/generic_list_screen.dart';
import 'package:nilz_app/feature/drawer/basic_data/reservation_type/presentation/adapter/reservation_type_entity_adapter.dart';
import '../../../domain/entity/reservation_type_entity.dart';
import '../../cubit/reservation_type_state.dart';
import '../../cubit/reservation_type_cubit.dart';

class ReservationTypeListScreen extends StatelessWidget {
  const ReservationTypeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GenericListScreen<ReservationTypeEntity, ReservationTypeState, ReservationTypeCubit>(
      config: EntityConfig(
        addDialogTitle: 'add_Reservation_type'.tr(),
        editDialogTitle: 'edit_ReservationType'.tr(),
        deleteDialogTitle: 'delete_ReservationType'.tr(),
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
      ),
      adapter: ReservationTypeEntityAdapter(),
      onAdd: (ctx, nameAr, nameEn, imageName, base64, city, status) {
        ctx.read<ReservationTypeCubit>().addReservationType(
          ctx,
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName = '',
          base64: base64 = '',
        );
      },
      onEdit: (ctx, id, nameAr, nameEn, imageName, base64, status, removeImage, cityId) {
        ctx.read<ReservationTypeCubit>().editReservationType(
          ctx,
          id: id,
          nameAr: nameAr,
          nameEn: nameEn,
        );
      },
      onDelete: (ctx, id) {
        ctx.read<ReservationTypeCubit>().deleteReservationType(ctx, id);
      },
      onFetch: (ctx) {
        ctx.read<ReservationTypeCubit>().getReservationType(context: ctx);
      },
      getStatus: (state) => state.status,
      getError: (state) => state.error,
      getItems: (state) => state.entity.reservationTypes,
    );
  }
}
