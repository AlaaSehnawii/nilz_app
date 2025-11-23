import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/api_error/api_failures.dart';
import 'package:nilz_app/feature/basic_data/data/repository/basic_data_repository.dart';
import '../entity/bed_type_entity.dart';

class BedTypeUseCase {
  final BasicDataRepository repository;
  BedTypeUseCase({
    required this.repository,
  });
  Future<Either<ApiFailure, BedTypesApiResponseEntity>> call() {
  return repository.getBedType();
  }
}

