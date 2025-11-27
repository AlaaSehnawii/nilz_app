import 'package:nilz_app/core/resource/cubit_status_manager.dart';
import '../../domain/entity/reservation_type_entity.dart';


class ReservationTypeState extends Equatable {
  final String error;
  final CubitStatus status;
  final ReservationTypesApiResponseEntity entity;

  ReservationTypeState({
    required this.error,
    required this.status,
    required this.entity,
  });

  factory ReservationTypeState.initial() {
    return ReservationTypeState(
      error: '',
      status: CubitStatus.initial,
      entity: ReservationTypesApiResponseEntity(),
    );
  }

  ReservationTypeState copyWith({
    String? error,
    CubitStatus? status,
    ReservationTypesApiResponseEntity? entity,
  }) {
    return ReservationTypeState(
      error: error ?? this.error,
      status: status ?? this.status,
      entity: entity ?? this.entity,
    );
  }

  List<Object> get props => [error, status, entity];
}

class Equatable {
}


