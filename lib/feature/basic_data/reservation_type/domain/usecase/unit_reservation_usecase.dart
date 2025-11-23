import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/api_error/api_failures.dart';
import 'package:nilz_app/feature/basic_data/data/repository/basic_data_repository.dart';
import '../entity/Reservation_type_entity.dart';

class ReservationTypeUseCase {
  final BasicDataRepository repository;
  ReservationTypeUseCase({
    required this.repository,
  });
  Future<Either<ApiFailure, ReservationTypesApiResponseEntity>> call() {
  return repository.getReservationType();
  }
}

