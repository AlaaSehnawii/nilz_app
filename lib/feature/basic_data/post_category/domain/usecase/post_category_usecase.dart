import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/api_error/api_failures.dart';
import 'package:nilz_app/feature/basic_data/data/repository/basic_data_repository.dart';
import '../entity/post_category_entity.dart';

class PostCategoryUseCase {
  final BasicDataRepository repository;
  PostCategoryUseCase({
    required this.repository,
  });
  Future<Either<ApiFailure, PostCategoryResponseEntity>> call() {
  return repository.getPostCategory();
  }
}

