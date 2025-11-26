import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/api_error/api_failures.dart';
import '../entity/response/post_entity.dart';
import '../repository/post_repository.dart';

class PostUseCase {
  final PostRepository repository;
  PostUseCase({
    required this.repository,
  });
  Future<Either<ApiFailure, PostsApiResponseEntity>> call() {
  return repository.getPost();
  }
}

