import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilz_app/core/widget/list/generic_entity_list.dart';
import 'package:nilz_app/feature/drawer/basic_data/post_category/domain/entity/post_category_entity.dart';
import '../../adapter/post_category_entity_adapter.dart';
import '../../cubit/post_category_cubit.dart';
import '../../cubit/post_category_state.dart';

class PostCategoryList extends StatelessWidget {
  final String query;

  const PostCategoryList({super.key, this.query = ''});

  @override
  Widget build(BuildContext context) {
    return GenericEntityList<
      CategoryEntity,
      PostCategoryState,
      PostCategoryCubit
    >(
      query: query,
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
      somethingWentWrongText: 'something_went_wrong'.tr(),
      noResultsFoundText: 'no_results_found'.tr(),
      enableImage: true,
      enableStatus: true,
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
      onFetch: (ctx) {
        ctx.read<PostCategoryCubit>().getPostCategory(context: ctx);
      },
      getStatus: (state) => state.status,
      getError: (state) => state.error,
      getItems: (state) => state.entity.categories,
    );
  }
}
