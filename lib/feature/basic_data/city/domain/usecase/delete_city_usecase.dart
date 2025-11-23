import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/api_error/api_failures.dart';
import 'package:nilz_app/feature/basic_data/data/repository/basic_data_repository.dart';


class DeleteCityUseCase{
  final BasicDataRepository repository;

  DeleteCityUseCase( {required this.repository});

  Future<Either<ApiFailure, bool>> call(String id) {
    return repository.deleteCity(id);
  }

}