import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilz_app/feature/basic_data/post_category/domain/entity/post_category_entity.dart';
import '../../../../../../core/widget/list/generic_entity_container.dart';
import '../../adapter/post_category_entity_adapter.dart';
import '../../cubit/post_category_cubit.dart';

class PostCategoryContainer extends StatelessWidget {
  final CategoryEntity postCategory;

  const PostCategoryContainer({super.key, required this.postCategory});

  @override
  Widget build(BuildContext context) {
    return GenericEntityContainer<CategoryEntity, PostCategoryCubit>(
      entity: postCategory,
      adapter: PostCategoryEntityAdapter(),
      editDialogTitle: 'edit_PostCategory'.tr(),
      deleteDialogTitle: 'delete_PostCategory'.tr(),
      deleteDialogMessage: 'are_you_sure_to_delete'.tr(),
      nameArHint: 'arabic_name'.tr(),
      nameEnHint: 'english_name'.tr(),
      pickImageText: 'pick_image'.tr(),
      noImageSelectedText: 'no_image_selected'.tr(),
      saveText: 'save'.tr(),
      cancelText: 'cancel'.tr(),
      deleteText: 'delete'.tr(),
      onEdit: (ctx, id, nameAr, nameEn, imageName, base64, status, removeImage, cityId) {
        ctx.read<PostCategoryCubit>().editPostCategory(
          ctx,
          id: id,
          nameAr: nameAr,
          nameEn: nameEn,
          imageName: imageName,
          base64: base64,
          status: status,
        );
      },
      onDelete: (ctx, id) {
        ctx.read<PostCategoryCubit>().deletePostCategory(ctx, id);
      },
    );
  }
}
