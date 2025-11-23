

import 'package:nilz_app/core/resource/cubit_status_manager.dart';
import '../../domain/entity/response/pending_req_entity.dart';

class PendingRequestState extends Equatable {
  final String error;
  final CubitStatus status;
  final PendingRequestResponseEntity entity;

  PendingRequestState(
      {required this.error, required this.status, required this.entity});

  factory PendingRequestState.initail() {
    return PendingRequestState(
      error: '',
      status: CubitStatus.initial,
      entity: PendingRequestResponseEntity(),
    );
  }

  PendingRequestState copyWith(
      {String? error,
      CubitStatus? status,
        PendingRequestResponseEntity? entity}) {
    return PendingRequestState(
        error: error ?? this.error,
        status: status ?? this.status,
        entity: entity ?? this.entity);
  }

  List<Object> get props => [error, status, entity];
}

class Equatable {
}
