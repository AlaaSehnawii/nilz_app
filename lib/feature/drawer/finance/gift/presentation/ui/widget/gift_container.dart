import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/widget/list/generic_entity_container.dart';
import '../../../domain/entity/gift_entity.dart';
import '../../adapter/gift_entity_adapter.dart';
import '../../cubit/gift_cubit.dart';

class GiftContainer extends StatelessWidget {
  final GiftEntity gift;

  const GiftContainer({super.key, required this.gift});

  @override
  Widget build(BuildContext context) {
    return GenericEntityContainer<GiftEntity, GiftCubit>(
      entity: gift,
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
    );
  }
}
