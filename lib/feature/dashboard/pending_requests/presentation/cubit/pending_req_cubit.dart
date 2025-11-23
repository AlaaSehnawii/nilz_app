// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:nilz_app/core/api/api_error/api_error.dart';
import 'package:nilz_app/feature/dashboard/pending_requests/presentation/cubit/pending_req_state.dart';
import '../../../../../core/resource/cubit_status_manager.dart';
import '../../domain/usecase/pending_req_usecase.dart';


class PendingRequestCubit extends Cubit<PendingRequestState> {
  final PendingRequestUseCase usecase;

  PendingRequestCubit({required this.usecase})
      : super(PendingRequestState.initail());

  getPendingRequest({ required BuildContext context}) async {
    print('called cubit');
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
        print("tooooooooooooooooooooooooooooooken");
      },
    );
  }
}
