import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/api_error/api_failures.dart';
import '../entity/response/reservation_entity.dart';
import '../repository/reservation_repository.dart';

class ReservationUseCase {
  final ReservationRepository repository;
  ReservationUseCase({
    required this.repository,
  });
  Future<Either<ApiFailure, ReservationListResponseEntity>> call() {
  return repository.getReservation();
  }
}

