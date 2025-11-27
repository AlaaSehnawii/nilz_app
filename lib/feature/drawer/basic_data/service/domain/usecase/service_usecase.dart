import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/api_error/api_failures.dart';
import 'package:nilz_app/feature/drawer/basic_data/data/repository/basic_data_repository.dart';
import 'package:nilz_app/feature/drawer/basic_data/service/domain/entity/service_entity.dart';

class ServiceUseCase {
  final BasicDataRepository repository;
  ServiceUseCase({
    required this.repository,
  });
  Future<Either<ApiFailure, ServicesApiResponseEntity>> call() {
  return repository.getService();
  }
}

