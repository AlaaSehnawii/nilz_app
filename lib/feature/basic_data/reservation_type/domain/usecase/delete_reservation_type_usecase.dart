import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/api_error/api_failures.dart';
import 'package:nilz_app/feature/basic_data/data/repository/basic_data_repository.dart';

class DeleteReservationTypeUseCase{
  final BasicDataRepository repository;

  DeleteReservationTypeUseCase( {required this.repository});

  Future<Either<ApiFailure, bool>> call(String id) {
    return repository.deleteReservationType(id);
  }

}