import 'package:nilz_app/core/resource/cubit_status_manager.dart';
import '../../domain/entity/room_type_entity.dart';

class RoomTypeState extends Equatable {
  final String error;
  final CubitStatus status;
  final RoomTypesApiResponseEntity entity;

  RoomTypeState({
    required this.error,
    required this.status,
    required this.entity,
  });

  factory RoomTypeState.initial() {
    return RoomTypeState(
      error: '',
      status: CubitStatus.initial,
      entity: RoomTypesApiResponseEntity(),
    );
  }

  RoomTypeState copyWith({
    String? error,
    CubitStatus? status,
    RoomTypesApiResponseEntity? entity,
  }) {
    return RoomTypeState(
      error: error ?? this.error,
      status: status ?? this.status,
      entity: entity ?? this.entity,
    );
  }

  List<Object> get props => [error, status, entity];
}

class Equatable {}
