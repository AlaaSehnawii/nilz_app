import 'package:nilz_app/core/resource/cubit_status_manager.dart';
import '../../domain/entity/city_entity.dart';

class CityState extends Equatable {
  final String error;
  final CubitStatus status;
  final CitiesApiResponseEntity entity;

  CityState({required this.error, required this.status, required this.entity});

  factory CityState.initial() {
    return CityState(
      error: '',
      status: CubitStatus.initial,
      entity: CitiesApiResponseEntity(),
    );
  }

  CityState copyWith({
    String? error,
    CubitStatus? status,
    CitiesApiResponseEntity? entity,
  }) {
    return CityState(
      error: error ?? this.error,
      status: status ?? this.status,
      entity: entity ?? this.entity,
    );
  }

  List<Object> get props => [error, status, entity];
}

class Equatable {}
