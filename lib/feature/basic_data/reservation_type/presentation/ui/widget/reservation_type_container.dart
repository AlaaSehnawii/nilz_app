import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widget/list/generic_entity_container.dart';
import '../../../domain/entity/Reservation_type_entity.dart';
import '../../adapter/Reservation_type_entity_adapter.dart';
import '../../cubit/reservation_type_cubit.dart';

class ReservationTypeContainer extends StatelessWidget {
  final ReservationTypeEntity reservationType;

  const ReservationTypeContainer({super.key, required this.reservationType});

  @override
  Widget build(BuildContext context) {
    return GenericEntityContainer<ReservationTypeEntity, ReservationTypeCubit>(
      entity: reservationType,
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
    );
  }
}
