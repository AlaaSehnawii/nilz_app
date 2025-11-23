import 'package:nilz_app/core/resource/cubit_status_manager.dart';
import '../../domain/entity/response/reservation_entity.dart';

class ReservationState extends Equatable {
  final String error;
  final CubitStatus status;
  final ReservationListResponseEntity entity;

  ReservationState({
    required this.error,
    required this.status,
    required this.entity,
  });

  factory ReservationState.initial() {
    return ReservationState(
      error: '',
      status: CubitStatus.initial,
      entity: ReservationListResponseEntity(),
    );
  }

  ReservationState copyWith({
    String? error,
    CubitStatus? status,
    ReservationListResponseEntity? entity,
  }) {
    return ReservationState(
      error: error ?? this.error,
      status: status ?? this.status,
      entity: entity ?? this.entity,
    );
  }

  List<Object> get props => [error, status, entity];
}

class Equatable {}
