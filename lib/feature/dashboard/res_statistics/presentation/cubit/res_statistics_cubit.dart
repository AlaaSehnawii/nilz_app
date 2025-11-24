// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:nilz_app/core/api/api_error/api_error.dart';
import 'package:nilz_app/feature/dashboard/res_statistics/domain/usecase/res_statistics_usecase.dart';
import 'package:nilz_app/feature/dashboard/res_statistics/presentation/cubit/res_statistics_state.dart';
import '../../../../../core/resource/cubit_status_manager.dart';


class ResStatisticsCubit extends Cubit<ResStatisticsState> {
  final ResStatisticsUsecase usecase;

  ResStatisticsCubit({required this.usecase})
      : super(ResStatisticsState.initail());

  getResStatistics({ required BuildContext context}) async {
    emit(state.copyWith(status: CubitStatus.loading));
    final result = await usecase();
    //!Check if Bloc Closed
    if (isClosed) return;
    result.fold(
      (failure) async {
        final ErrorEntity errorEntity =
            await ApiErrorHandler.mapFailure(failure: failure,buildContext: context);
        emit(state.copyWith(
            error: errorEntity.errorMessage, status: CubitStatus.error));
      },
      (data) {
        emit(state.copyWith(status: CubitStatus.success, entity: data));
      },
    );
  }
}
