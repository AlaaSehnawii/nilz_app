import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/api_error/api_failures.dart';
import 'package:nilz_app/feature/basic_data/data/repository/basic_data_repository.dart';
import '../entity/place_type_entity.dart';

class PlaceTypeUseCase {
  final BasicDataRepository repository;
  PlaceTypeUseCase({
    required this.repository,
  });
  Future<Either<ApiFailure, PlaceTypesApiResponseEntity>> call() {
  return repository.getPlaceType();
  }
}

