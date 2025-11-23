// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:nilz_app/core/api/api_error/api_error.dart';
import '../../../../../core/resource/cubit_status_manager.dart';
import '../../domain/usecase/add_reservation_type_usecase.dart';
import '../../domain/usecase/delete_reservation_type_usecase.dart';
import '../../domain/usecase/edit_Reservation_type_usecase.dart';
import '../../domain/usecase/unit_reservation_usecase.dart';
import 'Reservation_type_state.dart';

class ReservationTypeCubit extends Cubit<ReservationTypeState> {
  final ReservationTypeUseCase getReservationTypeUseCase;
  final DeleteReservationTypeUseCase deleteReservationTypeUseCase;
  final AddReservationTypeUseCase addReservationTypeUseCase;
  final EditReservationTypeUseCase editReservationTypeUseCase;

  ReservationTypeCubit({
    required this.getReservationTypeUseCase,
    required this.deleteReservationTypeUseCase,
    required this.addReservationTypeUseCase,
    required this.editReservationTypeUseCase,
  }) : super(ReservationTypeState.initial());

  Future<void> getReservationType({required BuildContext context}) async {
    emit(state.copyWith(status: CubitStatus.loading));
    final result = await getReservationTypeUseCase();
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

  Future<void> deleteReservationType(BuildContext context, String id) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await deleteReservationTypeUseCase(id);
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
        await getReservationType(context: context);
      },
    );
  }

  Future<void> addReservationType(
    BuildContext context, {
    required String nameAr,
    required String nameEn,
    String imageName = '',
    String base64 = '',
  }) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await addReservationTypeUseCase(
      nameAr: nameAr,
      nameEn: nameEn,
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
        await getReservationType(context: context);
      },
    );
  }

  Future<void> editReservationType(
    BuildContext context, {
    required String id,
    String? nameAr,
    String? nameEn,
  }) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await editReservationTypeUseCase(
      id: id,
      nameAr: nameAr,
      nameEn: nameEn,
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
        await getReservationType(context: context);
      },
    );
  }
}
