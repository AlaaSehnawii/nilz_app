import 'package:nilz_app/core/resource/cubit_status_manager.dart';
import '../../domain/entity/gift_entity.dart';

class GiftState extends Equatable {
  final String error;
  final CubitStatus status;
  final GiftApiResponseEntity entity;

  GiftState({
    required this.error,
    required this.status,
    required this.entity,
  });

  factory GiftState.initial() {
    return GiftState(
      error: '',
      status: CubitStatus.initial,
      entity: GiftApiResponseEntity(),
    );
  }

  GiftState copyWith({
    String? error,
    CubitStatus? status,
    GiftApiResponseEntity? entity,
  }) {
    return GiftState(
      error: error ?? this.error,
      status: status ?? this.status,
      entity: entity ?? this.entity,
    );
  }

  List<Object> get props => [error, status, entity];
}

class Equatable {}
