import 'package:nilz_app/core/resource/cubit_status_manager.dart';
import 'package:nilz_app/feature/drawer/basic_data/service/domain/entity/service_entity.dart';

class ServiceState extends Equatable {
  final String error;
  final CubitStatus status;
  final ServicesApiResponseEntity entity;

  ServiceState({
    required this.error,
    required this.status,
    required this.entity,
  });

  factory ServiceState.initial() {
    return ServiceState(
      error: '',
      status: CubitStatus.initial,
      entity: ServicesApiResponseEntity(),
    );
  }

  ServiceState copyWith({
    String? error,
    CubitStatus? status,
    ServicesApiResponseEntity? entity,
  }) {
    return ServiceState(
      error: error ?? this.error,
      status: status ?? this.status,
      entity: entity ?? this.entity,
    );
  }

  List<Object> get props => [error, status, entity];
}

class Equatable {}
