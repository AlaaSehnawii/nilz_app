import 'package:nilz_app/core/resource/cubit_status_manager.dart';
import 'package:nilz_app/feature/reservation/domain/entity/response/unit_entity.dart';

class UnitState extends Equatable {
  final String error;
  final CubitStatus status;
  final int count;
  final List<UnitEntity> entity;

  final CubitStatus detailsStatus;
  final String detailsError;
  final UnitEntity? unitDetails;

  UnitState({
    required this.error,
    required this.status,
    required this.entity,
    required this.count,
    required this.detailsStatus,
    required this.detailsError,
    this.unitDetails,
  });

  factory UnitState.initial() {
    return UnitState(
      error: '',
      status: CubitStatus.initial,
      entity: [],
      count: 0,
      detailsStatus: CubitStatus.initial,
      detailsError: '',
      unitDetails: null,
    );
  }

  UnitState copyWith({
    String? error,
    CubitStatus? status,
    List<UnitEntity>? entity,
    int? count,
    CubitStatus? detailsStatus,
    String? detailsError,
    UnitEntity? unitDetails,
  }) {
    return UnitState(
      error: error ?? this.error,
      status: status ?? this.status,
      entity: entity ?? this.entity,
      count: count ?? this.count,
      detailsStatus: detailsStatus ?? this.detailsStatus,
      detailsError: detailsError ?? this.detailsError,
      unitDetails: unitDetails ?? this.unitDetails,
    );
  }

  List<Object> get props => [
    error,
    status,
    entity,
    count,
    detailsStatus,
    detailsError,
    ?unitDetails,
  ];
}

class Equatable {}
