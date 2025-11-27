import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/api_error/api_failures.dart';
import 'package:nilz_app/feature/drawer/basic_data/data/repository/basic_data_repository.dart';

class DeleteUnitTypeUseCase{
  final BasicDataRepository repository;

  DeleteUnitTypeUseCase( {required this.repository});

  Future<Either<ApiFailure, bool>> call(String id) {
    return repository.deleteUnitType(id);
  }

}