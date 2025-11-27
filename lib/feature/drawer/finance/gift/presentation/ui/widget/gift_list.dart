import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/widget/list/generic_entity_list.dart';
import '../../../domain/entity/gift_entity.dart';
import '../../adapter/gift_entity_adapter.dart';
import '../../cubit/gift_cubit.dart';
import '../../cubit/gift_state.dart';

class GiftList extends StatelessWidget {
  final String query;

  const GiftList({super.key, this.query = ''});

  @override
  Widget build(BuildContext context) {
    return GenericEntityList<GiftEntity, GiftState, GiftCubit>(
      query: query,
      adapter: GiftEntityAdapter(),
      editDialogTitle: 'edit_Gift'.tr(),
      deleteDialogTitle: 'delete_Gift'.tr(),
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
        ctx.read<GiftCubit>().editGift(
          ctx,
          id: id,
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName,
          base64: base64,
        );
      },
      onDelete: (ctx, id) {
        ctx.read<GiftCubit>().deleteGift(ctx, id);
      },
      onFetch: (ctx) {
        ctx.read<GiftCubit>().getGift(context: ctx);
      },
      getStatus: (state) => state.status,
      getError: (state) => state.error,
      getItems: (state) => state.entity.gifts,
    );
  }
}
