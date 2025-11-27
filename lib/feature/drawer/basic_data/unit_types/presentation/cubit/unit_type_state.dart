import 'package:nilz_app/core/resource/cubit_status_manager.dart';
import '../../domain/entity/unit_type_entity.dart';

class UnitTypeState extends Equatable {
  final String error;
  final CubitStatus status;
  final UnitTypesApiResponseEntity entity;

  UnitTypeState({
    required this.error,
    required this.status,
    required this.entity,
  });

  factory UnitTypeState.initial() {
    return UnitTypeState(
      error: '',
      status: CubitStatus.initial,
      entity: UnitTypesApiResponseEntity(),
    );
  }

  UnitTypeState copyWith({
    String? error,
    CubitStatus? status,
    UnitTypesApiResponseEntity? entity,
  }) {
    return UnitTypeState(
      error: error ?? this.error,
      status: status ?? this.status,
      entity: entity ?? this.entity,
    );
  }

  List<Object> get props => [error, status, entity];
}

class Equatable {}
