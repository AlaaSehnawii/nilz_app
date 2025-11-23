// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:nilz_app/core/api/api_error/api_error.dart';
import 'package:nilz_app/feature/reservation/domain/usecase/create_reservation_usecase.dart';
import 'package:nilz_app/feature/reservation/presentation/cubit/reservation_state.dart';
import '../../../../../core/resource/cubit_status_manager.dart';
import '../../domain/usecase/reservation_usecase.dart';

class ReservationCubit extends Cubit<ReservationState> {
  final ReservationUseCase useCase;
  final CreateReservationUseCase createReservationUseCase;

  ReservationCubit({
    required this.useCase,
    required this.createReservationUseCase,
  }) : super(ReservationState.initial());

  getReservation({required BuildContext context}) async {
    debugPrint('called cubit');
    emit(state.copyWith(status: CubitStatus.loading));
    final result = await useCase();
    //!Check if Bloc Closed
    if (isClosed) return;
    result.fold(
      (failure) async {
        final ErrorEntity errorEntity = await ApiErrorHandler.mapFailure(
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
        debugPrint("tooooooooooooooooooooooooooooooken");
      },
    );
  }

  Future<void> createReservation(
    BuildContext context, {
    required String unit,
    required String fromDate,
    required String toDate,
    int extraBedCount = 0,
    required String guests,
    required int age,
    required int count,
    required int roomNum,
    String couponCode = '',
    required String userId,
    required bool withBreakfast,
  }) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await createReservationUseCase(
      unit: unit,
      fromDate: fromDate,
      toDate: toDate,
      extraBedCount: extraBedCount,
      guests: guests,
      age: age,
      count: count,
      roomNum: roomNum,
      couponCode: couponCode,
      userId: userId,
      withBreakfast: withBreakfast,
    );
    if (!isClosed) return;

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
        await getReservation(context: context);
      },
    );
  }
}
