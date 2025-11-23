import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/api_error/api_failures.dart';
import 'package:nilz_app/feature/basic_data/unit_types/domain/entity/unit_type_entity.dart';
import 'package:nilz_app/feature/basic_data/data/repository/basic_data_repository.dart';

class UnitTypeUseCase {
  final BasicDataRepository repository;
  UnitTypeUseCase({
    required this.repository,
  });
  Future<Either<ApiFailure, UnitTypesApiResponseEntity>> call() {
    return repository.getUnitType();
  }
}

