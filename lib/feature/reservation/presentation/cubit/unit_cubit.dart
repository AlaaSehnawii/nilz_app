// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:nilz_app/core/api/api_error/api_error.dart';
import 'package:nilz_app/feature/reservation/domain/usecase/unit_list_usecase.dart';
import 'package:nilz_app/feature/reservation/domain/usecase/unit_usecase.dart';
import 'package:nilz_app/feature/reservation/presentation/cubit/unit_state.dart';
import '../../../../../core/resource/cubit_status_manager.dart';

class UnitCubit extends Cubit<UnitState> {
  final UnitListUseCase unitListUseCase;
  final UnitUseCase unitUseCase;

  UnitCubit({required this.unitListUseCase, required this.unitUseCase})
    : super(UnitState.initial());

  Future<void> getUnitChildren(
    BuildContext context, {
    required String cityId,
    required String toStartTimeIso,
    required String toEndTimeIso,
    required List<Map<String, dynamic>> roomConfig,
  }) async {
    emit(
      state.copyWith(
        status: CubitStatus.loading,
        error: '',
        detailsStatus: CubitStatus.initial,
        detailsError: '',
        unitDetails: null,
      ),
    );

    final result = await unitListUseCase(
      cityId: cityId,
      toStartTimeIso: toStartTimeIso,
      toEndTimeIso: toEndTimeIso,
      roomConfig: roomConfig,
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
            entity: const [],
            count: 0,
            detailsStatus: CubitStatus.initial,
            detailsError: '',
            unitDetails: null,
          ),
        );
      },
      (response) async {
        emit(
          state.copyWith(
            status: CubitStatus.success,
            entity: response.units,
            count: response.count,
            error: '',
            detailsStatus: CubitStatus.initial,
            detailsError: '',
            unitDetails: null,
          ),
        );
      },
    );
  }

  //////////////// 
  
  Future<void> getUnitDetails(
    BuildContext context, {
    required String unitId,
    required String toStartTimeIso,
    required String toEndTimeIso,
  }) async {
    emit(
      state.copyWith(
        error: state.error,
        status: state.status,
        entity: state.entity,
        count: state.count,
        detailsStatus: CubitStatus.loading,
        detailsError: '',
        unitDetails: null,
      ),
    );

    final result = await unitUseCase(
      unitId: unitId,
      toStartTimeIso: toStartTimeIso,
      toEndTimeIso: toEndTimeIso,
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
            detailsStatus: CubitStatus.error,
            detailsError: errorEntity.errorMessage,
            unitDetails: null,
            status: state.status,
            error: state.error,
            entity: state.entity,
            count: state.count,
          ),
        );
      },
      (unit) async {
        emit(
          state.copyWith(
            detailsStatus: CubitStatus.success,
            detailsError: '',
            unitDetails: unit,
            status: state.status,
            error: state.error,
            entity: state.entity,
            count: state.count,
          ),
        );
      },
    );
  }
}
