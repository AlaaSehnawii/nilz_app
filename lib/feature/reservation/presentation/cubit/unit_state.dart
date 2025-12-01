import 'package:nilz_app/core/resource/cubit_status_manager.dart';
import 'package:nilz_app/feature/reservation/domain/entity/response/unit_entity.dart';

class UnitState extends Equatable {
  final String error;
  final CubitStatus status;
  final int count;
  final List<UnitEntity> entity;

  UnitState({
    required this.error,
    required this.status,
    required this.entity,
    required this.count,
  });

  factory UnitState.initial() {
    return UnitState(
      error: '',
      status: CubitStatus.initial,
      entity: [],
      count: 0,
    );
  }

  UnitState copyWith({
    String? error,
    CubitStatus? status,
    List<UnitEntity>? entity,
    int? count,
  }) {
    return UnitState(
      error: error ?? this.error,
      status: status ?? this.status,
      entity: entity ?? this.entity,
      count: count ?? this.count,
    );
  }

  List<Object> get props => [error, status, entity, count];
}

class Equatable {}
