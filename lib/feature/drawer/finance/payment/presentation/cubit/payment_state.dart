import 'package:nilz_app/core/resource/cubit_status_manager.dart';
import 'package:nilz_app/feature/drawer/finance/payment/domain/entity/payment_entity.dart';

class PaymentState extends Equatable {
  final String error;
  final CubitStatus status;
  final PaymentApiResponseEntity entity;

  PaymentState({
    required this.error,
    required this.status,
    required this.entity,
  });

  factory PaymentState.initial() {
    return PaymentState(
      error: '',
      status: CubitStatus.initial,
      entity: PaymentApiResponseEntity(payments: []),
    );
  }

  PaymentState copyWith({
    String? error,
    CubitStatus? status,
    PaymentApiResponseEntity? entity,
  }) {
    return PaymentState(
      error: error ?? this.error,
      status: status ?? this.status,
      entity: entity ?? this.entity,
    );
  }

  List<Object> get props => [error, status, entity];
}

class Equatable {}
