import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/api_error/api_failures.dart';
import 'package:nilz_app/feature/drawer/basic_data/data/repository/basic_data_repository.dart';
import 'package:nilz_app/feature/drawer/basic_data/reservation_type/domain/entity/reservation_type_entity.dart';

class ReservationTypeUseCase {
  final BasicDataRepository repository;
  ReservationTypeUseCase({
    required this.repository,
  });
  Future<Either<ApiFailure, ReservationTypesApiResponseEntity>> call() {
  return repository.getReservationType();
  }
}

