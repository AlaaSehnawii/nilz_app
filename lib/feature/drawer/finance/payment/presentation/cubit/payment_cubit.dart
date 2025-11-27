// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:nilz_app/core/api/api_error/api_error.dart';
import 'package:nilz_app/core/resource/cubit_status_manager.dart';
import 'package:nilz_app/feature/drawer/finance/payment/presentation/cubit/payment_state.dart';
import '../../domain/usecase/add_payment_usecase.dart';
import '../../domain/usecase/delete_payment_usecase.dart';
import '../../domain/usecase/edit_payment_usecase.dart';
import '../../domain/usecase/payment_usecase.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentUseCase getPaymentUseCase;
  final DeletePaymentUseCase deletePaymentUseCase;
  final AddPaymentUseCase addPaymentUseCase;
  final EditPaymentUseCase editPaymentUseCase;

  PaymentCubit({
    required this.getPaymentUseCase,
    required this.deletePaymentUseCase,
    required this.addPaymentUseCase,
    required this.editPaymentUseCase,
  }) : super(PaymentState.initial());

  Future<void> getPayment({required BuildContext context}) async {
    emit(state.copyWith(status: CubitStatus.loading));
    final result = await getPaymentUseCase();
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
        emit(state.copyWith(status: CubitStatus.success,));
      },
    );
  }

  Future<void> deletePayment(BuildContext context, String id) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await deletePaymentUseCase(id);
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
        await getPayment(context: context);
      },
    );
  }

  Future<void> addPayment(
    BuildContext context, {
    required String clientName,
    required String description,
    required String amount,
    required String paymentDueDate,
        required String status,
  }) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await addPaymentUseCase(
      clientName: clientName,
      description: description,
      amount: amount,
      paymentDueDate: paymentDueDate,
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
        await getPayment(context: context);
      },
    );
  }

  Future<void> editPayment(
    BuildContext context, {
    required String id,
    String? clientName,
    String? description,
    String? amount,
    String? paymentDueDate,
        String? status,
  }) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await editPaymentUseCase(
      id: id,
      clientName: clientName,
      description: description,
      paymentDueDate: paymentDueDate,
      amount: amount,
      status: status,
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
        await getPayment(context: context);
      },
    );
  }
}
