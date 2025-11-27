import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilz_app/core/widget/list/generic_entity_list.dart';
import '../../../domain/entity/reservation_type_entity.dart';
import '../../adapter/reservation_type_entity_adapter.dart';
import '../../cubit/reservation_type_state.dart';
import '../../cubit/reservation_type_cubit.dart';

class ReservationTypeList extends StatelessWidget {
  final String query;

  const ReservationTypeList({super.key, this.query = ''});

  @override
  Widget build(BuildContext context) {
    return GenericEntityList<ReservationTypeEntity, ReservationTypeState, ReservationTypeCubit>(
      query: query,
      adapter: ReservationTypeEntityAdapter(),
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
      somethingWentWrongText: 'something_went_wrong'.tr(),
      noResultsFoundText: 'no_results_found'.tr(),
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
