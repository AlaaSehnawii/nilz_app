import 'package:dartz/dartz.dart';
import 'package:nilz_app/core/api/api_error/api_failures.dart';
import 'package:nilz_app/feature/reservation/domain/entity/response/unit_entity.dart';
import '../repository/reservation_repository.dart';

class UnitUseCase {
  final ReservationRepository repository;

  UnitUseCase({required this.repository});

  Future<Either<ApiFailure, UnitEntity>> call({
    required String unitId,
    required String toStartTimeIso,
    required String toEndTimeIso,
  }) {
    return repository.getUnitDetails(
      unitId: unitId,
      toStartTimeIso: toStartTimeIso,
      toEndTimeIso: toEndTimeIso,
    );
  }
}
