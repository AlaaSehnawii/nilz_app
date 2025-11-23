

import 'package:nilz_app/core/resource/cubit_status_manager.dart';
import 'package:nilz_app/feature/dashboard/res_statistics/domain/entity/response/res_statistics_entity.dart';

class ResStatisticsState extends Equatable {
  final String error;
  final CubitStatus status;
  final ResStatisticsResponseEntity entity;

  ResStatisticsState(
      {required this.error, required this.status, required this.entity});

  factory ResStatisticsState.initail() {
    return ResStatisticsState(
      error: '',
      status: CubitStatus.initial,
      entity: ResStatisticsResponseEntity(),
    );
  }

  ResStatisticsState copyWith(
      {String? error,
      CubitStatus? status,
        ResStatisticsResponseEntity? entity}) {
    return ResStatisticsState(
        error: error ?? this.error,
        status: status ?? this.status,
        entity: entity ?? this.entity);
  }

  List<Object> get props => [error, status, entity];
}

class Equatable {
}
