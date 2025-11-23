// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:nilz_app/core/api/api_error/api_error.dart';
import 'package:nilz_app/feature/basic_data/post_category/presentation/cubit/post_category_state.dart';
import '../../../../../core/resource/cubit_status_manager.dart';
import '../../domain/usecase/add_post_category_usecase.dart';
import '../../domain/usecase/delete_post_category_usecase.dart';
import '../../domain/usecase/edit_post_category_usecase.dart';
import '../../domain/usecase/post_category_usecase.dart';

class PostCategoryCubit extends Cubit<PostCategoryState> {
  final PostCategoryUseCase getPostCategoryUseCase;
  final DeletePostCategoryUseCase deletePostCategoryUseCase;
  final AddPostCategoryUseCase addPostCategoryUseCase;
  final EditPostCategoryUseCase editPostCategoryUseCase;

  PostCategoryCubit({
    required this.getPostCategoryUseCase,
    required this.deletePostCategoryUseCase,
    required this.addPostCategoryUseCase,
    required this.editPostCategoryUseCase,
  }) : super(PostCategoryState.initial());

  Future<void> getPostCategory({required BuildContext context}) async {
    emit(state.copyWith(status: CubitStatus.loading));
    final result = await getPostCategoryUseCase();
    if (isClosed) return;

    result.fold(
          (failure) async {
        final errorEntity = await ApiErrorHandler.mapFailure(
          failure: failure,
          buildContext: context,
        );
        emit(
          state.copyWith(
            error: errorEntity.errorMessage,
            status: CubitStatus.error,
          ),
        );
      },
          (data) {
        emit(state.copyWith(status: CubitStatus.success, entity: data));
      },
    );
  }

  Future<void> deletePostCategory(BuildContext context, String id) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await deletePostCategoryUseCase(id);
    if (isClosed) return;

    await result.fold(
          (failure) async {
        final errorEntity = await ApiErrorHandler.mapFailure(
          failure: failure,
          buildContext: context,
        );
        emit(
          state.copyWith(
            status: CubitStatus.error,
            error: errorEntity.errorMessage,
          ),
        );
      },
          (_) async {
        await getPostCategory(context: context);
      },
    );
  }

  Future<void> addPostCategory(BuildContext context, {
    required String nameAr,
    required String nameEn,
    String imageName = '',
    String base64 = '',
    required bool status,
  }) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await addPostCategoryUseCase(
        nameAr: nameAr,
        nameEn: nameEn,
        imageName: imageName,
        base64: base64,
        status: status,
    );
    if (isClosed) return;

    await result.fold(
          (failure) async {
        final errorEntity = await ApiErrorHandler.mapFailure(
          failure: failure,
          buildContext: context,
        );
        emit(
          state.copyWith(
            status: CubitStatus.error,
            error: errorEntity.errorMessage,
          ),
        );
      },
          (_) async {
        await getPostCategory(context: context);
      },
    );
  }

  Future<void> editPostCategory(BuildContext context, {
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool? status,
    bool forceEmptyImageObject = false,
  }) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await editPostCategoryUseCase(
      id: id,
      nameAr: nameAr,
      nameEn: nameEn,
      imageName: imageName,
      base64: base64,
      status: status,
      forceEmptyImageObject: forceEmptyImageObject,
    );

    if (isClosed) return;

    await result.fold(
          (failure) async {
        final error = await ApiErrorHandler.mapFailure(
          failure: failure,
          buildContext: context,
        );
        emit(
          state.copyWith(status: CubitStatus.error, error: error.errorMessage),
        );
      },
          (_) async {
        await getPostCategory(context: context);
      },
    );
  }
}
