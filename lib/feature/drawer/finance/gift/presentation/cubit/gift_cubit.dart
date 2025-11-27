// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:nilz_app/core/api/api_error/api_error.dart';
import 'package:nilz_app/core/resource/cubit_status_manager.dart';
import '../../domain/usecase/add_gift_usecase.dart';
import '../../domain/usecase/delete_gift_usecase.dart';
import '../../domain/usecase/edit_gift_usecase.dart';
import '../../domain/usecase/gift_usecase.dart';
import 'gift_state.dart';

class GiftCubit extends Cubit<GiftState> {
  final GiftUseCase getGiftUseCase;
  final DeleteGiftUseCase deleteGiftUseCase;
  final AddGiftUseCase addGiftUseCase;
  final EditGiftUseCase editGiftUseCase;

  GiftCubit({
    required this.getGiftUseCase,
    required this.deleteGiftUseCase,
    required this.addGiftUseCase,
    required this.editGiftUseCase,
  }) : super(GiftState.initial());

  Future<void> getGift({required BuildContext context}) async {
    emit(state.copyWith(status: CubitStatus.loading));
    final result = await getGiftUseCase();
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

  Future<void> deleteGift(BuildContext context, String id) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await deleteGiftUseCase(id);
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
        await getGift(context: context);
      },
    );
  }

  Future<void> addGift(
    BuildContext context, {
    required String nameAr,
    required String nameEn,
    String imageName = '',
    String base64 = '',
  }) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await addGiftUseCase(
      nameAr: nameAr,
      nameEn: nameEn,
      imageName: imageName,
      base64: base64,
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
        await getGift(context: context);
      },
    );
  }

  Future<void> editGift(
    BuildContext context, {
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool forceEmptyImageObject = false,
  }) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await editGiftUseCase(
      id: id,
      nameAr: nameAr,
      nameEn: nameEn,
      imageName: imageName,
      base64: base64,
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
        await getGift(context: context);
      },
    );
  }
}
