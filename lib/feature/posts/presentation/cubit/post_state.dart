import 'package:nilz_app/core/resource/cubit_status_manager.dart';
import '../../domain/entity/response/post_entity.dart';

class PostState extends Equatable {
  final String error;
  final CubitStatus status;
  final PostsApiResponseEntity entity;

  PostState({
    required this.error,
    required this.status,
    required this.entity,
  });

  factory PostState.initial() {
    return PostState(
      error: '',
      status: CubitStatus.initial,
      entity: PostsApiResponseEntity(),
    );
  }

  PostState copyWith({
    String? error,
    CubitStatus? status,
    PostsApiResponseEntity? entity,
  }) {
    return PostState(
      error: error ?? this.error,
      status: status ?? this.status,
      entity: entity ?? this.entity,
    );
  }

  List<Object> get props => [error, status, entity];
}

class Equatable {}
