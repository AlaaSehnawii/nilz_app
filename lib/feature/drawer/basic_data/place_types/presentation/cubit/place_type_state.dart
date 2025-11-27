

import 'package:nilz_app/core/resource/cubit_status_manager.dart';
import '../../domain/entity/place_type_entity.dart';

class PlaceTypeState extends Equatable {
  final String error;
  final CubitStatus status;
  final PlaceTypesApiResponseEntity entity;

  PlaceTypeState(
      {required this.error, required this.status, required this.entity});

  factory PlaceTypeState.initial() {
    return PlaceTypeState(
      error: '',
      status: CubitStatus.initial,
      entity: PlaceTypesApiResponseEntity(),
    );
  }

  PlaceTypeState copyWith(
      {String? error,
      CubitStatus? status,
        PlaceTypesApiResponseEntity? entity}) {
    return PlaceTypeState(
        error: error ?? this.error,
        status: status ?? this.status,
        entity: entity ?? this.entity);
  }

  List<Object> get props => [error, status, entity];
}

class Equatable {
}
