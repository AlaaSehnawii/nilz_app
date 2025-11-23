import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/api_error/api_failures.dart';
import 'package:nilz_app/feature/basic_data/data/repository/basic_data_repository.dart';
import '../entity/city_entity.dart';

class CityUseCase {
  final BasicDataRepository repository;
  CityUseCase({
    required this.repository,
  });
  Future<Either<ApiFailure, CitiesApiResponseEntity>> call() {
  return repository.getCity();
  }
}

