// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:nilz_app/core/api/api_error/api_error.dart';
import 'package:nilz_app/core/resource/cubit_status_manager.dart';
import 'package:nilz_app/feature/basic_data/unit_types/domain/usecase/add_unit_type_usecase.dart';
import 'package:nilz_app/feature/basic_data/unit_types/domain/usecase/delete_unit_type_usecase.dart';
import 'package:nilz_app/feature/basic_data/unit_types/domain/usecase/edit_unit_type_usecase.dart';
import 'package:nilz_app/feature/basic_data/unit_types/domain/usecase/unit_type_usecase.dart';
import 'package:nilz_app/feature/basic_data/unit_types/presentation/cubit/unit_type_state.dart';

class UnitTypeCubit extends Cubit<UnitTypeState> {
  final UnitTypeUseCase getUnitTypeUseCase;
  final DeleteUnitTypeUseCase deleteUnitTypeUseCase;
  final AddUnitTypeUseCase addUnitTypeUseCase;
  final EditUnitTypeUseCase editUnitTypeUseCase;

  UnitTypeCubit({
    required this.getUnitTypeUseCase,
    required this.deleteUnitTypeUseCase,
    required this.addUnitTypeUseCase,
    required this.editUnitTypeUseCase,
  }) : super(UnitTypeState.initial());

  Future<void> getUnitType({required BuildContext context}) async {
    emit(state.copyWith(status: CubitStatus.loading));
    final result = await getUnitTypeUseCase();
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

  Future<void> deleteUnitType(BuildContext context, String id) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await deleteUnitTypeUseCase(id);
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
        await getUnitType(context: context);
      },
    );
  }

  Future<void> addUnitType(
    BuildContext context, {
    required String nameAr,
    required String nameEn,
    String imageName = '',
    String base64 = '',
  }) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await addUnitTypeUseCase(
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
        await getUnitType(context: context);
      },
    );
  }

  Future<void> editUnitType(
    BuildContext context, {
    required String id,
    String? nameAr,
    String? nameEn,
    String? imageName,
    String? base64,
    bool forceEmptyImageObject = false,
  }) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await editUnitTypeUseCase(
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
        await getUnitType(context: context);
      },
    );
  }
}
