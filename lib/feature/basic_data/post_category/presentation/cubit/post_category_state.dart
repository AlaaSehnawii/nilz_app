import 'package:nilz_app/core/resource/cubit_status_manager.dart';

import '../../domain/entity/post_category_entity.dart';

class PostCategoryState extends Equatable {
  final String error;
  final CubitStatus status;
  final PostCategoryResponseEntity entity;

  PostCategoryState({
    required this.error,
    required this.status,
    required this.entity,
  });

  factory PostCategoryState.initial() {
    return PostCategoryState(
      error: '',
      status: CubitStatus.initial,
      entity: PostCategoryResponseEntity(),
    );
  }

  PostCategoryState copyWith({
    String? error,
    CubitStatus? status,
    PostCategoryResponseEntity? entity,
  }) {
    return PostCategoryState(
      error: error ?? this.error,
      status: status ?? this.status,
      entity: entity ?? this.entity,
    );
  }

  List<Object> get props => [error, status, entity];
}

class Equatable {}
