import 'package:nilz_app/core/resource/cubit_status_manager.dart';
import '../../domain/entity/bed_type_entity.dart';

class BedTypeState extends Equatable {
  final String error;
  final CubitStatus status;
  final BedTypesApiResponseEntity entity;

  BedTypeState({
    required this.error,
    required this.status,
    required this.entity,
  });

  factory BedTypeState.initial() {
    return BedTypeState(
      error: '',
      status: CubitStatus.initial,
      entity: BedTypesApiResponseEntity(),
    );
  }

  BedTypeState copyWith({
    String? error,
    CubitStatus? status,
    BedTypesApiResponseEntity? entity,
  }) {
    return BedTypeState(
      error: error ?? this.error,
      status: status ?? this.status,
      entity: entity ?? this.entity,
    );
  }

  List<Object> get props => [error, status, entity];
}

class Equatable {}
