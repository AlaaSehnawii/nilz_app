// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:nilz_app/core/api/api_error/api_error.dart';
import '../../../../../core/resource/cubit_status_manager.dart';
import '../../domain/usecase/add_bed_type_usecase.dart';
import '../../domain/usecase/bed_type_usecase.dart';
import '../../domain/usecase/delete_bed_type_usecase.dart';
import '../../domain/usecase/edit_bed_type_usecase.dart';
import 'bed_type_state.dart';

class BedTypeCubit extends Cubit<BedTypeState> {
  final BedTypeUseCase getBedTypeUseCase;
  final DeleteBedTypeUseCase deleteBedTypeUseCase;
  final AddBedTypeUseCase addBedTypeUseCase;
  final EditBedTypeUseCase editBedTypeUseCase;

  BedTypeCubit({
    required this.getBedTypeUseCase,
    required this.deleteBedTypeUseCase,
    required this.addBedTypeUseCase,
    required this.editBedTypeUseCase,
  }) : super(BedTypeState.initial());

  Future<void> getBedType({required BuildContext context}) async {
    emit(state.copyWith(status: CubitStatus.loading));
    final result = await getBedTypeUseCase();
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

  Future<void> deleteBedType(BuildContext context, String id) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await deleteBedTypeUseCase(id);
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
        await getBedType(context: context);
      },
    );
  }

  Future<void> addBedType(
      BuildContext context, {
        required String nameAr,
        required String nameEn,
        String? imageName,
        String? base64,
      }) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await addBedTypeUseCase(
      nameAr: nameAr,
      nameEn: nameEn,
      imageName: imageName ?? '',
      base64: base64 ?? '',
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
        await getBedType(context: context);
      },
    );
  }

  Future<void> editBedType(
      BuildContext context, {
        required String id,
        String? nameAr,
        String? nameEn,
        String? imageName,
        String? base64,
        String? cityId,
        bool forceEmptyImageObject = false,
      }) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await editBedTypeUseCase(
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
        await getBedType(context: context);
      },
    );
  }
}
