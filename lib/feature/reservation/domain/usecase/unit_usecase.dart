import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/api_error/api_failures.dart';
import 'package:nilz_app/feature/reservation/domain/entity/response/unit_entity.dart';
import '../repository/reservation_repository.dart';

class UnitUseCase {
  final ReservationRepository repository;

  UnitUseCase({required this.repository});

  Future<Either<ApiFailure, UnitApiResponseEntity>> call({
    required String cityId,
    required String toStartTimeIso,
    required String toEndTimeIso,
    required List<Map<String, dynamic>> roomConfig,
  }) {
    return repository.getUnitChildren(
      cityId: cityId,
      roomConfig: roomConfig,
      toEndTimeIso: toEndTimeIso,
      toStartTimeIso: toStartTimeIso,
    );
  }
}
